//
//  SignUpViewController.swift
//  EventManagementApp
//
//  Created by Maaz on 04/11/21.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {
    @IBOutlet var txt_fullname: UITextField!
    @IBOutlet var txt_email: UITextField!
    @IBOutlet var txt_username: UITextField!
    @IBOutlet var txt_password: UITextField!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        title = "Sign Up"    //title
        
        navigationController?.navigationBar.prefersLargeTitles = true  //for big title
        
        view.backgroundColor = UIColor(red: 172 / 255.0, green: 149 / 255.0, blue: 220 / 255.0, alpha: 1.0)  //to set background color
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func btn_savesignupdata(_ sender: Any)
    {
        if txt_fullname.text == "" || txt_email.text == "" || txt_username.text == "" || txt_password.text == ""
        {
            let alert=UIAlertController(title: "Error", message: "The fields cannot remain empty" , preferredStyle: .alert)
            let ok=UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
          }
        
        else
        {
               signUpAction()
             
        }
        
    }
    
    func signUpAction()
    {
        let signupdata = ["fullname": txt_fullname.text!, "email":txt_email.text!, "username": txt_username.text!, "password": txt_password.text!]                                //Array containing the input data
               
               let dml = DMLOperations()
               dml.savedata(data: signupdata)
        /*calling the savedata function from DMLOperations and passing the array containing the data to be added    */

               do
               {
                   try context.save()
                   
                   txt_username.text = ""
                   txt_password.text = ""
                   txt_email.text = ""
                   txt_fullname.text = ""
                   
                   let alert=UIAlertController(title: "Success", message:    "Your details have been saved successfully" , preferredStyle: .alert)     //succesfull login alert
                   let ok=UIAlertAction(title: "Ok", style: .default, handler: nil)
                   alert.addAction(ok)
                   present(alert, animated: true, completion: nil)
                   
               }
               catch
               {
                   let alert=UIAlertController(title: "Oops. Something went wrong.", message: error.localizedDescription , preferredStyle: .alert)
                   let ok=UIAlertAction(title: "Ok", style: .default, handler: nil)
                   alert.addAction(ok)
                   present(alert, animated: true, completion: nil)
               }

    }
}

