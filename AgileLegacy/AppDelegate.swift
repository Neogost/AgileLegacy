//
//  AppDelegate.swift
//  AgileLegacy
//
//  Created by Kevin Desmay on 14/09/2019.
//  Copyright © 2019 Kevin Desmay. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        preloadedData()
        
        // Mise a jour de l'application, version du build : V1.02
        maj102()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        PersistanceService.saveContext()
    }

    /// Permet de chargé les données par défaut de l'application au premier lancement de celle-ci.
    /// Met a jour le paramettre `didPreloadData` pour savoir si les données doivent être réinjecté.
    private func preloadedData() {
        
        // Définition du paramettre
        let preloadedDataKey = "didPreloadData"
        
        // Récupération des données de l'utilisateur par rapport à l'application
        let userDefaults = UserDefaults.standard
        
        // Si les données ne sont pas encore initialisé
        if userDefaults.bool(forKey: preloadedDataKey) == false {
            print("Exécution de la mise à jour 1.00")
            
            // Récupération des données à chargé dans le fichier des data preloadedData.plist
            guard let urlPath = Bundle.main.url(forResource: "preloadedData", withExtension: "plist") else {
                return
            }
            
            // Récupération du service de persistance.
            let backgroundContext = PersistanceService.persistentContainer.newBackgroundContext()
            PersistanceService.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
            
            backgroundContext.perform {
                
                // récupération des données dans le fichier .plist
                // Extraction des objets métiers
                if let datas = NSArray(contentsOf: urlPath) as? [Dictionary<String,AnyObject>] {
                    
                    do {
                        for workshopList in datas {
                            let workshopObject = Workshop(context: backgroundContext)
                            for (key,value) in workshopList {
                                
                                switch(key) {
                                case "id":
                                   workshopObject.id = UUID(uuidString: value as! String)
                                    break
                                
                                case "nbPeopleMax":
                                    workshopObject.nbPeopleMax = Int16(truncating: value as! NSNumber)
                                    break;
                                case "nbPeopleMin":
                                    workshopObject.nbPeopleMin = Int16(truncating: value as! NSNumber)
                                    break;
                                case "title":
                                    workshopObject.title = value as? String
                                    break
                                case "resume":
                                    workshopObject.resume = value as? String
                                    break
                                case "detail":
                                    workshopObject.detail = value as? String
                                    break
                                case "source":
                                    workshopObject.source = value as? String
                                    break
                                case "durationMax":
                                    workshopObject.durationMax = Int16(truncating: value as! NSNumber)
                                    break
                                case "durationMin":
                                    workshopObject.durationMin = Int16(truncating: value as! NSNumber)
                                    break
                                case "type":
                                    workshopObject.type = value as? String
                                    break
                                case "archived":
                                    workshopObject.archived = value.boolValue
                                    break
                                case "difficulty":
                                    workshopObject.difficulty = Int16(truncating: value as! NSNumber)
                                    break
                                case "materiel":
                                    workshopObject.materialList = value as? String
                                    break
                                default:
                                    break
                                }
                            }
                        }
                        
                        // Sauvegarde
                        try backgroundContext.save()
                        print("DATA AS BEEN ADDED TO THE BDD OF THE APPLICATION")
                        
                        // Mise à jour du paramettre de préchargement des données à true
                        userDefaults.set(true, forKey: preloadedDataKey)
                        userDefaults.set(true, forKey: "maj102")
                    } catch {
                        print("Error : " + error.localizedDescription)
                    }
                    
                }
            }
            
        } else {
            print("Non exécution de la mise en base des données par défaut")
        }
    }

    /// Initialisation des données de l'applicaiton suite à la mise en place de la version de l'application en V1.02. Dans celle-ci est inclu les modifications suivantes sur les données :
    private func maj102() {
        let userDefaults = UserDefaults.standard
        
        // Parametre d'import des données préinitialiser
        let preloadedDataKey = "didPreloadData"
        
        // Parametre d'import des mises a jour effectué sous le tag V1.02
        let maj102Parameter = "maj102"
        
        if userDefaults.bool(forKey: preloadedDataKey) == true && userDefaults.bool(forKey: maj102Parameter) == false{
            print("Exécution de la mise à jour 1.02")
            // Suppression des données dans la bases de données
            let managedContext = PersistanceService.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Workshop")
            fetchRequest.returnsObjectsAsFaults = false

            do
            {
                let results = try managedContext.fetch(fetchRequest)
                for managedObject in results
                {
                    let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                    managedContext.delete(managedObjectData)
                }
            } catch let error as NSError {
                print("Detele all data in \(Workshop()) error : \(error) \(error.userInfo)")
            }
            
            // remise à zero du tag didPreloadData

            userDefaults.set(false, forKey: preloadedDataKey)
            // Initialisation du tag maj102 à appliqué
            userDefaults.set(true, forKey: maj102Parameter)
            
            // réexécution de didPreloadData
            preloadedData();
        } else {
            print("Non exécution de la mise à jour 1.02")
        }
    }
}



extension String {
    var bool: Bool? {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return nil
        }
    }
}
