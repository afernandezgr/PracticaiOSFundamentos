//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Adolfo Fernandez on 25/2/18.
//  Copyright © 2018 Alexandre Freire. All rights reserved.
//

import UIKit

class MemberDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var houseNameLabel: UILabel!
    
    // MARK: - Properties
    var model: Person
    
    // MARK: - Initizalization
    init(model: Person){
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

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        syncModelWithView()
    }
    
    
    // Mark: - Sync
    func syncModelWithView() {
        // Model -> View
        nameLabel.text = "\(model.name)"
        aliasLabel.text = "\(model.alias)"
        houseNameLabel.text = "\(model.house.name)"

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
