//
//  JoinService.swift
//  RunUs
//
//  Created by byeoungjik on 10/1/24.
//

import Foundation
import KeychainSwift

class JoinService: ObservableObject {
    
    let keychain = KeychainSwift()
    let baseUrl = "http://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "nil baseUrl")"
    let idToken = UserDefaults.standard.integer(forKey: "idToken")
    @Published var joinMemberInfo: MemberInfo?
    
    func joinMembership(inputNickName: String, inputEmail: String, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "\(baseUrl)/auth/users")!
        let headers = ["Content-Type": "application/json"]
        
        let joinData = ["nickName": inputNickName, "email": inputEmail]
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "POST"
        
        do {
            let jsonData = try JSONEncoder().encode(joinData)
            request.httpBody = jsonData
        } catch {
            print("Error encoding JSON: \(error)")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Network request failed: \(error?.localizedDescription ?? "No error info")")
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let response = try JSONDecoder().decode(MemberInfo.self, from: data)
                    DispatchQueue.main.async {
                        self.joinMemberInfo = response
                        print("publicId : " + response.publicId)
                        completion(true)
                    }
                } catch {
                    print("Failed to decode JSON response: \(error)")
                    completion(false)
                }
            } else {
                print("HTTP Status Code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                completion(false)
            }
        }.resume()
        
    }
}
