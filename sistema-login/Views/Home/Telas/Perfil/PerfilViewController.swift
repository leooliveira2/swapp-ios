//
//  SairViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 02/12/22.
//

import UIKit

class PerfilViewController: UIViewController {

    // MARK: - Atributos
    private lazy var perfilView: PerfilView = {
        let view = PerfilView()
        return view
    }()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.perfilView
        
        self.perfilView.getNickUsuarioLabel().text = "leonardo"
        
        self.perfilView.getBotaoSairButton().addTarget(self, action: #selector(botaoSairFoiClicado(_: )), for: .touchUpInside)

    }
    
    // MARK: - Funcoes
    @objc private func botaoSairFoiClicado(_ sender: UIButton) -> Void {
        guard let navigationController = self.navigationController else { return }
        
        navigationController.popViewController(animated: true)
    }
}