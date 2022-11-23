//
//  ValidacaoDeLogin.swift
//  sistema-login
//
//  Created by Leonardo Leite on 10/11/22.
//

import UIKit

class ValidacaoDeLogin: NSObject {
    
    private let controladorDeErros: ControladorDeErros
    
    init(_ controladorDeErros: ControladorDeErros) {
        self.controladorDeErros = controladorDeErros
    }
    
    public func loginPodeSerRealizado(
        emailDoUsuario: String?,
        senhaDoUsuario: String?
    ) -> Bool {
        guard let email = emailDoUsuario,
              let senha = senhaDoUsuario
        else {
            self.controladorDeErros.adicionarErro(erro: .erro_algum_dado_do_usuario_esta_nulo)
            return false
        }
        
        let emailOuSenhaEstaoVazios = strlen(email) == 0 || strlen(senha) == 0
        if emailOuSenhaEstaoVazios {
            self.controladorDeErros.adicionarErro(erro: .erro_email_e_senha_devem_ser_ambos_preenchidos)
            
            return false
        }
        
        var emailESenhaEstaoCadastrados = false
        
        let listaDeUsuarios = UsuarioDao.getUsuariosSalvos()
        for usuario in listaDeUsuarios {
            if email == usuario.getEmailDoUsuario() &&
                senha == usuario.getSenhaDoUsuario() {
                emailESenhaEstaoCadastrados = true
                break
            }
        }
        
        if !emailESenhaEstaoCadastrados {
            self.controladorDeErros.adicionarErro(erro: .erro_cadastro_nao_encontrado)
        }
        
        return emailESenhaEstaoCadastrados
    }
}
