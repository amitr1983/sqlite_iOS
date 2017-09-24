//
//  contactDB.swift
//  sql_storage_exercise
//
//  Created by Amit Rajoria on 9/21/17.
//  Copyright © 2017 Amit Rajoria. All rights reserved.
//

import Foundation
import SQLite

class ContactDB {

    static let shared:ContactDB = ContactDB()
    private let db: Connection?
    
    private let contacts = Table("contacts")
    private let id = Expression<Int64>("id")
    private let location = Expression<String?>("location")
    private let name = Expression<String?>("name")
    private let phone = Expression<String>("phone")
    private let address = Expression<String>("address")
    private let email = Expression<String?>("email")
    
    init() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        print(path)
        
        do {
            db = try Connection("\(path)/Contact.sqlite3")
        } catch {
            db = nil
            print ("Unable to open database")
        }
        
        createTable()
    }

    func createTable() {
        do {
            try db!.run(contacts.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(name)
                table.column(location)
                table.column(phone)
                table.column(address)
                table.column(email)
            })
        } catch {
            print("Unable to create table")
        }
    }
    
    func addContact(cname: String, clocation: String, cphone: String, caddress: String, cemail: String) -> Int64? {
        do {
            let insert = contacts.insert(name <- cname, location <- clocation, phone <- cphone, address <- caddress, email <- cemail)
            let id = try db!.run(insert)
            print(insert.asSQL())
            
            return id
        } catch {
            print("Insert failed")
            return -1
        }
    }
    
    func getContacts() -> [Contact] {
        var contacts = [Contact]()
        
        do {
            for contact in try db!.prepare(self.contacts) {
                contacts.append(Contact(
                    id: contact[id],
                    name: contact[name]!,
                    location: contact[location]!,
                    phone: contact[phone],
                    address: contact[address],
                    email: contact[email]!))
            }
        } catch {
            print("Select failed")
        }
        
        return contacts
    }
}



