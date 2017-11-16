//
//  ViewController.swift
//  Trip Planner
//
//  Created by Johnathan Chen on 11/16/17.
//  Copyright © 2017 JCSwifty. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputBottomBorder()
    }

    func inputBottomBorder() {
        emailInputBottomBorder()
        passwordInputBottomBorder()
    }
    
    func emailInputBottomBorder() {
        /* Adds grey bottom border to login input fields */
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.borderWidth = width
        
        // Email Login Border
        border.frame = CGRect(x: 0, y: emailLogin.frame.size.height - width, width:  emailLogin.frame.size.width, height: emailLogin.frame.size.height)
        emailLogin.layer.addSublayer(border)
        emailLogin.layer.masksToBounds = true
    }
    
    func passwordInputBottomBorder() {
        /* Adds grey bottom border to login input fields */
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.borderWidth = width
        
        // Password Login Border
        border.frame = CGRect(x: 0, y: passwordLogin.frame.size.height - width, width:  passwordLogin.frame.size.width, height: passwordLogin.frame.size.height)
        passwordLogin.layer.addSublayer(border)
        passwordLogin.layer.masksToBounds = true
    }



}

