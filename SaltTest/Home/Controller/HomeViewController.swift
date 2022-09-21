//
//  HomeViewController.swift
//  SaltTest
//
//  Created by Phincon on 20/09/22.
//

import UIKit
import RxSwift

class HomeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var vm = HomeViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView(){
        title = "Home"
        logoutButton()
        registerTable()
        vm.firtListUser.drive(onNext: {
            [weak self] list in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        vm.secondListUser.drive(onNext: {
            [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        vm.thirdListUser.drive(onNext: {
            [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        vm.fetchApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loading.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vm.loadingView.drive(onNext: {
            [weak self] loading in
            self?.loading.stopAnimating()
        }).disposed(by: disposeBag)
    }
    
    func registerTable(){
        tableView.register(UINib(nibName: "UnknownUserCell", bundle: nil), forCellReuseIdentifier: "UnknownUserCell")
        tableView.register(UINib(nibName: "SecondSectionTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondSectionTableViewCell")
        tableView.register(UINib(nibName: "ThirdSectionTableViewCell", bundle: nil), forCellReuseIdentifier: "ThirdSectionTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UnknownUserCell", for: indexPath) as? UnknownUserCell else { return UITableViewCell() }
            cell.data = vm.listUser.value
            cell.delegate = self
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SecondSectionTableViewCell", for: indexPath) as? SecondSectionTableViewCell else { return UITableViewCell() }
            cell.data = vm.listSecondUser.value
            cell.delegate = self
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdSectionTableViewCell", for: indexPath) as? ThirdSectionTableViewCell else { return UITableViewCell() }
            cell.data = vm.listThirdUser.value
            cell.heightCollectionView.constant = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0, 1:
            return 180
        case 2:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension HomeViewController: UnknownUserDelegate {
    func moveToDetail(data: DataUserModel) {
        let vc = DetailViewController()
        vc.data = data
        navigationController?.pushViewController(vc, animated: true)
    }
}
