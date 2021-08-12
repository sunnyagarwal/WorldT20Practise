//
//  TeamListViewController.swift
//  WorldT20App
//
//  Created by Sunny Agarwal on 11/08/21.
//

import UIKit

protocol TeamListControllerDelegate: AnyObject {
    func getTeamDetailsDataFromApi()
}

class TeamListViewController: UIViewController {
    
    @IBOutlet weak var teamListView: UICollectionView!
    
    var teamListPresenter: TeamListViewPresenter = TeamListViewPresenter()
    
    var teamArray: [Team] = []
    
    var selectedIndexArray: [Int] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        teamListView.register(UINib(nibName: "TeamListCell", bundle: nil), forCellWithReuseIdentifier: "TeamListCell")
        teamListPresenter.getTeamDetailsDataFromApi()
        teamListPresenter.delegate = self
        // Do any additional setup after loading the view.
    }
    
    private func moveToNextScreen() {
        if teamArray.count > selectedIndexArray[0] && teamArray.count > selectedIndexArray[1] {
            let matchScoreVC: ViewController? = self.storyboard?.instantiateViewController(identifier: "SecondVC") as? ViewController
            let matchScorePresenter: MatchScorePresenter = MatchScorePresenter(firstTeam: teamArray[selectedIndexArray[0]], secondTeam: teamArray[selectedIndexArray[1]])
            matchScoreVC?.matchScorePresenter = matchScorePresenter
            self.navigationController?.pushViewController(matchScoreVC!, animated: true)
        }
    }

}

extension TeamListViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teamArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let teamListCell: TeamListCell = teamListView.dequeueReusableCell(withReuseIdentifier: "TeamListCell", for: indexPath) as! TeamListCell
        teamListCell.teamName.text = teamArray[indexPath.row].teamDetails?.teamName
        if let firstFlagString = teamArray[indexPath.row].teamDetails?.teamFlag, let firstImageUrl: URL = URL(string: firstFlagString) {
            let data:Data = try! Data.init(contentsOf: firstImageUrl, options: .alwaysMapped)
            teamListCell.flagImage.image = UIImage(data: data)
        }
        return teamListCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexArray.append(indexPath.row)
        if selectedIndexArray.count == 2 {
            self.moveToNextScreen()
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let tableCell: TeamListCell = teamListView.cellForRow(at: indexPath) as! TeamListCell
//        tableCell.accessoryType = tableCell.accessoryType == .checkmark ? .none : .checkmark
//        selectedIndexArray.append(indexPath.row)
//        if selectedIndexArray.count == 2 {
//            self.moveToNextScreen()
//        }
//        //self.moveToNextScreen()
//    }
}

extension TeamListViewController: TeamListViewPresenterDelegate {
    func updateTeamDataFromApi(teamList: [Team]) {
        DispatchQueue.main.async {
            self.teamArray = teamList
            self.teamListView.reloadData()
        }
    }
}
