//
//  ValidacaoDeUsuarioParaCadastro.swift
//  sistema-login
//
//  Created by Leonardo Leite on 08/11/22.
//

import UIKit

class ValidacaoDeUsuarioParaCadastro: NSObject {
    
    private let controladorDeErros: ControladorDeErros
    
    init(controladorDeErros: ControladorDeErros) {
        self.controladorDeErros = controladorDeErros
    }
    
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
    
    private func validacoesDoNickNameDoUsuario(_ nickName: String) -> Bool {
        let nickNameDoUsuarioEstaVazio = strlen(nickName) == 0
        if nickNameDoUsuarioEstaVazio {
            self.controladorDeErros.adicionarErro(erro: .erro_usuario_vazio)
            
            return false
        }
        
        return true
    }
    
    private func validacoesDoNomeCompletoDoUsuario(_ nomeCompleto: String) -> Bool {
        let nomeCompletoDoUsuarioEstaVazio = strlen(nomeCompleto) == 0
        if nomeCompletoDoUsuarioEstaVazio {
            self.controladorDeErros.adicionarErro(erro: .erro_nome_vazio)
            
            return false
        }
        
        return true
    }
    
    private func validacoesDoEmailDoUsuario(_ email: String) -> Bool {
        let emailDoUsuarioEstaVazio = strlen(email) == 0
        if emailDoUsuarioEstaVazio {
            self.controladorDeErros.adicionarErro(erro: .erro_email_vazio)
            
            return false
        }
        
        return true
    }
    
    private func validacoesDaSenhaDoUsuario(_ senha: String) -> Bool {
        let senhaDoUsuarioEstaVazia = strlen(senha) == 0
        if senhaDoUsuarioEstaVazia {
            self.controladorDeErros.adicionarErro(erro: .erro_senha_vazia)
            
            return false
        }
        
        return true
    }
    
    private func validacoesDaRepeticaoDeSenhaDoUsuario(_ repeticaoDeSenha: String) -> Bool {
        let repeticaoDaSenhaDoUsuarioEstaVazia = strlen(repeticaoDeSenha) == 0
        if repeticaoDaSenhaDoUsuarioEstaVazia {
            self.controladorDeErros.adicionarErro(erro: .erro_repeticao_de_senha_vazio)
            
            return false
        }
        
        return true
    }
}
