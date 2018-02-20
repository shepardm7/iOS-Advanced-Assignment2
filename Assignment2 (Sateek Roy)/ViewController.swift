//
//  ViewController.swift
//  Assignment2 (Sateek Roy)
//
//  Created by Sateek Roy on 2017-07-19.
//  Copyright © 2017 SateekLambton. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var studentList: UITableView!
    var data = [NSManagedObject]()
    var dataIndex = -1
    
    var context: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Students")
        
        request.returnsObjectsAsFaults = false
        
        do {
            
            data = try context.fetch(request) as! [NSManagedObject]
            
//            for d in data {
//                var str = d.value(forKey: "name") as? String
//                print(str)
//                context.delete(d)
//            }
//            do {
//                try context.save()
//            } catch let error as NSError {
//                print("could no save. \(error), \(error.userInfo)")
//            }
            
        } catch {
            
            print("Couldn't fetch results")
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddStudent" {
            if let vc = segue.destination as? AddStudentViewController {
                vc.updateVar = 0
            }
        }
    }
    
    @IBAction func unwindToTableView(sender: UIStoryboardSegue){
        //text if the sender is the Viewcontroller, and if there is a restaurant created
        if let sourceViewController = sender.source as? AddStudentViewController {
            
            let newName = sourceViewController.enterName.text
            let newGPA = sourceViewController.totGPA
            let newDatabaseGPA = sourceViewController.databaseGPA.text
            let newSwiftGPA = sourceViewController.swiftGPA.text
            let newiOS1GPA = sourceViewController.iOS1GPA.text
            let newJavaGPA = sourceViewController.javaGPA.text
            let newAndroid1GPA = sourceViewController.android1GPA.text
            let newWebGPA = sourceViewController.webGPA.text
            let newPhpGPA = sourceViewController.phpGPA.text
            let newcrossPGPA = sourceViewController.crossPGPA.text
            let newiOS2GPA = sourceViewController.iOS2GPA.text
            let newAndroid2GPA = sourceViewController.android2GPA.text
            print("Success in creating new vars")
            if let selectedIndexPath = studentList.indexPathForSelectedRow {
                //Update an existing restaurant.
                
                //let username = data[selectedIndexPath.row].value(forKey: "username") as? String
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Students")
                request.returnsObjectsAsFaults = false
                do {
                    let results = try context.fetch(request) as! [NSManagedObject]
                    
                    
                    results[selectedIndexPath.row].setValue(newName!, forKey: "name")
                    results[selectedIndexPath.row].setValue(newGPA, forKey: "gpa")
                    results[selectedIndexPath.row].setValue(Double(newDatabaseGPA!), forKey: "database")
                    results[selectedIndexPath.row].setValue(Double(newSwiftGPA!), forKey: "swift")
                    results[selectedIndexPath.row].setValue(Double(newiOS1GPA!), forKey: "ios1")
                    results[selectedIndexPath.row].setValue(Double(newJavaGPA!), forKey: "java")
                    results[selectedIndexPath.row].setValue(Double(newAndroid1GPA!), forKey: "android1")
                    results[selectedIndexPath.row].setValue(Double(newWebGPA!), forKey: "web")
                    results[selectedIndexPath.row].setValue(Double(newPhpGPA!), forKey: "php")
                    results[selectedIndexPath.row].setValue(Double(newcrossPGPA!), forKey: "crossp")
                    results[selectedIndexPath.row].setValue(Double(newiOS2GPA!), forKey: "ios2")
                    results[selectedIndexPath.row].setValue(Double(newAndroid2GPA!), forKey: "android2")
                    
                    data[selectedIndexPath.row] = results[selectedIndexPath.row]
                    do {
                        try context.save()
                    } catch {
                        print("Update Failed")
                    }
                    
                    
                    
                    studentList.reloadRows(at: [selectedIndexPath], with: .none)
                }
                catch {
                    print("error")
                }
                
            }
            else {
                let newIndexPath = IndexPath(row: data.count, section: 0)
                
                
                let entity = NSEntityDescription.entity(forEntityName: "Students", in: context)!
                
                let stud = NSManagedObject(entity: entity, insertInto: context)
                
                //3
                
                stud.setValue(newName!, forKey: "name")
                stud.setValue(newGPA, forKey: "gpa")
                stud.setValue(Double(newDatabaseGPA!), forKey: "database")
                stud.setValue(Double(newSwiftGPA!), forKey: "swift")
                stud.setValue(Double(newiOS1GPA!), forKey: "ios1")
                stud.setValue(Double(newJavaGPA!), forKey: "java")
                stud.setValue(Double(newAndroid1GPA!), forKey: "android1")
                stud.setValue(Double(newWebGPA!), forKey: "web")
                stud.setValue(Double(newPhpGPA!), forKey: "php")
                stud.setValue(Double(newcrossPGPA!), forKey: "crossp")
                stud.setValue(Double(newiOS2GPA!), forKey: "ios2")
                stud.setValue(Double(newAndroid2GPA!), forKey: "android2")
                //4
                do {
                    try context.save()
                    data.append(stud)
                } catch let error as NSError {
                    print("could no save. \(error), \(error.userInfo)")
                }
                
                
                //adding the new element to the tableview
//                studentList.insertRows(at: [newIndexPath], with: .automatic)
                studentList.reloadData()
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StudentTableViewCell
        
        if let name = data[indexPath.row].value(forKey: "name") as? String {
            cell.nameLabel.text = name
        }
        if let gpa = data[indexPath.row].value(forKey: "gpa") as? Double {
            cell.gpaLabel.text = String(gpa)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataIndex = indexPath.row
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "addStudentView") as! AddStudentViewController
        navigationController?.pushViewController(nextViewController, animated: true)
        
        nextViewController.updateVar = 1
        nextViewController.arIndex = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            context.delete(data[indexPath.row])
            do {
                try context.save()
            }
            catch {
                print("Failed to delete")
            }
            data.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
}


