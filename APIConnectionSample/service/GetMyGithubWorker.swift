//
//  GetMyGithubWorker.swift
//  APIConnectionSample
//
//  Created by Ky Nguyen Coinhako on 12/10/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation


struct GetMyGithubWorker {
    private let api = "https://api.github.com/users/"
    var userName: String
    var successAction: ((MyGithubOld) -> Void)?
    var failAction: ((Error) -> Void)?
    
    init(userName: String,
         successAction: ((MyGithubOld) -> Void)?,
         failAction: ((Error) -> Void)?) {
        self.userName = userName
        self.successAction = successAction
        self.failAction = failAction
    }
    
    func execute() {
        let finalApi = api + userName
        ServiceConnector.get(finalApi, params: nil, headers: nil,
                             success: successResponse, fail: failResponse)
    }
    
    private func successResponse(_ raw: AnyObject, data: Data?) {
        if let message = raw["message"] as? String {
            let err = NSError(domain: message, code: -1, userInfo: nil)
            failResponse(err as Error)
            return
        }
        let mygit = MyGithubOld(raw: raw)
        successAction?(mygit)
        
//        if let data = data {
//            let mygitNew = JSONDecoder().decode(MyGithubNew.self, from: data)
//        }
    }
    
    private func failResponse(_ err: Error) {
        failAction?(err)
    }
}
