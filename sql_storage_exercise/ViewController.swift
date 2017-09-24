//
//  ViewController.swift
//  sql_storage_exercise
//
//  Created by Amit Rajoria on 9/20/17.
//  Copyright © 2017 Amit Rajoria. All rights reserved.
//

import UIKit
import Foundation
import SQLite

class ViewController: UIViewController {

    
    @IBOutlet weak var contactName: UITextField!
    
    
    @IBOutlet weak var contactLocation: UITextField!
    
    
    @IBOutlet weak var contactAddress: UITextView!
    
    
    @IBOutlet weak var contactPhone: UITextField!
    
    @IBOutlet weak var contactEmail: UITextField!
    
    @IBOutlet weak var successLabel: UILabel!
    
    let contactDB1 = ContactDB()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func saveInfo(_ sender: Any) {
        let name = contactName.text ?? ""
        let location = contactLocation.text ?? ""
        let phone = contactPhone.text ?? ""
        let address = contactAddress.text ?? ""
        let email = contactEmail.text ?? ""
        print(name)
        
        let id = ContactDB.shared.addContact(cname: name, clocation: location, cphone: phone, caddress: address, cemail: email)
            if id != nil {
                print("ID: \(id!))")
                if id != -1 {
                    successLabel.text = "Successfully Added!!"
                } else {
                    successLabel.text = "An Error occured!!"
                }
        }

    }
    
    

    @IBAction func cancel(_ sender: Any) {
        contactName.text = ""
        contactPhone.text = ""
        contactLocation.text = ""
        contactAddress.text = ""
        contactEmail.text = ""
    }
}

