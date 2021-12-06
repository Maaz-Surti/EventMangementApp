//
//  DetailsViewController.swift
//  EventManagementApp
//
//  Created by Maaz on 23/11/21.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var lblEvent: UILabel!
    @IBOutlet var lblStartDate: UILabel!
    @IBOutlet var lblEndDate: UILabel!
    @IBOutlet var lblVenue: UILabel!
    @IBOutlet var lblCity: UILabel!
    
    @IBOutlet var txtEvent: UILabel!
    @IBOutlet var txtStartDate: UILabel!
    @IBOutlet var txtEndDate: UILabel!
    @IBOutlet var txtVenue: UILabel!
    @IBOutlet var txtCity: UILabel!
    
    var items = [Event]()
    
    var selectedIndex = Int()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEvent()
        assignValuesToLabels()

    }
    
    func fetchEvent()
    {
        do {
            self.items = try context.fetch(Event.fetchRequest())
        } catch  {
            
        }
    }
    
    func assignValuesToLabels()
    {
        txtEvent.text = "  " + items[selectedIndex].eventName!
        txtStartDate.text = "  " + items[selectedIndex].startDate!
        txtEndDate.text = "  " + items[selectedIndex].endDate!
        txtVenue.text = "  " + items[selectedIndex].venue!
        txtCity.text = "  " + items[selectedIndex].city!
        
    }
    @IBAction func btnBack(_ sender: Any)
    {
        navigationController?.popViewController(animated: true)
    }
    
}
