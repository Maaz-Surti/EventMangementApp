//
//  DMLOperations.swift
//  EMCoreData
//
//  Created by Maaz on 12/11/21.
//

import Foundation
import CoreData
import UIKit

class DMLOperations
{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func savedata(data: [String:Any])
    {
        let insertdata = NSEntityDescription.insertNewObject(forEntityName: "SignUp", into: context) as! SignUp
        insertdata.fullname = data["fullname"] as? String
        insertdata.email = data["email"] as? String
        insertdata.username = data["username"] as? String
        insertdata.password = data["password"] as? String
        
    }
    
    func showdata () -> [SignUp]           /* To fetch a specific table*/
       
       {
            var stdata = [SignUp]()
           
            let stdatareq = NSFetchRequest<NSManagedObject>.init(entityName: "SignUp")

                do
                {
                     try stdata = context.fetch(stdatareq) as! [SignUp]
                }
            catch
                {
                      print(error.localizedDescription)
                }
           
                return stdata
       }
    
       
    func saveEventdata(data: [String:Any])
    {
        let insertdata = NSEntityDescription.insertNewObject(forEntityName: "Event", into: context) as! Event
        insertdata.eventName = data["eventName"] as? String
        insertdata.startDate = data["startDate"] as? String
        insertdata.endDate = data["endDate"] as? String
        insertdata.venue = data["venue"] as? String
        insertdata.city = data["city"] as? String
        
    }
   
    func showEventsData () -> [Event]           /* To fetch a specific table*/
        
        {
                  var stdata = [Event]()
            
             let stdatareq = NSFetchRequest<NSManagedObject>.init(entityName: "Event")

                 do
                 {
                     stdata = try context.fetch(stdatareq) as! [Event]
                 }
             catch
                 {
                       print(error.localizedDescription)
                 }
            
                 return stdata
        }
    
    func deleteEventData(index: Int) -> [Event]
    {
        var event = showEventsData()
        context.delete(event[index])
        event.remove(at: index)
        do
        {
            try context.save()
        }
        catch
        {
            print(error.localizedDescription)
        }
        
        return event
    }
}
