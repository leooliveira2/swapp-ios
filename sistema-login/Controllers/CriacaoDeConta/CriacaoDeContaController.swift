//
//  CriacaoDeContaController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 10/11/22.
//

import UIKit

class CriacaoDeContaController {
    
    private let controladorDeErros: ControladorDeErros
    private let validadorDeUsuario: ValidacoesDeDadosDoUsuario
    private let salvarUsuario: SalvarUsuarioRepository
    private let verificadorDeDadosCadastrados: VerificadorDeDadosCadastradosRepository
    
    init(
        _ controladorDeErros: ControladorDeErros,
        _ validadorDeUsuario: ValidacoesDeDadosDoUsuario,
        _ salvarUsuario: SalvarUsuarioRepository,
        _ verificadorDeDadosCadastrados: VerificadorDeDadosCadastradosRepository
    ) {
        self.controladorDeErros = controladorDeErros
        self.validadorDeUsuario = validadorDeUsuario
        self.salvarUsuario = salvarUsuario
        self.verificadorDeDadosCadastrados = verificadorDeDadosCadastrados
    }
    
    public func criarConta(
        nickName: String?,
        nomeCompleto: String?,
        email: String?,
        senha: String?,
        repeticaoDeSenha: String?
    ) -> Bool {
        guard let nickName = nickName,
              let nomeCompleto = nomeCompleto,
              let email = email,
              let senha = senha,
              let repeticaoDeSenha = repeticaoDeSenha
        else {
            self.controladorDeErros.adicionarErro(erro: .erro_algum_dado_do_usuario_esta_nulo)
            return false
        }
        
        let usuarioPodeSerCadastrado = self.verificaSeUsuarioPodeSerCadastrado(
            nickName,
            nomeCompleto,
            email,
            senha,
            repeticaoDeSenha
        )
        
        if !usuarioPodeSerCadastrado {
            return false
        }
        
        let usuario = Usuario(
            nickName: nickName,
            nomeCompleto: nomeCompleto,
            email: email,
            senha: senha,
            repeticaoDeSenha: repeticaoDeSenha
        )
        
        if !self.salvarUsuario.salvar(usuario) {
            return false
        }
        
        return true
    }
    
    private func verificaSeUsuarioPodeSerCadastrado(
        _ nickName: String,
        _ nomeCompleto: String,
        _ email: String,
        _ senha: String,
        _ repeticaoDeSenha: String
    ) -> Bool {
        
        var usuarioPodeSerCadastrado = true
        
        let verificaSeNickNameEInvalido = (
            self.validadorDeUsuario.verificaSeNickNameDoUsuarioEstaVazio(nickName) ||
            self.validadorDeUsuario.verificaSeNickNameDoUsuarioTemMenosDe5Caracteres(nickName) ||
            self.validadorDeUsuario.verificaSeNickNameDoUsuarioTemMaisDe32Caracteres(nickName) ||
            self.validadorDeUsuario.verificaSeNickNameDoUsuarioNaoEUmAlfaNumerico(nickName) ||
            self.validadorDeUsuario.verificaSeNickNameDoUsuarioJaEstaCadastrado(nickName, self.verificadorDeDadosCadastrados)
        )
        
        let verificaSeNomeCompletoEInvalido = (
            self.validadorDeUsuario.verificaSeNomeCompletoDoUsuarioEstaVazio(nomeCompleto) ||
            self.validadorDeUsuario.verificaSeNomeCompletoDoUsuarioContemCaracteresInvalidos(nomeCompleto) ||
            self.validadorDeUsuario.verificaSeNomeCompletoDoUsuarioTemMaisDe130Caracteres(nomeCompleto)
        )
        
        let verificaSeEmailEInvalido = (
            self.validadorDeUsuario.verificaSeEmailDoUsuarioEstaVazio(email) ||
            self.validadorDeUsuario.verificaSeEmailDoUsuarioEValido(email) ||
            self.validadorDeUsuario.verificaSeEmailDoUsuarioTemMaisDe150Caracteres(email) ||
            self.validadorDeUsuario.verificaSeEmailDoUsuarioJaEstaCadastrado(email, self.verificadorDeDadosCadastrados)
        )
        
        let verificaSeSenhaEInvalida = (
            self.validadorDeUsuario.verificaSeSenhaDoUsuarioEstaVazia(senha) ||
            self.validadorDeUsuario.verificaSeSenhaDoUsuarioTemMenosQue8Caracteres(senha) ||
            self.validadorDeUsuario.verificaSeSenhaDoUsuarioTemMaisQue32Caracteres(senha)
        )
        
        let verificaSeRepeticaoDeSenhaEInvalida = (
            self.validadorDeUsuario.verificaSeRepeticaoDaSenhaDoUsuarioEstaVazia(repeticaoDeSenha) ||
            self.validadorDeUsuario.verificaSeRepeticaoDaSenhaDoUsuarioEDiferenteDaSenha(senha, repeticaoDeSenha)
        )
        
        if (
            verificaSeNickNameEInvalido ||
            verificaSeNomeCompletoEInvalido ||
            verificaSeEmailEInvalido ||
            verificaSeSenhaEInvalida ||
            verificaSeRepeticaoDeSenhaEInvalida
        )
        {
            usuarioPodeSerCadastrado = false
        }
        
        return usuarioPodeSerCadastrado
    }
}
