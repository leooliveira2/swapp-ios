//
//  ValidacaoDeUsuarioParaCadastro.swift
//  sistema-login
//
//  Created by Leonardo Leite on 08/11/22.
//

import UIKit

class ValidacaoDeUsuarioParaCadastro: NSObject {
    
    // MARK: - Atributos
    private let controladorDeErros: ControladorDeErros
    
    // MARK: - Inicializador
    init(controladorDeErros: ControladorDeErros) {
        self.controladorDeErros = controladorDeErros
    }
    
    // MARK: - Funcao principal
    public func usuarioPodeSerCadastrado(
        nickNameDoUsuario: String?,
        nomeCompletoDoUsuario: String?,
        emailDoUsuario: String?,
        senhaDoUsuario: String?,
        repeticaoDeSenhaDoUsuario: String?
    ) -> Bool {
        
        guard let nickName = nickNameDoUsuario,
              let nomeCompleto = nomeCompletoDoUsuario,
              let email = emailDoUsuario,
              let senha = senhaDoUsuario,
              let repeticaoDeSenha = repeticaoDeSenhaDoUsuario else { return false } // fazer essa validacao dps
        
        var usuarioPodeSerCadastrado = true
        
        if
            !self.validacoesDoNickNameDoUsuario(nickName) ||
            !self.validacoesDoNomeCompletoDoUsuario(nomeCompleto) ||
            !self.validacoesDoEmailDoUsuario(email) ||
            !self.validacoesDaSenhaDoUsuario(senha) ||
            !self.validacoesDaRepeticaoDeSenhaDoUsuario(repeticaoDeSenha)
        {
            usuarioPodeSerCadastrado = false
        }
        
        return usuarioPodeSerCadastrado
    }
    
    // MARK: - Funcoes secundarias
    private func validacoesDoNickNameDoUsuario(_ nickName: String) -> Bool {
        var isValid = true
        
        let nickNameDoUsuarioEstaVazio = strlen(nickName) == 0
        if nickNameDoUsuarioEstaVazio {
            self.controladorDeErros.adicionarErro(erro: .erro_nick_de_usuario_vazio)
            
            isValid = false
        }
        
        let nickNameDoUsuarioTemMenosDe5Caracteres = strlen(nickName) < 5
        if nickNameDoUsuarioTemMenosDe5Caracteres {
            self.controladorDeErros.adicionarErro(erro: .erro_nick_de_usuario_tem_menos_de_5_caracteres)
            
            isValid = false
        }
        
        let nickNameDoUsuarioNaoÉUmAlfaNumerico = !nickName.isAlphanumeric
        if nickNameDoUsuarioNaoÉUmAlfaNumerico {
            self.controladorDeErros.adicionarErro(erro: .erro_nick_de_usuario_nao_e_um_alfanumerico)
        }
        
        return isValid
    }
    
    private func validacoesDoNomeCompletoDoUsuario(_ nomeCompleto: String) -> Bool {
        var isValid = true
        
        let nomeCompletoDoUsuarioEstaVazio = strlen(nomeCompleto) == 0
        if nomeCompletoDoUsuarioEstaVazio {
            self.controladorDeErros.adicionarErro(erro: .erro_nome_vazio)
            
            isValid = false
        }
        
        return isValid
    }
    
    private func validacoesDoEmailDoUsuario(_ email: String) -> Bool {
        var isValid = true
        
        let emailDoUsuarioEstaVazio = strlen(email) == 0
        if emailDoUsuarioEstaVazio {
            self.controladorDeErros.adicionarErro(erro: .erro_email_vazio)
            
            isValid = false
        }
        
        return isValid
    }
    
    private func validacoesDaSenhaDoUsuario(_ senha: String) -> Bool {
        var isValid = true
        
        let senhaDoUsuarioEstaVazia = strlen(senha) == 0
        if senhaDoUsuarioEstaVazia {
            self.controladorDeErros.adicionarErro(erro: .erro_senha_vazia)
            
            isValid = false
        }
        
        return isValid
    }
    
    private func validacoesDaRepeticaoDeSenhaDoUsuario(_ repeticaoDeSenha: String) -> Bool {
        var isValid = true
        
        let repeticaoDaSenhaDoUsuarioEstaVazia = strlen(repeticaoDeSenha) == 0
        if repeticaoDaSenhaDoUsuarioEstaVazia {
            self.controladorDeErros.adicionarErro(erro: .erro_repeticao_de_senha_vazio)
            
            isValid = false
        }
        
        return isValid
    }
}

// MARK: - Extensoes
extension String {
    var isAlphanumeric: Bool {
        !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}
