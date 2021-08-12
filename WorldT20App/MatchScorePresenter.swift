//
//  MatchScorePresenter.swift
//  WorldT20App
//
//  Created by Sunny Agarwal on 11/08/21.
//

import Foundation

enum PossibleOutcome: UInt32 {
    case zero
    case one
    case two
    case three
    case four
    case six
    case wicket
    
    private static let _count: PossibleOutcome.RawValue = {
        // find the maximum enum value
        var maxValue: UInt32 = 0
        while let _ = PossibleOutcome(rawValue: maxValue) {
            maxValue += 1
        }
        return maxValue
    }()
    
    static func randomGeometry() -> PossibleOutcome {
        // pick and return a new value
        let rand = arc4random_uniform(_count)
        return PossibleOutcome(rawValue: rand)!
    }
    
}

protocol MatchScoreViewLayer: AnyObject {
    func updateTeamDataFromApi(firstTeam: Team, secondTeam: Team, text: String)
}

protocol ApiDataReceiverDelegate: AnyObject {
    func receivedDataFromApi(teamArray: [Team])
}

class MatchScorePresenter {
    weak internal var scoreViewLayer: MatchScoreViewLayer?
    var firstTeam: Team = Team()
    var secondTeam: Team = Team()
    var scorecardText: String = "Match Yet to start"
    let service: ApiService = ApiService()
    
    init(firstTeam: Team, secondTeam: Team) {
        service.apiServiceDelegate = self
        self.firstTeam = firstTeam
        self.secondTeam = secondTeam
    }
}

extension MatchScorePresenter: MatchScorePresenterDelegate {
    func getTeamDetailsDataFromApi() {
        //service.getTeamListData(urlString: "https://jsonkeeper.com/b/27UM")
        self.scoreViewLayer?.updateTeamDataFromApi(firstTeam: self.firstTeam, secondTeam: self.secondTeam, text: self.scorecardText)
    }
    
    func playNextBallIsCliecked() {
        updateTeamsData()
    }
}

extension MatchScorePresenter: ApiDataReceiverDelegate {
    func receivedDataFromApi(teamArray: [Team]) {
        if teamArray.count > 1 {
            self.firstTeam = teamArray[0]
            self.secondTeam = teamArray[1]
            self.secondTeam.teamStatus = .Bowling
            self.scoreViewLayer?.updateTeamDataFromApi(firstTeam: self.firstTeam, secondTeam: self.secondTeam, text: self.scorecardText)
        }
    }
}


//Utils method

extension MatchScorePresenter {
    func updateTeamsData() {
            let battingTeam: Team = firstTeam.teamStatus == .Batting ? firstTeam : secondTeam
            var _: Team = firstTeam.teamStatus == .Bowling ? firstTeam : secondTeam
            switch PossibleOutcome.randomGeometry() {
            case .zero:
                battingTeam.bowlsBowled += 1
                battingTeam.runsScored += 0
                scorecardText = "0"
            case .one:
                battingTeam.bowlsBowled += 1
                battingTeam.runsScored += 1
                scorecardText = "1"
            case .two:
                battingTeam.bowlsBowled += 1
                battingTeam.runsScored += 2
                scorecardText = "2"
            case .three:
                battingTeam.bowlsBowled += 1
                battingTeam.runsScored += 3
                scorecardText = "3"
            case .four:
                battingTeam.bowlsBowled += 1
                battingTeam.runsScored += 4
                scorecardText = "4"
            case .six:
                battingTeam.bowlsBowled += 1
                battingTeam.runsScored += 6
                scorecardText = "6"
            case .wicket:
                battingTeam.wicketsLost += 1
                battingTeam.bowlsBowled += 1
                scorecardText = "Wicket"
            }
        self.scoreViewLayer?.updateTeamDataFromApi(firstTeam: firstTeam, secondTeam: secondTeam, text: scorecardText)
        checkMatchStatus()
    }
    
    func checkMatchStatus() {
        if (firstTeam.bowlsBowled == 12 || firstTeam.wicketsLost == 3) && secondTeam.bowlsBowled == 0{
            firstTeam.teamStatus = .Bowling
            secondTeam.teamStatus = .Batting
        }
        
        if secondTeam.runsScored > firstTeam.runsScored {
            self.scoreViewLayer?.updateTeamDataFromApi(firstTeam: firstTeam, secondTeam: secondTeam, text: "\(secondTeam.teamDetails?.teamName ?? "") won")
        }
        if (secondTeam.bowlsBowled == 12 || secondTeam.wicketsLost == 3) && firstTeam.runsScored > secondTeam.runsScored {
            self.scoreViewLayer?.updateTeamDataFromApi(firstTeam: firstTeam, secondTeam: secondTeam, text: "\(firstTeam.teamDetails?.teamName ?? "") won")
        }
    }
}
