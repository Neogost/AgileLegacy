//
//  ViewController.swift
//  AgileLegacy
//
//  Created by Kevin Desmay on 14/09/2019.
//  Copyright © 2019 Kevin Desmay. All rights reserved.
//

import UIKit

class mainScreen: UIViewController {
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func OnClickRandomIceBreaker(_ sender: UIButton) {
        // Do nothing
    }
    @IBAction func OnClickIceBreakerList(_ sender: UIButton) {
        performSegue(withIdentifier:"iceBreakerList" , sender: self)
    }
    
    @IBAction func onClickShareList(_ sender: UIButton) {
        performSegue(withIdentifier: "shareList", sender: self)
    }
    
    @IBAction func OnClickIdeaList(_ sender: UIButton) {
        performSegue(withIdentifier: "ideaList", sender: self)
    }
    
    @IBAction func OnClickProblemList(_ sender: UIButton) {
        performSegue(withIdentifier: "problemList", sender: self)
    }
    
    @IBAction func OnClickTakeDecisionList(_ sender: UIButton) {
        performSegue(withIdentifier: "decisionList", sender: self)
    }
    
    @IBAction func OnClickRetrospectiveList(_ sender: Any) {
        performSegue(withIdentifier: "retrospectiveList", sender: self)
    }
    
    @IBAction func OnClickCloseList(_ sender: UIButton) {
        performSegue(withIdentifier: "closeList", sender: self)
    }
    
    @IBAction func OnClickCollectList(_ sender: UIButton) {
        performSegue(withIdentifier: "collectList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Information a transmettre
        switch(segue.identifier) {
        case "iceBreakerList":
        let listScreen = segue.destination as! ListScreen
            listScreen.call(title: "Liste des IceBreakers", type: "icebreaker", color: UIColor.iceBreakerColor)
            break
        case "ideaList":
        let listScreen = segue.destination as! ListScreen
            listScreen.call(title: "Liste des Ateliers de générations d'idées", type: "idea", color: UIColor.ideaColor)
            break
        case "shareList":
        let listScreen = segue.destination as! ListScreen
            listScreen.call(title: "Liste des Ateliers de partage d'une vision", type: "share", color: UIColor.shareColor)
            break
        case "problemList":
        let listScreen = segue.destination as! ListScreen
            listScreen.call(title: "Liste des Ateliers de résolutions de problèmes", type: "problem", color: UIColor.problemColor)
            break
        case "decisionList":
        let listScreen = segue.destination as! ListScreen
            listScreen.call(title: "Liste des Ateliers de prises de décisions", type: "decision", color: UIColor.decisionColor)
            break
        case "retrospectiveList":
        let listScreen = segue.destination as! ListScreen
            listScreen.call(title: "Liste des Retrospective", type: "retrospective", color: UIColor.retrospectiveColor)
            break
        case "closeList":
        let listScreen = segue.destination as! ListScreen
            listScreen.call(title: "Liste des Atelier de Fermeture", type: "close", color: UIColor.closeColor)
            break
        case "collectList":
        let listScreen = segue.destination as! ListScreen
            listScreen.call(title: "Liste des Atelier de Collecte", type: "collect", color: UIColor.collectColor)
            break
        case "profil":
            let settingScreen = segue.destination as! SettingScreen
            settingScreen.call()
            break
        default:
            break
        }
    }

}

