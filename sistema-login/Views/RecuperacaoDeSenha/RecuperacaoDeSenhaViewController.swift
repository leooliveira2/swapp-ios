//
//  RecuperacaoDeSenhaViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 22/11/22.
//

import UIKit

class RecuperacaoDeSenhaViewController: UIViewController {
    
    // MARK: - Atributos
    private lazy var recuperacaoDeSenhaView: RecuperacaoDeSenhaView = {
        let view = RecuperacaoDeSenhaView()
        return view
    }()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.recuperacaoDeSenhaView
        
        self.recuperacaoDeSenhaView.getEmailTextField().addTarget(
            self,
            action: #selector(exibeConteudoAposEmailSerDigitado(_:)),
            for: .editingChanged
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Voltar"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Funcoes
    @objc private func exibeConteudoAposEmailSerDigitado(_ sender: UITextField) -> Void {
        let usuarios = UsuarioSalvo.getUsuariosSalvos()
        
        for usuario in usuarios {
            if usuario.getEmailDoUsuario() == sender.text {
                self.recuperacaoDeSenhaView.configurarComponentesNecessariosParaRedefinicaoDaSenha()
                
                return
            }
        }
        
        self.recuperacaoDeSenhaView.configuraComponentesCasoOUsuarioNaoExista()
    }
    

}
