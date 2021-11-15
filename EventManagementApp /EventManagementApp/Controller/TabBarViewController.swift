//
//  TabBarViewController.swift
//  EventManagementApp
//
//  Created by Maaz on 03/11/21.
//

import UIKit

class TabBarViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}

class CreateEventViewController: UIViewController {
    @IBOutlet var eventName: UITextField!
    @IBOutlet var startDateAndTime: UITextField!
    @IBOutlet var endDateAndTime: UITextField!
    @IBOutlet var venue: UITextField!
    @IBOutlet var city: UITextField!
    var datePicker = UIDatePicker()
    var datePicker1 = UIDatePicker()
    var result: Bool = false
    let dml = DMLOperations()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePickerStart()
        createDatePickerEnd()
        navigationController?.isNavigationBarHidden = true
        
    }
    @IBAction func createEventTapped(_ sender: Any)
    {
        if eventName.text! == "" || startDateAndTime.text! == "" || endDateAndTime.text! == "" || venue.text! == "" || city.text! == ""
        {
            let alert=UIAlertController(title: "Error", message: "The fields cannot remain empty", preferredStyle: .alert)
            let ok=UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
        else
        {
            createEvent()        }
    }
    
    //End Editing on touching screen
    
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
        startDateAndTime.inputAccessoryView = toolbar
        
        //assign datepicker to the text field
        startDateAndTime.inputView = datePicker
        
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
        endDateAndTime.inputAccessoryView = toolbar
        
        //assign datepicker to the text field
        endDateAndTime.inputView = datePicker1
        
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
        startDateAndTime.text = formatter.string(from: dt)
        self.view.endEditing(true)
    }
    
    //Action for done button
    
    @objc func donePressedEnd()
    {
        let dt1 = datePicker1.date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        endDateAndTime.text = formatter.string(from: dt1)
        self.view.endEditing(true)
    }
    
    func createEvent()
    {
        let eventData = ["eventName": eventName.text!, "startDate":startDateAndTime.text!, "endDate": endDateAndTime.text!, "venue": venue.text!, "city": city.text!]
        //Array containing the input data
               
        dml.saveEventdata(data: eventData)
//        let dml = DMLOperations()
//        dml.savedata(data: signupdata)
        /*calling the savedata function from DMLOperations and passing the array containing the data to be added    */

               do
               {
                   try context.save()
                   
                   eventName.text = ""
                   startDateAndTime.text = ""
                   endDateAndTime.text = ""
                   city.text = ""
                   venue.text = ""
                   
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




class EventsCreatedViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet var eventsTable: UITableView!
    var eventData = [Event]()
    var dml = DMLOperations()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        eventsTable.reloadData()
        eventData = dml.showEventsData()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        eventsTable.reloadData()
    }
    
    
}

extension EventsCreatedViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return eventData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = EventsTableViewCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! EventsTableViewCell
        cell.eventName?.text = eventData[indexPath.row].eventName
        cell.city?.text = eventData[indexPath.row].city
        cell.startDate?.text = eventData[indexPath.row].startDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            
            eventData = dml.deleteEventData(index: indexPath.row)
            self.eventsTable.deleteRows(at: [indexPath], with: .automatic)

                self.eventsTable.reloadData()
        }
    }

}
