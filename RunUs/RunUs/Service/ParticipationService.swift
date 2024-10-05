//
//  ParticipationService.swift
//  RunUs
//
//  Created by byeoungjik on 10/1/24.
//

import Foundation
import KeychainSwift

class ParticipationService: ObservableObject {
    
    let baseUrl = "http://\(Bundle.main.infoDictionary?["BASE_URL"] as? String ?? "nil baseUrl")"
    @Published var participantInfo: ParticipationResponse?
    @Published var participantNames: [String] = []
    
    let keychain = KeychainSwift()
    
    
    func getParticipantList(runningId: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(baseUrl)/runnings/\(runningId)/participants") else {
            completion(false)
            return
        }
        let jwtToken = keychain.get("accessToken") ?? ""
        var request = URLRequest(url: url)
        request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(false)
                }
                return
            }
            do {
                let decodedResponse = try JSONDecoder().decode(ParticipationResponse.self, from: data)
                DispatchQueue.main.async {
                    if decodedResponse.success {
                        print("getParticipantList || Response success: \(decodedResponse.success)")
                        self.participantInfo = decodedResponse
                        print("========== Participants List ==========")
                        self.participantNames = decodedResponse.payload?.map { $0.name } ?? []
                        print("getParticipantList || \(self.participantNames)")
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }.resume()
    }
}
