//
//  AddStudentViewController.swift
//  Assignment2 (Sateek Roy)
//
//  Created by Sateek Roy on 2017-07-19.
//  Copyright © 2017 SateekLambton. All rights reserved.
//

import UIKit
import CoreData

class AddStudentViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var enterName: UITextField!
    @IBOutlet weak var databaseGPA: UITextField!
    @IBOutlet weak var swiftGPA: UITextField!
    @IBOutlet weak var iOS1GPA: UITextField!
    @IBOutlet weak var javaGPA: UITextField!
    @IBOutlet weak var android1GPA: UITextField!
    @IBOutlet weak var webGPA: UITextField!
    @IBOutlet weak var phpGPA: UITextField!
    @IBOutlet weak var crossPGPA: UITextField!
    @IBOutlet weak var iOS2GPA: UITextField!
    @IBOutlet weak var android2GPA: UITextField!
    
    @IBOutlet weak var totalGPA: UILabel!
    var totGPA = 0.0
    var updateVar = 0
    var arIndex = -1
    var context: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Add Student"
        
        enterName.delegate = self
        databaseGPA.delegate = self
        swiftGPA.delegate = self
        iOS1GPA.delegate = self
        javaGPA.delegate = self
        android1GPA.delegate = self
        webGPA.delegate = self
        phpGPA.delegate = self
        crossPGPA.delegate = self
        iOS2GPA.delegate = self
        android2GPA.delegate = self
        if updateVar == 1 && arIndex != -1 {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            context = appDelegate.persistentContainer.viewContext
            self.title = "Update Student"
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Students")
            
            request.returnsObjectsAsFaults = false
            do {
                
                let results = try context.fetch(request) as! [NSManagedObject]
                enterName.text = results[arIndex].value(forKey: "name") as? String
                totalGPA.text = String(describing: results[arIndex].value(forKey: "gpa") as! Double)
                databaseGPA.text = String(describing: results[arIndex].value(forKey: "database") as! Double)
                swiftGPA.text = String(describing: results[arIndex].value(forKey: "swift") as! Double)
                iOS1GPA.text = String(describing: results[arIndex].value(forKey: "ios1") as! Double)
                javaGPA.text = String(describing: results[arIndex].value(forKey: "java") as! Double)
                android1GPA.text = String(describing: results[arIndex].value(forKey: "android1") as! Double)
                webGPA.text = String(describing: results[arIndex].value(forKey: "web") as! Double)
                phpGPA.text = String(describing: results[arIndex].value(forKey: "php") as! Double)
                crossPGPA.text = String(describing: results[arIndex].value(forKey: "crossp") as! Double)
                iOS2GPA.text = String(describing: results[arIndex].value(forKey: "ios2") as! Double)
                android2GPA.text = String(describing: results[arIndex].value(forKey: "android2") as! Double)
                getGPA()
            } catch {
                
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        getGPA()
    }
    

    func getGPA() {
        var sum = 0.0
        if databaseGPA.text == "" {
            sum = sum + 0
        }
        else {
            sum = sum + Double(databaseGPA.text!)!
        }
        if swiftGPA.text == "" {
            sum = sum + 0
        }
        else {
            sum = sum + Double(swiftGPA.text!)!
        }
        if iOS1GPA.text == "" {
            sum = sum + 0
        }
        else {
            sum = sum + Double(iOS1GPA.text!)!
        }
        if javaGPA.text == "" {
            sum = sum + 0
        }
        else {
            sum = sum + Double(javaGPA.text!)!
        }
        if android1GPA.text == "" {
            sum = sum + 0
        }
        else {
            sum = sum + Double(android1GPA.text!)!
        }
        if webGPA.text == "" {
            sum = sum + 0
        }
        else {
            sum = sum + Double(webGPA.text!)!
        }
        if phpGPA.text == "" {
            sum = sum + 0
        }
        else {
            sum = sum + Double(phpGPA.text!)!
        }
        if crossPGPA.text == "" {
            sum = sum + 0
        }
        else {
            sum = sum + Double(crossPGPA.text!)!
        }
        if iOS2GPA.text == "" {
            sum = sum + 0
        }
        else {
            sum = sum + Double(iOS2GPA.text!)!
        }
        if android2GPA.text == "" {
            sum = sum + 0
        }
        else {
            sum = sum + Double(android2GPA.text!)!
        }
        totGPA = sum/10
        totalGPA.text = String(totGPA)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
