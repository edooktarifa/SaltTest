//
//  UnknowUserCollectionViewCell.swift
//  SaltTest
//
//  Created by Phincon on 20/09/22.
//

import UIKit
import Kingfisher

class UnknowUserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setConent(data: DataUserModel){
        userAvatar.kf.setImage(with: URL(string: data.avatar ?? ""))
        userName.text = data.first_name
        userEmail.text = data.email
    }
    
    
}

