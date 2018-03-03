//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Adolfo Fernandez on 24/2/18.
//  Copyright © 2018 Adolfo Fernandez. All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {

    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    
    
    // MARK: - Properties
    var model: Episode
    
    // MARK: - Initizalization
    init(model: Episode){
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
        
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
 
        //Si recibimos el cambio de temporada desapilamos los VC para dejarlo en la vista detalle de la temporada
        navigationController?.popToRootViewController(animated: true)
  
    }
    
    // Mark: - Sync
    func syncModelWithView() {
        // Model -> View
        episodeNameLabel.text = "\(model.name)"
        launchDateLabel.text = model.launchDate.toString(dateFormat: "dd-MM-YYYY")
        title = model.name
    }


}
