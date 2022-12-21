//
//  ValidacoesDeDadosDoUsuarioTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 13/12/22.
//

import XCTest
@testable import sistema_login

final class ValidacoesDeDadosDoUsuarioTests: XCTestCase {

    // MARK: - Atributos
    private var controladorDeErros: ControladorDeErros!
    private var validadorDeDadosDoUsuario: ValidacoesDeDadosDoUsuario!
    
    // MARK: - Pre-sets
    override func setUpWithError() throws {
        self.controladorDeErros = ControladorDeErros()
        self.validadorDeDadosDoUsuario = ValidacoesDeDadosDoUsuario(self.controladorDeErros)
    }
    
    // MARK: - Testes nickname
    func testVerificaSeNickNameDoUsuarioEstaPreenchidoCorretamente() {
        let nickName = "teste"
        
        let nickNameDoUsuarioEstaPreenchidoCorretamente = (
            !self.validadorDeDadosDoUsuario.nickNameDoUsuarioEstaVazio(nickName) &&
            !self.validadorDeDadosDoUsuario.nickNameDoUsuarioTemMenosDe5Caracteres(nickName) &&
            !self.validadorDeDadosDoUsuario.nickNameDoUsuarioTemMaisDe32Caracteres(nickName) &&
            !self.validadorDeDadosDoUsuario.nickNameDoUsuarioNaoEUmAlfaNumerico(nickName)
        )
            
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(nickNameDoUsuarioEstaPreenchidoCorretamente)
        XCTAssertEqual(0, erros.count)
    }
    
    func testVerificaSeNickNameEstaVazio() {
        let nickNameDoUsuarioEstaVazio = self.validadorDeDadosDoUsuario.nickNameDoUsuarioEstaVazio("")
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(nickNameDoUsuarioEstaVazio)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_nick_de_usuario_vazio, erros[0])
    }
    
    func testVerificaSeNickNameDoUsuarioTemMenosDe5Caracteres() {
        let nickNameDoUsuarioTemMenosDe5Caracteres = self.validadorDeDadosDoUsuario.nickNameDoUsuarioTemMenosDe5Caracteres("abcd")
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(nickNameDoUsuarioTemMenosDe5Caracteres)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_nick_de_usuario_tem_menos_de_5_caracteres, erros[0])
    }
    
    func testVerificaSeNickNameDoUsuarioTemMaisDe32Caracteres() {
        let nickName = "abcdefghijklmnopqrstuvwxyzabcdefg"
        
        let nickNameDoUsuarioTemMaisDe32Caracteres = self.validadorDeDadosDoUsuario.nickNameDoUsuarioTemMaisDe32Caracteres(nickName)
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(nickNameDoUsuarioTemMaisDe32Caracteres)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_nick_de_usuario_nao_pode_ter_mais_de_32_caracteres, erros[0])
    }

    func testVerificaSeNickNameDoUsuarioNaoEUmAlfaNumerico() {
        let nickNameDoUsuarioNaoEUmAlfaNumerico = self.validadorDeDadosDoUsuario.nickNameDoUsuarioNaoEUmAlfaNumerico("@_#$%* '")
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(nickNameDoUsuarioNaoEUmAlfaNumerico)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_nick_de_usuario_nao_e_um_alfanumerico, erros[0])
    }
    
    func testVerificaSeNickNameDoUsuarioJaEstaSalvoSystem() {
        let verificadorDeDadosJaCadastrados = VerificadorDeDadosCadastradosSystemMock()
        
        verificadorDeDadosJaCadastrados.retornoDaFuncaoVerificaSeNickNameJaEstaCadastrado = true
        
        let nickNameDoUsuarioJaEstaSalvo = self.validadorDeDadosDoUsuario.nickNameDoUsuarioJaEstaCadastrado("Teste validacoes de dados", verificadorDeDadosJaCadastrados)
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(nickNameDoUsuarioJaEstaSalvo)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_nick_de_usuario_ja_esta_cadastrado, erros[0])
    }
    
    func testVerificaSeNickNameDoUsuarioNaoEstaSalvoSystem() {
        let verificadorDeDadosJaCadastrados = VerificadorDeDadosCadastradosSystem()
        
        let nickNameDoUsuarioJaEstaSalvo = self.validadorDeDadosDoUsuario.nickNameDoUsuarioJaEstaCadastrado("testando", verificadorDeDadosJaCadastrados)
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(nickNameDoUsuarioJaEstaSalvo)
        XCTAssertEqual(0, erros.count)
    }
    
    // MARK: - Testes nome completo
    func testVerificaSeNomeCompletoDoUsuarioEstaPreenchidoCorretamente() {
        let nomeCompleto = "João Silva"
        
        let nomeCompletoEstaPreenchidoCorretamente = (
            !self.validadorDeDadosDoUsuario.nomeCompletoDoUsuarioEstaVazio(nomeCompleto) &&
            !self.validadorDeDadosDoUsuario.nomeCompletoDoUsuarioContemCaracteresInvalidos(nomeCompleto) &&
            !self.validadorDeDadosDoUsuario.nomeCompletoDoUsuarioTemMaisDe130Caracteres(nomeCompleto)
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(nomeCompletoEstaPreenchidoCorretamente)
        XCTAssertEqual(0, erros.count)
    }
    
    func testVerificaSeNomeCompletoDoUsuarioEstaVazio() {
        let nomeCompletoDoUsuarioEstaVazio = self.validadorDeDadosDoUsuario.nomeCompletoDoUsuarioEstaVazio("")
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(nomeCompletoDoUsuarioEstaVazio)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_nome_completo_vazio, erros[0])
    }
    
    func testVerificaSeNomeCompletoDoUsuarioContemCaracteresInvalidos() {
        let nomeCompletoDoUsuarioContemCaracteresInvalidos = self.validadorDeDadosDoUsuario.nomeCompletoDoUsuarioContemCaracteresInvalidos("@#._123131asas ")
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(nomeCompletoDoUsuarioContemCaracteresInvalidos)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_nome_completo_so_pode_conter_letras_e_espacos, erros[0])
    }
    
    func testVerificaSeNomeCompletoDoUsuarioTemMaisDe130Caracteres() {
        let nome = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqr" + "stuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyza"
        
        let nomeCompletoTemMaisDe130Caracteres = self.validadorDeDadosDoUsuario.nomeCompletoDoUsuarioTemMaisDe130Caracteres(nome)
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(nomeCompletoTemMaisDe130Caracteres)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_nome_completo_nao_pode_ter_mais_de_130_caracteres, erros[0])
    }
    
    // MARK: - Testes email
    func testVerificaSeEmailEstaPreenchidoCorretamente() {
        let email = "email@email.com"
        
        let emailEstaPreenchidoCorretamente = (
            !self.validadorDeDadosDoUsuario.emailDoUsuarioEstaVazio(email) &&
            !self.validadorDeDadosDoUsuario.emailDoUsuarioEInvalido(email) &&
            !self.validadorDeDadosDoUsuario.emailDoUsuarioTemMaisDe150Caracteres(email)
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(emailEstaPreenchidoCorretamente)
        XCTAssertEqual(0, erros.count)
        
    }
    
    func testVerificaSeEmailDoUsuarioEstaVazio() {
        let emailEstaVazio = self.validadorDeDadosDoUsuario.emailDoUsuarioEstaVazio("")
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(emailEstaVazio)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_email_vazio, erros[0])
    }
    
    func testVerificaSeFormatoDoEmailDoUsuarioEInvalido() {
        let emailEInvalido = self.validadorDeDadosDoUsuario.emailDoUsuarioEInvalido("xdemail")
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(emailEInvalido)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_email_invalido, erros[0])
    }
    
    func testVerificaSeEmailDoUsuarioTemMaisDe150Caracteres() {
        let email = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopq" +
        "rstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstu"
        
        let emailTemMaisDe150Caracteres = self.validadorDeDadosDoUsuario.emailDoUsuarioTemMaisDe150Caracteres(email)
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(emailTemMaisDe150Caracteres)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_email_tem_mais_de_150_caracteres, erros[0])
    }
    
    func testVerificaEmailDoUsuarioJaEstaSalvoSystem() {
        let verificadorDeDadosJaCadastrados = VerificadorDeDadosCadastradosSystemMock()
        
        verificadorDeDadosJaCadastrados.retornoDaFuncaoVerificaSeEmailJaEstaCadastrado = true
        
        let emailDoUsuarioJaEstaSalvo = self.validadorDeDadosDoUsuario.emailDoUsuarioJaEstaCadastrado("testevalidacoes@email.com", verificadorDeDadosJaCadastrados)
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(emailDoUsuarioJaEstaSalvo)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_email_ja_esta_cadastrado, erros[0])
    }
    
    func testVerificaSeEmailDoUsuarioNaoEstaSalvoSystem() {
        let verificadorDeDadosJaCadastrados = VerificadorDeDadosCadastradosSystem()
        
        let emailDoUsuarioJaEstaSalvo = self.validadorDeDadosDoUsuario.emailDoUsuarioJaEstaCadastrado("testando@email.com", verificadorDeDadosJaCadastrados)
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(emailDoUsuarioJaEstaSalvo)
        XCTAssertEqual(0, erros.count)
    }
    
    // MARK: - Testes da senha
    func testVerificaSeSenhaEstaPreenchidaCorretamente() {
        let senha = "123123123"
        
        let senhaPreenchidaEValida = (
            !self.validadorDeDadosDoUsuario.senhaDoUsuarioEstaVazia(senha) &&
            !self.validadorDeDadosDoUsuario.senhaDoUsuarioTemMenosQue8Caracteres(senha) &&
            !self.validadorDeDadosDoUsuario.senhaDoUsuarioTemMaisQue32Caracteres(senha)
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(senhaPreenchidaEValida)
        XCTAssertEqual(0, erros.count)
    }
    
    func testVerificaSeSenhaDoUsuarioEstaVazia() {
        let senhaEstaVazia = self.validadorDeDadosDoUsuario.senhaDoUsuarioEstaVazia("")
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(senhaEstaVazia)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_senha_vazia, erros[0])
    }
    
    func testVerificaSeSenhaDoUsuarioTemMenosQue8Caracteres() {
        let senhaTemMenosQue8Caracteres = self.validadorDeDadosDoUsuario.senhaDoUsuarioTemMenosQue8Caracteres("1234567")
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(senhaTemMenosQue8Caracteres)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_senha_tem_menos_de_8_caracteres, erros[0])
    }
    
    func testVerificaSeSenhaDoUsuarioTemMaisQue32Caracteres() {
        let senha = "abcdefghijklmnopqrstuvwxyzabcdefg"
        
        let senhaTemMaisQue32Caracteres = self.validadorDeDadosDoUsuario.senhaDoUsuarioTemMaisQue32Caracteres(senha)
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(senhaTemMaisQue32Caracteres)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_senha_tem_mais_de_32_caracteres, erros[0])
    }
    
    // MARK: - Testes da repeticao de senha
    func testVerificaSeRepeticaoDeSenhaDoUsuarioEstaCorreta() {
        let senha = "123123123"
        let repeticao = "123123123"
        
        let repeticaoDeSenhaEstaCorreta = (
            !self.validadorDeDadosDoUsuario.repeticaoDaSenhaDoUsuarioEstaVazia(repeticao) &&
            !self.validadorDeDadosDoUsuario.repeticaoDaSenhaDoUsuarioEDiferenteDaSenha(senha, repeticao)
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(repeticaoDeSenhaEstaCorreta)
        XCTAssertEqual(0, erros.count)
    }
    
    func testVerificaSeRepeticaoDeSenhaDoUsuarioEstaVazia() {
        let repeticaoDeSenhaEstaVazia = self.validadorDeDadosDoUsuario.repeticaoDaSenhaDoUsuarioEstaVazia("")
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(repeticaoDeSenhaEstaVazia)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_repeticao_de_senha_vazio, erros[0])
    }
    
    func testVerificaSeRepeticaoDeSenhaDoUsuarioEDiferenteDaSenha() {
        let repeticaoDaSenhaEDiferenteDaSenha = self.validadorDeDadosDoUsuario.repeticaoDaSenhaDoUsuarioEDiferenteDaSenha("123123123", "321321321")
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(repeticaoDaSenhaEDiferenteDaSenha)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_repeticao_de_senha_e_senha_sao_diferentes, erros[0])
    }
    
    func testLoginNaoPodeSerRealizadoPoisCadastroNaoExisteStaticClass() {
        let validadorDeLogin = ValidadorDeLoginSystem()
        
        let loginPodeSerRealizado = self.validadorDeDadosDoUsuario.verificaSeLoginPodeSerRealizado("email@email.com", "senhasenha", validadorDeLogin)
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(loginPodeSerRealizado)
        XCTAssertEqual(.erro_cadastro_nao_encontrado, erros[0])
    }
    
    func testLoginPodeSerRealizadoStaticClass() {
        let validadorDeLogin = ValidadorDeLoginSystemMock()
        
        validadorDeLogin.retornoDaFuncaoValidarLogin = true
        
        let loginPodeSerRealizado = self.validadorDeDadosDoUsuario.verificaSeLoginPodeSerRealizado(
            "testelogin@email.com",
            "123123123",
            validadorDeLogin
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(loginPodeSerRealizado)
        XCTAssertEqual(0, erros.count)
    }
    
}
