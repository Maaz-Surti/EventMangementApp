//
//  ViewController.swift
//  EventManagementApp
//
//  Created by Maaz on 03/11/21.

import UIKit
import CoreData

class LoginViewController: UIViewController {
    


    @IBOutlet var txt_username: UITextField!
    @IBOutlet var txt_password: UITextField!
    var TableData = [SignUp]()
    var username = [String]()
    var password = [String]()
    var auth: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        for item in TableData as [SignUp]
        {
            print(item)
        }
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
               print(path)
        title = "         Log In"
        navigationController?.navigationBar.prefersLargeTitles = true
        TableData = DMLOperations().showdata()
        login()
        auth = authentication()
        
        
    }
 
    @IBAction func btn_signup(_ sender: Any)
    {
        let SignUpVC = storyboard?.instantiateViewController(identifier: "signupvc") as! SignUpViewController
               navigationController?.pushViewController(SignUpVC, animated: true)
    }
    
    @IBAction func btn_login(_ sender: Any)
    {
        auth = authentication()
        if auth == true
        {
            let TabBarVC = storyboard?.instantiateViewController(identifier: "barvc") as! UITabBarController
                   navigationController?.pushViewController(TabBarVC, animated: true)
        }
        
        else
        {
            let alert=UIAlertController(title: "Error", message: "Please enter the correct username and password", preferredStyle: .alert)
            let ok=UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func login()
    {
        
        for data in TableData as [NSManagedObject]
            {
                username.append(data.value(forKey: "username") as! String)
            }
        for data in TableData as [NSManagedObject]
            {
                 password.append(data.value(forKey: "password") as! String)
            }
        
        print(username)
        print(password)
    
      }
    
    func authentication() -> Bool
    {
        var token: Bool = false
        var un: Bool = false
        var pw: Bool = false
        for item in username
        {
            if item == txt_username.text
            {
                un = true
                print(item)
            }
        }
        for item in password
        {
            if item == txt_password.text
            {
                pw = true
                print(item)
            }
        }
        
        if un && pw == true
        {
            token = true
        }
        
        return token
    }

}

