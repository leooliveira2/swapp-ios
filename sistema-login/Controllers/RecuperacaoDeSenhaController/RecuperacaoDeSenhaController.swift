//
//  RecuperacaoDeSenhaController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class RecuperacaoDeSenhaController {
    
    private let controladorDeErros: ControladorDeErros
    private let validadorDeDados: ValidacoesDeDadosDoUsuario
    private let redefinicaoDeSenha: RedefinicaoDeSenhaRepository
    
    init(
        _ controladorDeErros: ControladorDeErros = ControladorDeErros(),
        _ validadorDeDados: ValidacoesDeDadosDoUsuario = ValidacoesDeDadosDoUsuario(ControladorDeErros()),
        _ redefinicaoDeSenha: RedefinicaoDeSenhaRepository = RedefinicaoDeSenhaStaticClass()
    ) {
        self.controladorDeErros = controladorDeErros
        self.validadorDeDados = validadorDeDados
        self.redefinicaoDeSenha = redefinicaoDeSenha
    }
    
    // MARK: - Buscar usuario
    public func buscaUsuarioParaRedefinicaoDeSenha(
        email: String?,
        verificadorDeDadosCadastrados: VerificadorDeDadosCadastradosRepository
    ) -> Bool {
        guard let email = email else {
            self.controladorDeErros.adicionarErro(erro: .erro_algum_dado_do_usuario_esta_nulo)
            return false
        }
        
        let emailEValido = self.verificaSeEmailDoUsuarioEValido(email, verificadorDeDadosCadastrados)
        
        return emailEValido
    }
    
    private func verificaSeEmailDoUsuarioEValido(
        _ email: String,
        _ verificadorDeDadosCadastrados: VerificadorDeDadosCadastradosRepository
    ) -> Bool {
        let emailEstaVazio = self.validadorDeDados.emailDoUsuarioEstaVazio(email)
        let emailExiste = self.validadorDeDados.emailDoUsuarioJaEstaCadastrado(email, verificadorDeDadosCadastrados)
        
        if emailEstaVazio || !emailExiste {
            self.controladorDeErros.adicionarErro(erro: .erro_email_nao_encontrado)
            return false
        }
        
        return true
    }
    
    // MARK: - Redefinir senha
    public func alterarSenha(email: String?, senha: String?, repeticaoSenha: String?) -> Bool {
        guard let senha = senha,
              let repeticaoSenha = repeticaoSenha,
              let email = email
        else
        {
            self.controladorDeErros.adicionarErro(erro: .erro_algum_dado_do_usuario_esta_nulo)
            return false
        }
        
        let senhaPodeSerAlterada = self.verificaSeSenhaPodeSerAlterada(senha, repeticaoSenha)
        
        if !senhaPodeSerAlterada {
            return false
        }
        
        if !self.redefinicaoDeSenha.redefinirSenha(email: email, senha: senha) {
            return false
        }
        
        return true
    }
    
    private func verificaSeSenhaPodeSerAlterada(
        _ senha: String,
        _ repeticaoDeSenha: String
    ) -> Bool
    {
        
        let verificaSeSenhaEInvalida = (
            self.validadorDeDados.senhaDoUsuarioEstaVazia(senha) ||
            self.validadorDeDados.senhaDoUsuarioTemMenosQue8Caracteres(senha) ||
            self.validadorDeDados.senhaDoUsuarioTemMaisQue32Caracteres(senha)
        )
        
        let verificaSeRepeticaoDeSenhaEInvalida = (
            self.validadorDeDados.repeticaoDaSenhaDoUsuarioEstaVazia(repeticaoDeSenha) ||
            self.validadorDeDados.repeticaoDaSenhaDoUsuarioEDiferenteDaSenha(senha, repeticaoDeSenha)
        )
        
        if (
            verificaSeSenhaEInvalida ||
            verificaSeRepeticaoDeSenhaEInvalida
        ) {
            return false
        }
        
        return true
        
    }
}
