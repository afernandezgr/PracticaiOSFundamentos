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
    var model: [Episode]
    
    // MARK: - Initialization
    init(model: [Episode]){
        self.model = model
        super.init(style: .plain)
        title = model.first?.season?.name
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Nos damos de alta ...
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange), name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: nil)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja ...
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Notifications
    @objc func seasonDidChange(notification: Notification) {
        // Extraer el userInfo de la notification
        guard let info = notification.userInfo else {
            return
        }
        
        // Sacar la season del userInfo
        let season = info[SEASON_KEY] as? Season
        
        // Actualizar el modelo
        model = (season?.sortedEpisodes)!
        
        // Sincronizar la vista
        tableView.reloadData()
        title = season?.name
        
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
