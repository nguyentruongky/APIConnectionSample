//
//  MyGithub.swift
//  APIConnectionSample
//
//  Created by Ky Nguyen Coinhako on 12/10/18.
//  Copyright © 2018 Ky Nguyen. All rights reserved.
//

import Foundation
struct MyGithubNew: Codable {
    var name: String?
    var blog: String?
    var repos: Int
    
    private enum Keys: String, CodingKey {
        case name
        case blog
        case repos = "public_repos"
    }
}

struct MyGithubOld {
    var name: String?
    var blog: String?
    var repos: Int
    
    init(raw: AnyObject) {
        name = raw["name"] as? String
        blog = raw["blog"] as? String
        repos = raw["public_repos"] as? Int ?? 0
    }
}
