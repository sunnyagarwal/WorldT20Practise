//
//  TeamView.swift
//  WorldT20App
//
//  Created by Sunny Agarwal on 11/08/21.
//

import UIKit

class TeamView: UIView {
    
    @IBOutlet weak var teamHeaderLabel: UILabel!

    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet weak var oversLabel: UILabel!
    
    @IBOutlet weak var flagImage: UIImageView!
    
    override func awakeFromNib() {
           super.awakeFromNib()
    }
    
    //Variables
    class func instanceFromNib() -> TeamView {
        guard let view: TeamView = UINib(nibName: "TeamView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? TeamView else {
            return TeamView()
        }
        return view
    }

}

