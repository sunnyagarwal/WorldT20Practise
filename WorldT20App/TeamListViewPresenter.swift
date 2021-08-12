//
//  TeamListViewPresenter.swift
//  WorldT20App
//
//  Created by Sunny Agarwal on 11/08/21.
//

import Foundation

//
//  MatchScorePresenter.swift
//  WorldT20App
//
//  Created by Sunny Agarwal on 11/08/21.
//

import Foundation

protocol TeamListViewPresenterDelegate: AnyObject {
    func updateTeamDataFromApi(teamList: [Team])
}

class TeamListViewPresenter {
    var teamArray: [Team] = []
    weak internal var delegate: TeamListViewPresenterDelegate?
    let service: ApiService = ApiService()
    
    init() {
        service.apiServiceDelegate = self
    }
}

extension TeamListViewPresenter: TeamListControllerDelegate {
    func getTeamDetailsDataFromApi() {
        service.getTeamListData(urlString: "https://jsonkeeper.com/b/27UM")
    }
}

extension TeamListViewPresenter: ApiDataReceiverDelegate {
    func receivedDataFromApi(teamArray: [Team]) {
        if teamArray.count > 0 {
            self.teamArray = teamArray
            self.delegate?.updateTeamDataFromApi(teamList: teamArray)
        }
    }
}
