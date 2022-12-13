//
//  ValidacoesDeDadosDoUsuarioTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 13/12/22.
//

import XCTest
@testable import sistema_login

final class ValidacoesDeDadosDoUsuarioTests: XCTestCase {

    private var controladorDeErros: ControladorDeErros!
    private var validadorDeDadosDoUsuario: ValidacoesDeDadosDoUsuario!
    
    override func setUpWithError() throws {
        self.controladorDeErros = ControladorDeErros()
        self.validadorDeDadosDoUsuario = ValidacoesDeDadosDoUsuario(self.controladorDeErros)
    }

    override func tearDownWithError() throws {
        
    }
    
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
    

}
