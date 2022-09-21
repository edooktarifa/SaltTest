//
//  ViewController.swift
//  SaltTest
//
//  Created by Phincon on 20/09/22.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var loginBtnTf: UIButton!{
        didSet{
            loginBtnTf.layer.cornerRadius = loginBtnTf.frame.height / 2
        }
    }
    
    let disposeBag = DisposeBag()
    var vm = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    
    func setupView(){
        loginBtnTf.isEnabled = false
        loginBtnTf.backgroundColor = UIColor.systemGray
        passwordTf.enablePasswordToggle()
        
        setupValidationView()
        loginBtnTf.rx.tap.subscribe(onNext: {
            [weak self] in
            self?.loading.startAnimating()
            guard let email = self?.emailTf.text, let password = self?.passwordTf.text else { return }
            self?.vm.loginDidPress(param: ["username": "", "email": email, "password": password])
            
        }).disposed(by: disposeBag)
        
        vm.getLoadingStatus.drive(onNext: {
            [weak self] _ in
            self?.loading.stopAnimating()
        }).disposed(by: disposeBag)
        
        vm.errorStatus.drive(onNext: {
            [weak self] error in
            
            if error == true {
                self?.showAlert()
            } else {
                let vc = HomeViewController()
                let navController = UINavigationController(rootViewController: vc)
                navController.modalPresentationStyle = .fullScreen
                self?.present(navController, animated: true)
            }
            
        }).disposed(by: disposeBag)
    }
    
    func setupValidationView(){
        let userEmailTf = emailTf.rx.text
            .orEmpty
            .skip(1)
            .map{ !$0.isEmpty}
        
        let passwordTf = passwordTf.rx.text
            .orEmpty
            .skip(1)
            .map{ !$0.isEmpty }
        
        let validateField = Observable.combineLatest(userEmailTf, passwordTf){
            email, password in
            email && password
        }
        
        validateField.subscribe(onNext: {
            isValid in
            
            if (isValid) {
                self.loginBtnTf.isEnabled = true
                self.loginBtnTf.backgroundColor = UIColor.systemRed
            } else {
                self.loginBtnTf.isEnabled = false
                self.loginBtnTf.backgroundColor = UIColor.systemGray
            }
            
        }).disposed(by: disposeBag)
    }
}

