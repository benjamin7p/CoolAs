//
//  PersonListTableViewController.swift
//  CoolAs
//
//  Created by Benjamin Poulsen PRO on 1/15/19.
//  Copyright © 2019 Benjamin Poulsen PRO. All rights reserved.
//

import UIKit
import CoreData

class PersonListTableViewController: UITableViewController {
    
    let personManager = PersonManager(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    
    var personList = [Person]()
    var emojiList = [Emoji]()
    
    
    func loadPersonList() -> [Person] {
        return personManager.fetchData()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        personList = loadPersonList()
        tableView.reloadData()
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath)
        
        let person = personList[indexPath.row]

        cell.textLabel?.text = person.name
        
        cell.detailTextLabel?.text = person.emoji?.emojiName
        
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let newPersonToDelete = personList[indexPath.row]
            personManager.delete(personToDelete: newPersonToDelete)
            personList.remove(at: indexPath.row)

            personManager.save()
            personList = loadPersonList()
            tableView.deleteRows(at: [indexPath], with: .fade)

            tableView.reloadData()
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? PersonDetailViewController else { return }
        destinationVC.delegate = self
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}

extension PersonListTableViewController: PersonDelegate {
    func saveText(name: String, emojiName: String) {
        let _ = personManager.create(personName: name, emojiName: emojiName)
        personManager.save()
        personList = personManager.fetchData()
        tableView.reloadData()
    }
}
