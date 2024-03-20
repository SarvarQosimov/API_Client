//
//  PostModel.swift
//  TestProject_Olcha
//
//  Created by Sarvar Qosimov on 01/03/24.
//

import UIKit

typealias PostModelList = [PostModelElement]

struct PostModelElement: Codable, Hashable {
    let userID, id: Double
    let title, body: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}
