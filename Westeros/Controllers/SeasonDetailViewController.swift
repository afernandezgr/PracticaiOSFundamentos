//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by Adolfo Fernandez on 24/2/18.
//  Copyright © 2018 Alexandre Freire. All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var seasonNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    
    // MARK: - Properties
    var model: Season
    
    // MARK: - Initizalization
    init(model: Season){
        //Limpiamos desorden propio
        self.model = model
        
        //Llamamos a super
        super.init(nibName: nil, bundle: Bundle(for: type(of: self)))
        title = model.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Nos damos de alta ...
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange), name: Notification.Name(SEASON_DID_CHANGE_NOTIFICATION_NAME), object: nil)
        
        setupUI()
        syncModelWithView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja ...
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    // MARK: - Notifications
    @objc func seasonDidChange(notification: Notification) {
        // Extraer el userInfo de la notification
        guard let info = notification.userInfo else {
            return
        }
        
        // Sacar la casa del userInfo
        let season = info[SEASON_KEY] as? Season
        
        // Actualizar el modelo
        model = season!
        
        // Sincronizar la vista
        syncModelWithView()
    }
    
    // Mark: - Sync
    func syncModelWithView() {
        // Model -> View
        seasonNameLabel.text = "Nombre de la temporada: \(model.name)"
        releaseDateLabel.text = model.releaseDate.toString(dateFormat: "dd-MM-YYYY")
        title = model.name
        
    }
    

    // MARK: - UI
    func setupUI() {
       
        let episodes = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        
        navigationItem.rightBarButtonItems = [episodes]
    }
    
    @objc func displayEpisodes() {
        // Creamos el VC
        let episodesListViewController = EpisodeListViewController(model: model.sortedEpisodes)
        
        // Hacemos Push
        let backItem = UIBarButtonItem()
        backItem.title = "Season Details"
        navigationItem.backBarButtonItem = backItem
        
        navigationController?.pushViewController(episodesListViewController, animated: true)
    }

 
}

extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason season: Season) {
        self.model = season
        syncModelWithView()
    }
}
