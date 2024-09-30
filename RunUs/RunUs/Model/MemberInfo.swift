//
//  MemberInfo.swift
//  RunUs
//
//  Created by byeoungjik on 10/1/24.
//

import Foundation

struct MemberInfo: Codable {
    let createdAt: String
    let updatedAt: String
    let id: Int
    let publicId: String
    let nickname: String
    let birthDate: String?
    let gender: String?
    let imgUrl: String?
    let deletedAt: String?
}

