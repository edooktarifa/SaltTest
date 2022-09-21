//
//  BaseViewController.swift
//  SaltTest
//
//  Created by Phincon on 21/09/22.
//

import UIKit
import NVActivityIndicatorView

class BaseViewController: UIViewController {

    let loading = NVActivityIndicatorView(frame: .zero, type: .ballRotateChase, color: UIColor.red)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoading()
    }
    
    func setupLoading(){
        self.loading.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.loading)
        
        NSLayoutConstraint.activate([
            self.loading.widthAnchor.constraint(equalToConstant: 40),
            self.loading.heightAnchor.constraint(equalToConstant: 40),
            self.loading.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.loading.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
    
    func logoutButton(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "LogOut",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(rightHandAction))
    }
    
    @objc func rightHandAction() {
        Prefs.removeData(.login)
        self.loading.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.loading.stopAnimating()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Error", message: "Missing password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        present(alert, animated: true)
    }
}

