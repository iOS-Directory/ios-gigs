//
//  GigController.swift
//  Gigs
//
//  Created by FGT MAC on 10/28/20.
//

import Foundation


class GigController {
    
    //MARK: - Properties
    var bearer: Bearer?
    
    private let baseURL = URL(string: "https://lambdagigapi.herokuapp.com/api")!
    
    //Use lazy because we are refering to baseURL which will not init till the class does
    private lazy var signUpURL = URL(string: "/users/signup", relativeTo: baseURL)!
    
    func signUP(user:User,completion: @escaping (Error?) -> (Void))  {
        
        
        
    }
}
