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

    override func tearDownWithError() throws {
        
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
        let nickNameDoUsuarioTemMaisDe32Caracteres = self.validadorDeDadosDoUsuario.nickNameDoUsuarioTemMaisDe32Caracteres("abcdefghijklmnopqrstuvwxyzabcdefg")
        
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
    
    func testVerificaSeNickNameDoUsuarioJaEstaSalvoStaticClass() {
        let verificadorDeDadosJaCadastrados = VerificadorDeDadosCadastradosStaticClass()
        
        let usuario = Usuario(
            nickName: "teste",
            nomeCompleto: "teste",
            email: "teste@teste.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        UsuariosDadosStatic.salvarUsuario(usuario)
        
        let nickNameDoUsuarioJaEstaSalvo = self.validadorDeDadosDoUsuario.nickNameDoUsuarioJaEstaCadastrado("teste", verificadorDeDadosJaCadastrados)
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(nickNameDoUsuarioJaEstaSalvo)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_nick_de_usuario_ja_esta_cadastrado, erros[0])
    }
    
    func testVerificaSeNickNameDoUsuarioNaoEstaSalvoStaticClass() {
        let verificadorDeDadosJaCadastrados = VerificadorDeDadosCadastradosStaticClass()
        
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
    
    func testVerificaEmailDoUsuarioJaEstaSalvoStaticClass() {
        let verificadorDeDadosJaCadastrados = VerificadorDeDadosCadastradosStaticClass()
        
        let usuario = Usuario(
            nickName: "teste",
            nomeCompleto: "teste",
            email: "teste@teste.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        UsuariosDadosStatic.salvarUsuario(usuario)
        
        let emailDoUsuarioJaEstaSalvo = self.validadorDeDadosDoUsuario.emailDoUsuarioJaEstaCadastrado("teste@teste.com", verificadorDeDadosJaCadastrados)
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(emailDoUsuarioJaEstaSalvo)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_email_ja_esta_cadastrado, erros[0])
    }
    
    func testVerificaSeEmailDoUsuarioNaoEstaSalvoStaticClass() {
        let verificadorDeDadosJaCadastrados = VerificadorDeDadosCadastradosStaticClass()
        
        let emailDoUsuarioJaEstaSalvo = self.validadorDeDadosDoUsuario.emailDoUsuarioJaEstaCadastrado("testando@email.com", verificadorDeDadosJaCadastrados)
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(emailDoUsuarioJaEstaSalvo)
        XCTAssertEqual(0, erros.count)
    }

}
