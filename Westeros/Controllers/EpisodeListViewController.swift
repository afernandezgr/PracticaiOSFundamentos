//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by Adolfo Fernandez on 24/2/18.
//  Copyright © 2018 Alexandre Freire. All rights reserved.
//

import UIKit

class EpisodeListViewController: UITableViewController {
 
    // MARK: - Properties
    let model: [Episode]
    
    // MARK: - Initialization
    init(model: [Episode]){
        self.model = model
        super.init(style: .plain)
        title = "Westeros"
        
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
        
        let cellId = "EpisodeCell"
        
        // Descubrir cual es la season que tenemos que mostrar
        let episode = model[indexPath.row]
        
        // Crear una celda
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincroniza season (model) con cell (vista)
        cell?.textLabel?.text = episode.name
        
        return cell!
        
    }
    
    // MARK: Table View Delegate
    // should, will, did
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar que season han pulsado
        let episode = model[indexPath.row]
        
        
        // Creamos el SeasonDetailViewController
        let episodeDetailViewController = EpisodeDetailViewController(model: episode)
        
        // Hacemos push
        navigationController?.pushViewController(episodeDetailViewController, animated: true)
        
        // Aviso al delegado
        //delegate?.seasonListViewController(self, didSelectSeason: season)
        
        //        // Mando la misma info a traves de notificaciones
        //        let notificationCenter = NotificationCenter.default
        //
        //        let notification = Notification(name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: self, userInfo: [HOUSE_KEY : house])
        //
        //        notificationCenter.post(notification)
        //
        //        // Guardar las coordenadas (section, row) de la ultima casa seleccionada
        //        saveLastSelectedHouse(at: indexPath.row)
    }
    
    
}
