//
//  PersonagemViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class PersonagemViewController: UIViewController {

    private lazy var personagemView: PersonagemView = {
        let view = PersonagemView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = self.personagemView
    }

}
