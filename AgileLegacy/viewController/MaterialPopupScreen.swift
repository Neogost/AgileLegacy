//
//  MaterialPopupScreen.swift
//  AgileLegacy
//
//  Created by Kevin Desmay on 07/01/2020.
//  Copyright © 2020 Kevin Desmay. All rights reserved.
//

import UIKit

class MaterialPopupScreen: UIViewController {

    @IBOutlet weak var materialList: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
        
    func call(entity: Workshop) {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.showAnimate()
        
        materialList.attributedText = entity.materialList?.htmlToAttributedString
    }

    /// Animation de l'ouverture de la modale
    func showAnimate() {
        self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.0)
            })
    }
    
    /// Animation de fermeture de la modale
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished : Bool ) in
            if(finished) {
                self.view.removeFromSuperview()
            }
        })
    }
    
    /// Fermeture de la popup permettant de visualiser le matériel de l'atelier
    @IBAction func closePopup(_ sender: UIButton) {
        self.removeAnimate()
    }
    
}
