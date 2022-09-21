//
//  LoginViewModel.swift
//  SaltTest
//
//  Created by Phincon on 20/09/22.
//

import Foundation
import UIKit
import Alamofire
import RxSwift
import RxCocoa

class LoginViewModel {
    
    var login = BehaviorRelay<LoginModel?>(value: nil)
    var loading = BehaviorRelay<Bool?>(value: false)
    var error = BehaviorRelay<Bool?>(value: nil)
    
    var getLoginStatus: Driver<LoginModel?> {
        return login.asDriver()
    }
    
    var getLoadingStatus: Driver<Bool?> {
        return loading.asDriver()
    }
    
    var errorStatus: Driver<Bool?>{
        return error.asDriver()
    }
    
    func loginDidPress(param: [String: String]){
        loading.accept(true)
        NetworkServices.instance.getServiceData(url: "\(Constant.baseURL)/login", method: .post, parameters: param, encodingType: JSONEncoding.default, headers: [:]) { [weak self] (login: LoginModel?, error: String?) in
            self?.loading.accept(false)
            if error != nil {
                self?.error.accept(true)
            } else {
                self?.error.accept(false)
                if let login = login {
                    Prefs.setData(.login, value: login)
                    self?.login.accept(login)
                }
            }
        }
    }
}
