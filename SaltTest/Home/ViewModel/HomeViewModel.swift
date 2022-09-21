//
//  HomeViewModel.swift
//  SaltTest
//
//  Created by Phincon on 20/09/22.
//

import Foundation
import UIKit
import Alamofire
import RxSwift
import RxCocoa

class HomeViewModel {
    
    var listUser = BehaviorRelay<[DataUserModel?]>(value: [])
    var listSecondUser = BehaviorRelay<[DataUserModel?]>(value: [])
    var listThirdUser = BehaviorRelay<[DataUserModel?]>(value: [])
    var loading = BehaviorRelay<Bool?>(value: true)
    
    var firtListUser: Driver<[DataUserModel?]> {
        return listUser.asDriver()
    }
    
    var secondListUser: Driver<[DataUserModel?]> {
        return listSecondUser.asDriver()
    }
    
    var thirdListUser: Driver<[DataUserModel?]> {
        return listThirdUser.asDriver()
    }
    
    var loadingView: Driver<Bool?> {
        return loading.asDriver()
    }
    
    let group = DispatchGroup()
    
    func fetchApi(){
        callApi(withPage: nil, noNeedPage: false)
        group.leave()
        callApi(withPage: "1", noNeedPage: true)
        group.leave()
        callApi(withPage: "2", noNeedPage: true)
        group.leave()
        notifyDispatch()
    }
    
    func callApi(withPage: String?, noNeedPage: Bool){
        var parameters : [String : String] =  [:]
        if noNeedPage == true {
            parameters = ["page": withPage ?? ""]
        }
        loading.accept(true)
        group.enter()
        NetworkServices.instance.getServiceData(url: "\(Constant.baseURL)/users", method: .get, parameters: parameters, encodingType: URLEncoding.default, headers: [:]) { [weak self] (user: UserModel?, error: String?) in
            
            if error != nil {
                
            } else {
                if let user = user?.data {
                    if withPage == nil {
                        self?.listUser.accept(user)
                    } else if withPage == "1" {
                        self?.listSecondUser.accept(user)
                    } else {
                        self?.listThirdUser.accept(user)
                    }
                }
            }
        }
    }
    
    func notifyDispatch(){
        group.notify(queue: .main) {
            self.loading.accept(false)
        }
    }
}


