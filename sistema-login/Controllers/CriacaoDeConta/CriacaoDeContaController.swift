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
        
        guard let usuario = criaUsuario(
            nickName,
            nomeCompleto,
            email,
            senha,
            repeticaoDaSenha
        ) else {
            self.controladorDeErros.adicionarErro(erro: .erro_algum_dado_do_usuario_esta_nulo)
            return false
        }
        
        UsuarioSalvo.salvarUsuario(usuario)
        
        return true
    }
    
    private func criaUsuario(
        _ nickName: String?,
        _ nomeCompleto: String?,
        _ email: String?,
        _ senha: String?,
        _ repeticaoDaSenha: String?
    ) -> Usuario? {
        guard let nickName = nickName,
              let nomeCompleto = nomeCompleto,
              let email = email,
              let senha = senha,
              let repeticaoDaSenha = repeticaoDaSenha
        else {
            return nil
        }
        
        let usuario = Usuario(
            nickName: nickName,
            nomeCompleto: nomeCompleto,
            email: email,
            senha: senha,
            repeticaoDeSenha: repeticaoDaSenha
        )
        
        return usuario
    }
}
