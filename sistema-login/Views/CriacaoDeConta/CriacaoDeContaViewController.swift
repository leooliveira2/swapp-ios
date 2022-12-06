//
//  CriacaoDeContaViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 07/11/22.
//

import UIKit

class CriacaoDeContaViewController: UIViewController {
    
    // MARK: - Atributos
    private lazy var criacaoDeContaView: CriacaoDeContaView = {
        let view = CriacaoDeContaView()
        return view
    }()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = self.criacaoDeContaView
        self.criacaoDeContaView.getBotaoCriarConta().addTarget(self, action: #selector(criacaoDeConta(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Voltar"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Funcoes
    @objc private func criacaoDeConta(_ sender: UIButton) -> Void {
        
        let controladorDeErros = ControladorDeErros()
        let validadorDeUsuario = ValidacoesDeDadosDoUsuario(controladorDeErros)
        let salvarUsuario = SalvarUsuarioStaticClass()
        let verificadorDeNickNamesJaCadastrados = VerificadorDeNickNamesJaCadastradosStaticClass()
        let verificadorDeEmailsJaCadastrados = VerificadorDeEmailsJaCadastradosStaticClass()
        
        let controlador = CriacaoDeContaController(
            controladorDeErros,
            validadorDeUsuario,
            salvarUsuario,
            verificadorDeNickNamesJaCadastrados,
            verificadorDeEmailsJaCadastrados
        )
        
        let contaFoiCriada = controlador.criarConta(
            nickName: self.criacaoDeContaView.getNickNameDoUsuario(),
            nomeCompleto: self.criacaoDeContaView.getNomeCompletoDoUsuario(),
            email: self.criacaoDeContaView.getEmailDoUsuario(),
            senha: self.criacaoDeContaView.getSenhaDoUsuario(),
            repeticaoDeSenha: self.criacaoDeContaView.getRepeticaoDeSenhaDoUsuario()
        )
        
        let alertas = Alerta(viewController: self)
        
        if !contaFoiCriada {
            let listaDeErros = controladorDeErros.getErros()
            if listaDeErros.count > 0 {
                alertas.criaAlerta(mensagem: listaDeErros[0])
                return
            }
        }
        
        guard let navigationController = self.navigationController else {
            alertas.criaAlerta(titulo: "Sucesso!", mensagem: "Usuário foi salvo com sucesso")
            return
        }
        
        navigationController.popViewController(animated: true)
    }

}
