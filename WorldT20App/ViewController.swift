//
//  ViewController.swift
//  WorldT20App
//
//  Created by Sunny Agarwal on 11/08/21.
//

import UIKit

protocol MatchScorePresenterDelegate: AnyObject {
    func getTeamDetailsDataFromApi()
    func playNextBallIsCliecked()
}

class ViewController: UIViewController {

    var matchScorePresenter: MatchScorePresenter!
    
    @IBOutlet weak var firstTeamView: UIView!
    
    @IBOutlet weak var secondTeamView: UIView!
    
    @IBOutlet weak var outcomeLabel: UILabel!
    
    @IBAction func playNextBall(_ sender: Any) {
        matchScorePresenter.playNextBallIsCliecked()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewUI()
        matchScorePresenter.scoreViewLayer = self
        matchScorePresenter.getTeamDetailsDataFromApi()
    }
    
    func updateViewUI() {
        let firstTeamViewData: TeamView = TeamView.instanceFromNib()
        firstTeamView.addSubview(firstTeamViewData)
        let secondTeamViewData: TeamView = TeamView.instanceFromNib()
        secondTeamView.addSubview(secondTeamViewData)
    }
 
}


extension ViewController: MatchScoreViewLayer {
    func updateTeamDataFromApi(firstTeam: Team, secondTeam: Team, text: String) {
        DispatchQueue.main.async {
            (self.firstTeamView.subviews.first as? TeamView)?.teamHeaderLabel.text = firstTeam.getTeamHeader()
            (self.firstTeamView.subviews.first as? TeamView)?.scoreLabel.text = firstTeam.getScoreText()
            (self.firstTeamView.subviews.first as? TeamView)?.oversLabel.text = firstTeam.getOversText()
            if let firstFlagString = firstTeam.teamDetails?.teamFlag, let firstImageUrl: URL = URL(string: firstFlagString) {
                let data:Data = try! Data.init(contentsOf: firstImageUrl, options: .alwaysMapped)
                (self.firstTeamView.subviews.first as? TeamView)?.flagImage.image = UIImage(data: data)
            }
            (self.secondTeamView.subviews.first as? TeamView)?.teamHeaderLabel.text = secondTeam.getTeamHeader()
            (self.secondTeamView.subviews.first as? TeamView)?.scoreLabel.text = secondTeam.getScoreText()
            (self.secondTeamView.subviews.first as? TeamView)?.oversLabel.text = secondTeam.getOversText()
            if let secondFlagString = secondTeam.teamDetails?.teamFlag, let secondImageUrl: URL = URL(string: secondFlagString) {
                let data:Data = try! Data.init(contentsOf: secondImageUrl, options: .alwaysMapped)
                (self.secondTeamView.subviews.first as? TeamView)?.flagImage.image = UIImage(data: data)
            }
            self.outcomeLabel.text = text
        }
    }
}

