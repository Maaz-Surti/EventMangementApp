//
//  EditViewController.swift
//  EventManagementApp
//
//  Created by Maaz on 21/11/21.
//

import UIKit
import CoreData

class EditViewController: UIViewController {

    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtStartDate: UITextField!
    @IBOutlet var txtEndDate: UITextField!
    @IBOutlet var txtVenue: UITextField!
    @IBOutlet var txtCity: UITextField!
    
    var m_name = String()
    var m_startDate = String()
    var m_endDate = String()
    var m_venue = String()
    var m_city = String()
    var selectedIndex = Int()
    var items: [Event]?
    
    var datePicker = UIDatePicker()
    var datePicker1 = UIDatePicker()
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
     }
    override func viewDidLoad() {
        super.viewDidLoad()
            
        
        txtName.text = m_name
        txtCity.text = m_city
        txtStartDate.text = m_startDate
        txtEndDate.text = m_endDate
        txtVenue.text = m_venue
        
        fetchEvent()
        createDatePickerStart()
        createDatePickerEnd()
    }
    
    func fetchEvent()
    {
        do {
            self.items = try context.fetch(Event.fetchRequest())
        } catch  {
            
        }
    }
    
    @IBAction func btnSave(_ sender: Any)
    {
        
        items?[selectedIndex].eventName = txtName.text
        items?[selectedIndex].startDate = txtStartDate.text
        items?[selectedIndex].endDate = txtEndDate.text
        items?[selectedIndex].venue = txtVenue.text
        items?[selectedIndex].city = txtCity.text
        
        do{
            try context.save()
        }
        catch
        {
            let alert=UIAlertController(title: "Oops", message: "Something went wrong", preferredStyle: .alert)
            let ok=UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //Start Date and Time function
    
    func createDatePickerStart()
    {

        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //barbutton
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target:nil , action: #selector(donePressedStart))
        toolbar.setItems([doneBtn], animated: true)
        //assign toolbar
        txtStartDate.inputAccessoryView = toolbar
        
        //assign datepicker to the text field
        txtStartDate.inputView = datePicker
        
        //change datePicker mode to wheels
        datePicker.preferredDatePickerStyle = .wheels
        
        //datePicker format
        datePicker.datePickerMode = .dateAndTime
        
        print(datePicker.date)
    }
    
    //End Date and Time function
    
    func createDatePickerEnd()
    {
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //barbutton
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target:nil , action: #selector(donePressedEnd))
        toolbar.setItems([doneBtn], animated: true)
        //assign toolbar
        txtEndDate.inputAccessoryView = toolbar
        
        //assign datepicker to the text field
        txtEndDate.inputView = datePicker1
        
        //change datePicker mode to wheels
        datePicker1.preferredDatePickerStyle = .wheels
        
        //datePicker format
        datePicker1.datePickerMode = .dateAndTime
    }
    
    //Action for done button
    
    @objc func donePressedStart()
    {
        let dt = datePicker.date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        txtStartDate.text = formatter.string(from: dt)
        self.view.endEditing(true)
    }
    
    //Action for done button
    
    @objc func donePressedEnd()
    {
        let dt1 = datePicker1.date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        txtEndDate.text = formatter.string(from: dt1)
        self.view.endEditing(true)
    }
    
}
