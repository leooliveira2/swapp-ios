//
//  RecuperacaoDeSenhaViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 22/11/22.
//

import UIKit

class RecuperacaoDeSenhaViewController: UIViewController {
    
    // MARK: - View
    private lazy var recuperacaoDeSenhaView: RecuperacaoDeSenhaView = {
        let view = RecuperacaoDeSenhaView()
        return view
    }()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.recuperacaoDeSenhaView
        
        self.recuperacaoDeSenhaView.getBuscarUsuarioButton().addTarget(
            self,
            action: #selector(buscaUsuarioParaRedefinicaoDeSenha(_:)),
            for: .touchUpInside
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
    @objc private func buscaUsuarioParaRedefinicaoDeSenha(_ sender: UIButton) -> Void {
        let controladorDeErros = ControladorDeErros()
        let validadorDeDadosDoUsuario = ValidacoesDeDadosDoUsuario(controladorDeErros)
        let recuperarSenhaController = RecuperacaoDeSenhaController(
            controladorDeErros,
            validadorDeDadosDoUsuario
        )
        
        let verificadorDeDadosCadastrados = VerificadorDeDadosCadastradosSystem()
        
        let usuarioFoiEncontrado = recuperarSenhaController.buscaUsuarioParaRedefinicaoDeSenha(
            email: self.recuperacaoDeSenhaView.getEmailDoUsuario(),
            verificadorDeDadosCadastrados: verificadorDeDadosCadastrados
        )
        
        if !usuarioFoiEncontrado {
            let alertas = Alerta(viewController: self)
            let erros = controladorDeErros.getErros()
            
            if erros.count > 0 {
                alertas.criaAlerta(mensagem: erros[0].rawValue)
            }
            
            return
        }
        
        self.recuperacaoDeSenhaView.configurarComponentesNecessariosParaRedefinicaoDaSenha()
        return
        
    }
    
    @objc private func verificaSeSenhaPodeSerAlterada(_ sender: UIButton) -> Void {
        let controladorDeErros = ControladorDeErros()
        let validadorDeSenha = ValidacoesDeDadosDoUsuario(controladorDeErros)
        let redefinicaoDeSenha = RedefinicaoDeSenhaSystem()
        let recuperacaoDeSenhaController = RecuperacaoDeSenhaController(controladorDeErros, validadorDeSenha, redefinicaoDeSenha)
        let alerta = Alerta(viewController: self)
        
        let novaSenhaFoiSalva = recuperacaoDeSenhaController.alterarSenha(
            email: self.recuperacaoDeSenhaView.getEmailDoUsuario(),
            senha: self.recuperacaoDeSenhaView.getNovaSenha(),
            repeticaoSenha: self.recuperacaoDeSenhaView.getRepeticaoNovaSenha()
        )
        
        if !novaSenhaFoiSalva {
            let erros = controladorDeErros.getErros()
            if erros.count > 0 {
                alerta.criaAlerta(mensagem: erros[0].rawValue)
                return
            }
        }
        
        guard let navigationController = self.navigationController else {
            alerta.criaAlerta(titulo: "Sucesso", mensagem: "Senha Alterada com sucesso!")
            return
        }
        
        navigationController.popViewController(animated: true)
    }
}
