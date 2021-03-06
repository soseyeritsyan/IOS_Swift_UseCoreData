//
//  ViewController.swift
//  UseCoreData
//
//  Created by Sose Yeritsyan on 5/2/20.
//  Copyright © 2020 Sose Yeritsyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func clickSignIn() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignIn") as! SignInViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func clickSignUp() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUp") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func clickAllUsers(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UsersTable") as! UsersViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }


}

