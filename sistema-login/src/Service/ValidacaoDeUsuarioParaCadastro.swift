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
              let repeticaoDeSenha = repeticaoDeSenhaDoUsuario
        else {
            self.controladorDeErros.adicionarErro(erro: .erro_algum_dado_do_usuario_esta_nulo)
            return false
        }
        
        var usuarioPodeSerCadastrado = true
        
        if
            !self.validacoesDoNickNameDoUsuario(nickName) ||
            !self.validacoesDoNomeCompletoDoUsuario(nomeCompleto) ||
            !self.validacoesDoEmailDoUsuario(email) ||
            !self.validacoesDaSenhaDoUsuario(senha) ||
            !self.validacoesDaRepeticaoDeSenhaDoUsuario(senha, repeticaoDeSenha)
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
        
        let nickNameDoUsuarioTemMaisDe32Caracteres = strlen(nickName) > 32
        if nickNameDoUsuarioTemMaisDe32Caracteres {
            self.controladorDeErros.adicionarErro(erro: .erro_nick_de_usuario_nao_pode_ter_mais_de_32_caracteres)
        }
        
        let nickNameDoUsuarioNaoEUmAlfaNumerico = !nickName.isAlphanumeric
        if nickNameDoUsuarioNaoEUmAlfaNumerico {
            self.controladorDeErros.adicionarErro(erro: .erro_nick_de_usuario_nao_e_um_alfanumerico)
            
            isValid = false
        }
        
        return isValid
    }
    
    private func validacoesDoNomeCompletoDoUsuario(_ nomeCompleto: String) -> Bool {
        var isValid = true
        
        let nomeCompletoDoUsuarioEstaVazio = strlen(nomeCompleto) == 0
        if nomeCompletoDoUsuarioEstaVazio {
            self.controladorDeErros.adicionarErro(erro: .erro_nome_completo_vazio)
            
            isValid = false
        }
        
        let nomeCompletoDoUsuarioContemCaracteresInvalidos = !nomeCompleto.isAlphabetic
        if nomeCompletoDoUsuarioContemCaracteresInvalidos {
            self.controladorDeErros.adicionarErro(erro: .erro_nome_completo_contem_caracteres_invalidos)
            
            isValid = false
        }
        
        let nomeCompletoDoUsuarioTemMaisDe130Caracteres = strlen(nomeCompleto) > 130
        if nomeCompletoDoUsuarioTemMaisDe130Caracteres {
            self.controladorDeErros.adicionarErro(erro: .erro_nome_completo_nao_pode_ter_mais_de_130_caracteres)
            
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
        
        let emailDoUsuarioNaoEValido = !self.emailEValido(email)
        if emailDoUsuarioNaoEValido {
            self.controladorDeErros.adicionarErro(erro: .erro_email_invalido)
            
            isValid = false
        }
        
        let emailDoUsuarioTemMaisDe150caracteres = strlen(email) > 150
        if emailDoUsuarioTemMaisDe150caracteres {
            self.controladorDeErros.adicionarErro(erro: .erro_email_tem_mais_de_150_caracteres)
            
            isValid = false
        }
        
        return isValid
    }
    
    private func emailEValido(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func validacoesDaSenhaDoUsuario(_ senha: String) -> Bool {
        var isValid = true
        
        let senhaDoUsuarioEstaVazia = strlen(senha) == 0
        if senhaDoUsuarioEstaVazia {
            self.controladorDeErros.adicionarErro(erro: .erro_senha_vazia)
            
            isValid = false
        }
        
        let senhaDoUsuarioTemMenosQue8Caracteres = strlen(senha) < 8
        if senhaDoUsuarioTemMenosQue8Caracteres {
            self.controladorDeErros.adicionarErro(erro: .erro_senha_tem_menos_de_8_caracteres)
            
            isValid = false
        }
        
        let senhaDoUsuarioTemMaisQue32Caracteres = strlen(senha) > 32
        if senhaDoUsuarioTemMaisQue32Caracteres {
            self.controladorDeErros.adicionarErro(erro: .erro_senha_tem_mais_de_32_caracteres)
            
            isValid = false
        }
        
        return isValid
    }
    
    private func validacoesDaRepeticaoDeSenhaDoUsuario(_ senha: String, _ repeticaoDeSenha: String) -> Bool {
        var isValid = true
        
        let repeticaoDaSenhaDoUsuarioEstaVazia = strlen(repeticaoDeSenha) == 0
        if repeticaoDaSenhaDoUsuarioEstaVazia {
            self.controladorDeErros.adicionarErro(erro: .erro_repeticao_de_senha_vazio)
            
            isValid = false
        }
        
        let repeticaoDaSenhaDoUsuarioEDiferenteDaSenha = senha != repeticaoDeSenha
        if repeticaoDaSenhaDoUsuarioEDiferenteDaSenha {
            self.controladorDeErros.adicionarErro(erro: .erro_repeticao_de_senha_e_senha_sao_diferentes)
            
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
    
    var isAlphabetic: Bool {
        !isEmpty && range(of: "[^A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ' ]", options: .regularExpression) == nil
    }
}
