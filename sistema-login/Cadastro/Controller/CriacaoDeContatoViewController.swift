//
//  CriacaoDeContatoViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 07/11/22.
//

import UIKit

class CriacaoDeContatoViewController: UIViewController {
    
    // MARK: - Atributos
    private var criacaoDeContatoScreen: CriacaoDeContatoScreen?
    
    override func loadView() {
        self.criacaoDeContatoScreen = CriacaoDeContatoScreen(frame: .zero, criacaoDeContatoViewController: self)
        self.view = self.criacaoDeContatoScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        // self.navigationController?.navigationBar.backItem?.title = "Voltar" esse ou o de baixo
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Voltar"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    @objc public func criarConta(_ sender: UIButton) -> Void {
        
    }

}
