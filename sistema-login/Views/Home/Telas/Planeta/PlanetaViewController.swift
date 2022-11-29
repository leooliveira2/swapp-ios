//
//  PlanetaViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class PlanetaViewController: UIViewController {
    
    private lazy var planetaView: PlanetaView = {
        let view = PlanetaView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.planetaView
    }

}
