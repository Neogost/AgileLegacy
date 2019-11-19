//
//  Extension.swift
//  AgileLegacy
//
//  Created by Kevin Desmay on 14/09/2019.
//  Copyright © 2019 Kevin Desmay. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    /// Défini la valeur Hexadécimal de la couleur associé à l'ice breaker. Cette couleur
    /// est utilisé afin de garder une cohérence entre les différentes vue et teinte de couleur
    /// dans l'application
    static let iceBreakerColor = UIColor().colorFromHex(hex:"57B5F9")
    
    
    /// Défini la valeur Hexadécimal de la couleur associé à la génération d'idée. Cette couleur
    /// est utilisé afin de garder une cohérence entre les différentes vue et teinte de couleur
    /// dans l'application
    static let ideaColor = UIColor().colorFromHex(hex:"E498AF")
    
    
    /// Défini la valeur Hexadécimal de la couleur associé à la résolution de partage d'une idée . Cette couleur
    /// est utilisé afin de garder une cohérence entre les différentes vue et teinte de couleur
    /// dans l'application
    static let shareColor = UIColor().colorFromHex(hex:"FF7C64")
    
    /// Défini la valeur Hexadécimal de la couleur associé à la résolution de problème. Cette couleur
    /// est utilisé afin de garder une cohérence entre les différentes vue et teinte de couleur
    /// dans l'application
    static let problemColor = UIColor().colorFromHex(hex:"8E79AD")
    
    
    /// Défini la valeur Hexadécimal de la couleur associé à la prise de décision. Cette couleur
    /// est utilisé afin de garder une cohérence entre les différentes vue et teinte de couleur
    /// dans l'application
    static let decisionColor = UIColor().colorFromHex(hex:"5BDB5B")
    
    
    /// Défini la valeur Hexadécimal de la couleur associé à la phase de retrospective. Cette couleur
    /// est utilisé afin de garder une cohérence entre les différentes vue et teinte de couleur
    /// dans l'application
    static let retrospectiveColor = UIColor().colorFromHex(hex:"FFAC39")
    
    
    /// Défini la valeur Hexadécimal de la couleur associé à la phase de retrospective. Cette couleur
    /// est utilisé afin de garder une cohérence entre les différentes vue et teinte de couleur
    /// dans l'application
    static let closeColor = UIColor().colorFromHex(hex:"CFA270")
    
    
    /// Défini la valeur Hexadécimal de la couleur associé à la phase de retrospective. Cette couleur
    /// est utilisé afin de garder une cohérence entre les différentes vue et teinte de couleur
    /// dans l'application
    static let collectColor = UIColor().colorFromHex(hex:"0E8AE9")
    
    
    /// Méthode permettant de convertire une valeur hexadécimal en couleur RGB.
    /// Cette méthode génère un <code>UIColor</code>
    ///
    /// - parameters:
    ///     - hex: Valeur hexadécimal avec ou sans "#"
    /// - returns: `UIColor` de la valeur Hexadécimal
    func colorFromHex(hex : String ) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            return UIColor.black
        }
        var rgb : UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgb)
        
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
                            blue: CGFloat((rgb & 0x0000FF)) / 255.0,
                            alpha: 1.0)
    }
}
