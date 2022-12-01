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
        
        self.recuperacaoDeSenhaView.getAlterarSenhaButton().addTarget(
            self,
            action: #selector(verificaSeSenhaPodeSerAlterada(_:)),
            for: .touchUpInside
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Voltar"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Funcoes
    @objc private func exibeConteudoAposEmailSerDigitado(_ sender: UITextField) -> Void {
        let usuarios = UsuarioDao.getUsuariosSalvos()
        
        for usuario in usuarios {
            if usuario.getEmailDoUsuario() == sender.text {
                self.recuperacaoDeSenhaView.configurarComponentesNecessariosParaRedefinicaoDaSenha()
                
                return
            }
        }
        
        self.recuperacaoDeSenhaView.configuraComponentesCasoOUsuarioNaoExista()
    }
    
    @objc private func verificaSeSenhaPodeSerAlterada(_ sender: UIButton) -> Void {
        let controladorDeErros = ControladorDeErros()
        let validadorDeSenha = ValidacaoDeUsuarioParaCadastro(controladorDeErros)
        let redefinicaoDeSenha = RedefinicaoDeSenha()
        let recuperacaoDeSenhaController = RecuperacaoDeSenhaController(controladorDeErros, validadorDeSenha, redefinicaoDeSenha)
        let alerta = Alerta(viewController: self)
        
        let novaSenhaFoiSalva = recuperacaoDeSenhaController.alterarSenha(
            email: self.recuperacaoDeSenhaView.getEmailTextField().text,
            senha: self.recuperacaoDeSenhaView.getNovaSenha(),
            repeticaoSenha: self.recuperacaoDeSenhaView.getRepeticaoNovaSenha()
        )
        
        if !novaSenhaFoiSalva {
            let erros = controladorDeErros.getErros()
            if erros.count > 0 {
                alerta.criaAlerta(mensagem: erros[0])
                return
            }
        }
        
        guard let navigationController = self.navigationController else {
            alerta.criaAlerta(mensagem: "Senha Alterada com sucesso!")
            return
        }
        
        navigationController.popViewController(animated: true)
    }
}
