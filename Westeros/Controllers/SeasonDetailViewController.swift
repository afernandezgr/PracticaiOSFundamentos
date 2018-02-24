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
        syncModelWithView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    
    // Mark: - Sync
    func syncModelWithView() {
        // Model -> View
        seasonNameLabel.text = "Nombre de la temporada: \(model.name)"
       
        releaseDateLabel.text = model.releaseDate.toString(dateFormat: "dd-MM-YYYY")
        
        
    }
    
  
 
}

extension SeasonDetailViewController: SeasonListViewControllerDelegate {
    func seasonListViewController(_ viewController: SeasonListViewController, didSelectSeason season: Season) {
        self.model = season
        syncModelWithView()
    }
}
