//
//  ApiService.swift
//  WorldT20App
//
//  Created by Sunny Agarwal on 11/08/21.
//

import Foundation

class ApiService: NSObject {
    
    weak var apiServiceDelegate: ApiDataReceiverDelegate?
    
    func getTeamListData(urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let session: URLSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        let task: URLSessionDataTask = session.dataTask(with: request)
        task.resume()
    }
}

extension ApiService: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        let decoder = JSONDecoder()
        var teamList: [Team] = []
        do {
            let teamDetailsArray: [TeamDetails] = try decoder.decode([TeamDetails].self, from: data)
            for eachDetails in teamDetailsArray {
                let eachTeam: Team = Team()
                eachTeam.teamDetails = eachDetails
                teamList.append(eachTeam)
            }
            
        } catch(let error1) {
            print(error1)
        }
        apiServiceDelegate?.receivedDataFromApi(teamArray: teamList)
    }
}
