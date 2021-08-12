//
//  Team.swift
//  WorldT20App
//
//  Created by Sunny Agarwal on 11/08/21.
//

import Foundation

enum TeamStatus: String {
    case Batting
    case Bowling
}

class Team {
    var teamDetails: TeamDetails?
    var teamStatus: TeamStatus = .Batting
    var runsScored: Int = 0
    var bowlsBowled: Int = 0
    var wicketsLost: Int = 0
    
    init() {
    }
    
    func getScoreText() -> String {
        var scoreText: String = ""
        if teamStatus == .Batting || bowlsBowled == 12 || wicketsLost == 3 {
            scoreText = "Score: \(runsScored)/\(wicketsLost)"
        } else {
            scoreText = "Yet to bat"
        }
        return scoreText
    }
    
    func getOversText() -> String {
        if teamStatus == .Batting  || bowlsBowled == 12 || wicketsLost == 3 {
            var oversText: String = ""
            if bowlsBowled == 12 {
                oversText = "2.0"
            } else if bowlsBowled >= 6 && bowlsBowled < 12 {
                oversText = "1.\(bowlsBowled%6)"
            } else {
                oversText = "0.\(bowlsBowled)"
            }
            return oversText
        }
        return "Yet to bat"
    }
    
    func getTeamHeader() -> String {
        return "\(teamDetails?.teamName ?? "") (\(teamStatus.rawValue))"
    }
}

