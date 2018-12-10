//
//  ViewController.swift
//  APIConnectionSample
//
//  Created by Ky Nguyen Coinhako on 12/10/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userName = "nguyentruongky3390"
        GetMyGithubWorker(userName: userName,
                          successAction: didGetMyGit, failAction: didGetFail).execute()
    }
    
    func didGetMyGit(_ mygit: MyGithubOld) {
        print(mygit.blog)
        print(mygit.name)
        print(mygit.repos)
    }
    
    func didGetFail(err: Error) {
        print(err)
    }


}

