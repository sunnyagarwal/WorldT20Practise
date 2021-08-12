//
//  TeamDetails.swift
//  WorldT20App
//
//  Created by Sunny Agarwal on 11/08/21.
//

import Foundation

class TeamDetails: Codable {
    var teamName: String
    var teamFlag: String
    
    enum CodingKeys: String, CodingKey {
        case teamName = "name"
        case teamFlag = "flag"
    }
}

