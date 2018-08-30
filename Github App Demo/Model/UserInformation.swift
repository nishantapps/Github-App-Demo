//
//  UserInformation.swift
//  Github App Demo
//
//  Created by oms183 on 8/28/18.
//  Copyright © 2018 Nishant Rai. All rights reserved.
//

import Foundation

class UserInformation{
    var login:String
    var id:String
    var avatar_url:String
    var url:String
    var followers_url:String
    var following_url:String
    var gists_url:String
    var starred_url:String
    var subscriptions_url:String
    var organizations_url:String
    var repos_url:String
    var name:String
    var blog:String
    var bio:String
    var public_repos:String
    var public_gists:String
    var followers:String
    var following:String
    var created_at:String
    var updated_at:String
    var location:String
    var email:String
    
    init(login:String,id:String,avatar_url:String,url:String,followers_url:String,following_url:String,gists_url:String,starred_url:String, subscriptions_url:String, organizations_url:String, repos_url:String,name:String,blog:String,bio:String,public_repos:String,followers:String,following:String,created_at:String,updated_at:String,public_gists:String,location:String,email:String ) {
        
        self.login = login
        self.id = id
        self.avatar_url = avatar_url
        self.url = url
        self.followers_url = followers_url
        self.following_url = following_url
        self.gists_url = gists_url
        self.starred_url = starred_url
        self.subscriptions_url = subscriptions_url
        self.organizations_url = organizations_url
        self.repos_url = repos_url
        self.name = name
        self.blog = blog
        self.bio = bio
        self.public_repos = public_repos
         self.followers = followers
         self.following = following
         self.created_at = created_at
         self.updated_at = updated_at
        self.public_gists = public_gists
        self.location = location
        self.email = email
        
       
        
        
    }
    
}
