//
//  PersonDetailViewController.swift
//  CoolAs
//
//  Created by Benjamin Poulsen PRO on 1/15/19.
//  Copyright © 2019 Benjamin Poulsen PRO. All rights reserved.
//

import UIKit
import CoreData

class PersonDetailViewController: UIViewController {

    var person: Person?
    
    var delegate: PersonDelegate?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var emojiTextField: UITextField!
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let name = nameTextField.text, let emojiName = emojiTextField.text {
            delegate?.saveText(name: name, emojiName: emojiName)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    
}
protocol PersonDelegate {
    func saveText(name: String, emojiName: String)
}
