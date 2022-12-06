//
//  RecuperacaoDeSenhaController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class RecuperacaoDeSenhaController {
    
    private let controladorDeErros: ControladorDeErros
    private let validadorDeSenha: ValidacoesDeDadosDoUsuario
    private let redefinicaoDeSenha: RedefinicaoDeSenhaRepository
    
    init(
        _ controladorDeErros: ControladorDeErros,
        _ validadorDeSenha: ValidacoesDeDadosDoUsuario,
        _ redefinicaoDeSenha: RedefinicaoDeSenhaRepository
    ) {
        self.controladorDeErros = controladorDeErros
        self.validadorDeSenha = validadorDeSenha
        self.redefinicaoDeSenha = redefinicaoDeSenha
    }
    
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
            self.validadorDeSenha.verificaSeSenhaDoUsuarioEstaVazia(senha) ||
            self.validadorDeSenha.verificaSeSenhaDoUsuarioTemMenosQue8Caracteres(senha) ||
            self.validadorDeSenha.verificaSeSenhaDoUsuarioTemMaisQue32Caracteres(senha)
        )
        
        let verificaSeRepeticaoDeSenhaEInvalida = (
            self.validadorDeSenha.verificaSeRepeticaoDaSenhaDoUsuarioEstaVazia(repeticaoDeSenha) ||
            self.validadorDeSenha.verificaSeRepeticaoDaSenhaDoUsuarioEDiferenteDaSenha(senha, repeticaoDeSenha)
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
