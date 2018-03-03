//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by Adolfo Fernandez on 24/2/18.
//  Copyright © 2018 Adolfo Fernandez. All rights reserved.
//

import UIKit

//Constantes en fichero Constants.swift

protocol SeasonListViewControllerDelegate: class {
    // should, will, did
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason: Season)
}

class SeasonListViewController: UITableViewController {
    
    // MARK: - Properties
    let model: [Season]
    weak var delegate: SeasonListViewControllerDelegate?

    // MARK: - Initialization
    init(model: [Season]){
        self.model = model
        super.init(style: .plain)
        title = "Seasons"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellId = "SeasonCell"
        
        // Descubrir cual es la season que tenemos que mostrar
        let season = model[indexPath.row]
        
        // Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincroniza season (model) con cell (vista)
        cell?.textLabel?.text = season.name
        
        return cell!
        
    }
    
    // MARK: Table View Delegate
    // should, will, did
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar que season han pulsado
        let season = model[indexPath.row]
        
        if  splitViewController!.isCollapsed { //hacemos push del VC en caso de estar en modo colapsado
          let seasonDetailViewController = SeasonDetailViewController(model: season)
          // Hacemos push
          navigationController?.pushViewController(seasonDetailViewController, animated: true)
        }
        
        // Aviso al delegado
        delegate?.seasonListViewController(self, didSelectSeason: season)
    
        
        // Mando la misma info a traves de notificaciones para avisar a las VC que están a la 'escucha'
        let notificationCenter = NotificationCenter.default
        let notification = Notification(name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [SEASON_KEY : season])
        notificationCenter.post(notification)
        
        // Guardar las coordenadas (section, row) de la ultima casa seleccionada
        saveLastSelectedSeason(at: indexPath.row)

    }
    
    
    
}

extension SeasonListViewController {
    func saveLastSelectedSeason(at row: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: LAST_SEASON)
        // Por si las moscas
        defaults.synchronize()
    }
    
    func lastSelectedSeason() -> Season {
        // Extraer la row del User Defaults
        let row = UserDefaults.standard.integer(forKey: LAST_SEASON)
        
        // Averiguar la season de ese row
        let season = model[row]
        
        // Devolverla
        return season
    }
}
