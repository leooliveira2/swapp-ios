//
//  RecuperacaoDeSenhaViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 22/11/22.
//

import UIKit

class RecuperacaoDeSenhaViewController: UIViewController {
    
    private lazy var recuperacaoDeSenhaView: RecuperacaoDeSenhaView = {
        let view = RecuperacaoDeSenhaView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.recuperacaoDeSenhaView
    }

}
