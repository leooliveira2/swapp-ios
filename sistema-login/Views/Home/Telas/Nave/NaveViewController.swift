//
//  NaveViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class NaveViewController: UIViewController {

    private lazy var naveView: NaveView = {
        let view = NaveView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = self.naveView
            
    }

}
