//
//  DetailScreen.swift
//  AgileLegacy
//
//  Created by Kevin Desmay on 19/09/2019.
//  Copyright © 2019 Kevin Desmay. All rights reserved.
//

import UIKit


class DetailScreen: UIViewController {

    @IBOutlet weak var lTitle: UILabel!
    @IBOutlet weak var tvDetail: UITextView!
    @IBOutlet weak var lPeople: UILabel!
    @IBOutlet weak var lDuration: UILabel!
    @IBOutlet weak var difficulty: UIImageView!
    @IBOutlet weak var difficulty2: UIImageView!
    @IBOutlet weak var difficulty3: UIImageView!
    @IBOutlet weak var lSource: UILabel!
    
    private var workshop: Workshop!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    /// Appel de la vue. Permet d'initialiser tout le contenu de celle-ci.
    ///
    /// - Parameters:
    ///     - entity: *Entité* à afficher dans la vue de type `Workshop`
    ///     - type: *Type* de l'entité parmit la liste des `Workshop`
    ///     - color: *Couleur* du background de la vue
    func call(entity: Workshop, type: String, color: UIColor) {
        self.view.backgroundColor = color
        tvDetail.backgroundColor = color
        self.workshop = entity
       
        
        initView()
    }
    
    /// Initialise les composants graphique de la vue.
    func initView() {
        lTitle.text = workshop?.title?.uppercased()
        lTitle.textColor = .white
        
        tvDetail.attributedText = workshop?.detail?.htmlToAttributedString
        tvDetail.isEditable = false
        tvDetail.isSelectable = false
        
        lPeople.text = String(format: "%d-%d", (workshop != nil) ? workshop.nbPeopleMin : "00", (workshop != nil) ? workshop.nbPeopleMax : "00")
    
        lDuration.text = String(format: "%d-%d", (workshop != nil) ? workshop.durationMin : "000", (workshop != nil) ? workshop.durationMax : "000")
        
        lSource.text = workshop.source
        
        initDifficulty()
    }

    /// Initialise la difficulté de l'atelier. Affiche une jauge à 5 niveaux en fonction du champ `difficulty`  de l'entité `workshop`
    func initDifficulty() {
        switch workshop.difficulty {
        case 1:
            difficulty.isHidden = false
            difficulty2.isHidden = true
            difficulty3.isHidden = true
            break
        case 2:
            difficulty.isHidden = false
            difficulty2.isHidden = false
            difficulty3.isHidden = true
            break
        case 3:
            difficulty.isHidden = false
            difficulty2.isHidden = false
            difficulty3.isHidden = false
            break
        default:
            break
        }
    }
    
    /// Affichage de la modale de matériel pour l'atelier
    @IBAction func showMaterialPopup(_ sender: UIButton) {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "materialPopupScreen") as! MaterialPopupScreen
        popOverVC.call(entity: workshop)
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    
}

extension String {
    
    /// Initialise la gestion des String au format HTML.
    /// Permet d'afficher de l'HTML dans une chaine de caractère dans le but de le faire apparaitre dans l'interface graphique
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
