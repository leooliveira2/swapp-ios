//
//  RecuperacaoDeSenhaController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class RecuperacaoDeSenhaController: NSObject {
    
    private let controladorDeErros: ControladorDeErros
    private let validadorDeSenha: ValidacaoDeUsuarioParaCadastro
    private let redefinicaoDeSenha: RedefinicaoDeSenha
    
    init(
        _ controladorDeErros: ControladorDeErros,
        _ validadorDeSenha: ValidacaoDeUsuarioParaCadastro,
        _ redefinicaoDeSenha: RedefinicaoDeSenha
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
        
        let senhaPodeSerAlterada = self.validadorDeSenha.validacoesDaSenhaDoUsuario(senha)
            && self.validadorDeSenha.validacoesDaRepeticaoDeSenhaDoUsuario(senha, repeticaoSenha)
        
        if !senhaPodeSerAlterada {
            return false
        }
        
        self.redefinicaoDeSenha.redefinirSenha(email: email, senha: senha)
        
        return true
    }
}
