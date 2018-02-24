//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by Adolfo Fernandez on 24/2/18.
//  Copyright © 2018 Alexandre Freire. All rights reserved.
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
    }
    
    
    // Mark: - Sync
    func syncModelWithView() {
        // Model -> View
        episodeNameLabel.text = "\(model.name)"
        
        launchDateLabel.text = model.launchDate.toString(dateFormat: "dd-MM-YYYY")
        
        
    }

   

    

}
