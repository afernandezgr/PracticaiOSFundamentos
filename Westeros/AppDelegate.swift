//
//  AppDelegate.swift
//  Westeros
//
//  Created by Adolfo Fernandez on 08/02/2018.
//  Copyright © 2018 Adolfo Fernandez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  {

    var window: UIWindow?
     
    var houseListViewController : HouseListViewController?
    var seasonListViewController: SeasonListViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.backgroundColor = .cyan
        window?.makeKeyAndVisible()
        
        
        // Crear los modelos
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons

        // Creamos los controladores (masterVC, detailVC)
        // masterVC estará compuesto por un UITabBarController que contendrá
        // tab1: HouseListViewController empequetado en un UINavigationController
        // tab2: SeasonListViewController empaquetado en un UINavigationController

        //tab1 de TabBar (Houses)
        houseListViewController = HouseListViewController(model: houses)
        let lastSelectedHouse = houseListViewController?.lastSelectedHouse()
        let houseDetailViewController = HouseDetailViewController(model: lastSelectedHouse!)
                
        //tab2 de TabBar (Seasons)
        seasonListViewController = SeasonListViewController(model: seasons)
        let seasonDetailViewController = SeasonDetailViewController(model: seasons.first!)
        
        let tabBarController = UITabBarController()
        //antes de meterlo en el tabBar los 'wrapeamos' en un NavigationController
        //tabBarController.viewControllers = [houseListViewController!,seasonListViewController!]
        tabBarController.viewControllers = [(houseListViewController?.wrappedInNavigation())!,(seasonListViewController?.wrappedInNavigation())!]
        
        
        //El delegado de la tabBar será la propia AppDelegate que implementar el protocolo correspondiente, ver extensiones mas abajo
        tabBarController.delegate = self
        
        // Asignar delegados
        houseListViewController?.delegate = houseDetailViewController
        seasonListViewController?.delegate = seasonDetailViewController
        
        // Crear el UISplitVC y le asignamos los viewControllers (master y detail)
        // Configuramos splitVC para hacerle delegado de si mismo, más abajo configuramos el Delegado del SplitVC para controlar el comportamiento al colapsarse

        let splitViewController = UISplitViewController()
        splitViewController.delegate = self
        splitViewController.preferredDisplayMode = .allVisible
        splitViewController.viewControllers = [
              tabBarController, houseDetailViewController.wrappedInNavigation()
        ]
        
        // Asignamos el rootVC
        window?.rootViewController = splitViewController
        
        UINavigationBar.appearance().backgroundColor = .blue
        
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
    }

 

}



extension AppDelegate : UITabBarControllerDelegate {

   
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            
            //Detectamos el VC que ha generado el evento y en función de eso modificamos el ShowDetailVC
            if (viewController as! UINavigationController).topViewController  is SeasonListViewController {
                let season = ((viewController as! UINavigationController).topViewController as! SeasonListViewController).lastSelectedSeason()
                let seasonDetailViewController = SeasonDetailViewController(model: season)
                seasonListViewController?.delegate = seasonDetailViewController
                if !(self.window?.rootViewController as! UISplitViewController).isCollapsed  {
                   self.window?.rootViewController?.showDetailViewController(seasonDetailViewController.wrappedInNavigation(), sender: nil)
                }
            }
            else if (viewController as! UINavigationController).topViewController is HouseListViewController {
                let house = ((viewController as! UINavigationController).topViewController as! HouseListViewController).lastSelectedHouse()
                let houseDetailViewController = HouseDetailViewController(model: house)
                houseListViewController?.delegate = houseDetailViewController
                if !(self.window?.rootViewController as! UISplitViewController).isCollapsed  {
                   self.window?.rootViewController?.showDetailViewController(houseDetailViewController.wrappedInNavigation(), sender: nil)
                }
           }
        }
}

extension AppDelegate: UISplitViewControllerDelegate {
    
    //en caso de que colapse especificamos el VC a mostrar
    func primaryViewController(forCollapsing splitViewController: UISplitViewController) -> UIViewController? {
        return splitViewController.viewControllers.first
    }
    
   func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary sencondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
   }
}

    
   
