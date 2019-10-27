//
//  ListScreen.swift
//  AgileLegacy
//
//  Created by Kevin Desmay on 14/09/2019.
//  Copyright © 2019 Kevin Desmay. All rights reserved.
//

import UIKit
import CoreData

/// Description
/// ==========
/// Classe permettant la gestion de la vue `ListScreen`. Celle-ci correspond à l'affichage de la liste des `Workshop`. Le point d'entrée de cette classe est la méthode **call**.
/// La méthode call permet d'initialiser :
///
/// - title : Titre de la vue
/// - type  : Type des données chargé dans la vue
/// - color : Couleur de la vue
class ListScreen: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    /// Type d'entité que la vue traitre. Par défaut celle-ci est initialisé à vide.
    var type: String = ""
    
    private var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = .black
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    /// Point d'entrée de la vue. Celle-ci permet d'initialiser les différents paramètre d'affichage de la vue tel que :
    /// - parameters:
    ///     - title: Titre de la vue
    ///     - type: Type des entité traités dans la vue
    ///     - color: Couleur de la vue
    public func call(title: String, type: String, color: UIColor) {
        self.type = type
        self.title = title
        self.view.backgroundColor = color
        tableView.backgroundColor = color
        
        // Appel le chargement des données
        configureFetchedResultsController()
        
    }
    
    
    /// Permet de charger les entitées présentes en base de données. Les entitées rappatrié sont des `Workshop`. Ils sont filtré en fonction de l'attribut **type** et trié par ordre alphabetique croissant.
    public func configureFetchedResultsController() {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Workshop")
        
        // Tri sur le titre
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let filter = NSPredicate(format: "type = %@", type)
        fetchRequest.predicate = filter
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: PersistanceService.persistentContainer.viewContext, sectionNameKeyPath: nil , cacheName: nil)
        
        fetchedResultsController?.delegate = self
        
        do {
            try fetchedResultsController?.performFetch()
        } catch {
            print("Error : " + error.localizedDescription)
        }
    }
    
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        print("KED : THE CONTROLLER CONTENT HAS CHANGED")
        
        
        // Charge le tableau avec les données déjà existante en base de données
        tableView.reloadData()
    }
    
    
}


extension ListScreen: UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    
    
    /// Retourne le nombre d'éléments dans le tableau.
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController?.sections else {
            return 0
        }
        let rowCount = sections[section].numberOfObjects
        return rowCount
    }
    
    
    /// Permet d'effectuer l'affichage des cellules dans le tableau
    /// Par défaut la cellule contient le titre du `Workshop`
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Couleur de fond de la cellule en harmonie avec la couleur de fond de la vue
            cell.backgroundColor = view.backgroundColor
        
        if let workshop = fetchedResultsController?.object(at: indexPath) as? Workshop {
            cell.textLabel?.text = workshop.title?.uppercased()
            cell.detailTextLabel?.text = workshop.resume
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let target = storyboard?.instantiateViewController(withIdentifier: "DetailScreen") as? DetailScreen
        
        self.navigationController?.pushViewController(target!, animated: true)
        let workshop = fetchedResultsController?.object(at: indexPath) as? Workshop
        
        target?.call(entity: workshop!, type: type, color: self.view.backgroundColor!)
    }
}

