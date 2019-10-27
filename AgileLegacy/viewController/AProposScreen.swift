//
//  ProfilScreenViewController.swift
//  AgileLegacy
//
//  Created by Kevin Desmay on 29/09/2019.
//  Copyright © 2019 Kevin Desmay. All rights reserved.
//

import UIKit

class AProposScreen: UIViewController {

    @IBOutlet weak var giveButton: UIButton!
    @IBOutlet weak var planningButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onClickPlanning(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://trello.com/b/89cFyKXr/agilelegacy")!)
    }
    @IBAction func onClickDon(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://paypal.me/AgileLegacy")!)
    }
    
    /// Point d'entrée de la vue.
    public func call() {
        // Appel le chargement des données
        
    }
    
}
