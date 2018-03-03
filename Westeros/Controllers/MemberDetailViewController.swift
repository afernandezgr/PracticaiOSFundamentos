//
//  MemberDetailViewController.swift
//  Westeros
//
//  Created by Adolfo Fernandez on 25/2/18.
//  Copyright © 2018 Adolfo Fernandez. All rights reserved.
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
        
        // Nos damos de alta ...
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: Notification.Name(HOUSE_DID_CHANGE_NOTIFICATION_NAME), object: nil)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Nos damos de baja ...
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    // MARK: - Notifications
    @objc func houseDidChange(notification: Notification) {
        
        //Si recibimos el cambio de casa desapilamos los VC para dejarlo en la vista detalle de la casa
        navigationController?.popToRootViewController(animated: true)
        
    }
    
    
    // Mark: - Sync
    func syncModelWithView() {
        // Model -> View
        nameLabel.text = "\(model.name)"
        aliasLabel.text = "\(model.alias)"
        houseNameLabel.text = "\(model.house.name)"
        title = model.name

    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
