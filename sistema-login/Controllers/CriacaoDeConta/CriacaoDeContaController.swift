//
//  CriacaoDeContaController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 10/11/22.
//

import UIKit

class CriacaoDeContaController: NSObject {
    
    private let controladorDeErros: ControladorDeErros
    
    init(_ controladorDeErros: ControladorDeErros) {
        self.controladorDeErros = controladorDeErros
    }
    
    public func criarConta(
        nickName: String?,
        nomeCompleto: String?,
        email: String?,
        senha: String?,
        repeticaoDaSenha: String?
    ) -> Bool {
        
        let validadorDeUsuario = ValidacaoDeUsuarioParaCadastro(
            controladorDeErros: self.controladorDeErros
        )
        
        let usuarioEValido = validadorDeUsuario.usuarioPodeSerCadastrado(
            nickNameDoUsuario: nickName,
            nomeCompletoDoUsuario: nomeCompleto,
            emailDoUsuario: email,
            senhaDoUsuario: senha,
            repeticaoDeSenhaDoUsuario: repeticaoDaSenha
        )
        
        if !usuarioEValido {
            return false
        }
        
        return true
    }
}
