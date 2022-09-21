//
//  UnknownUserCell.swift
//  SaltTest
//
//  Created by Phincon on 20/09/22.
//

import UIKit

protocol UnknownUserDelegate {
    func moveToDetail(data: DataUserModel)
}

class UnknownUserCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate: UnknownUserDelegate?
    
    var data: [DataUserModel?] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(UINib(nibName: "UnknowUserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UnknowUserCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension UnknownUserCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UnknowUserCollectionViewCell", for: indexPath) as? UnknowUserCollectionViewCell else { return UICollectionViewCell() }
        if let data = data[indexPath.row] {
            cell.setConent(data: data)
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 40) / 3.5, height: collectionView.frame.height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        guard let cell = cell as? UnknowUserCollectionViewCell else { return }
        cell.userAvatar.layer.cornerRadius = 40
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let data = data[indexPath.row] {
            delegate?.moveToDetail(data: data)
        }
    }
    
}
