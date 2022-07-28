//
//  SettingsViewController.swift
//  InstaCloneFirebase
//
//  Created by Macbook Pro on 28.07.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func LogOutClicked(_ sender: Any) {
        performSegue(withIdentifier: "toViewController", sender: nil)
    }
    
}
