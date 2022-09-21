//
//  DetailViewController.swift
//  SaltTest
//
//  Created by Phincon on 21/09/22.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var detailNameLbl: UILabel!
    @IBOutlet weak var detailEmailLbl: UILabel!
    @IBOutlet weak var detailImg: UIImageView!
    
    var data: DataUserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let data = data {
            detailNameLbl.text = data.first_name
            detailEmailLbl.text = data.email
            detailImg.kf.setImage(with: URL(string: data.avatar ?? ""))
        }
    }
}
