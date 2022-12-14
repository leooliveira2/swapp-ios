//
//  RecuperacaoDeSenhaControllerTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 14/12/22.
//

import XCTest
@testable import sistema_login

final class RecuperacaoDeSenhaControllerTests: XCTestCase {

    // MARK: - Atributos
    private var controladorDeErros: ControladorDeErros!
    private var validadorDeDados: ValidacoesDeDadosDoUsuario!
    private var redefinicaoDeSenha: RedefinicaoDeSenhaStaticClassMock!
    
    private var recuperacaoDeSenhaController: RecuperacaoDeSenhaController!
    
    // MARK: - Set-ups
    override func setUpWithError() throws {
        self.controladorDeErros = ControladorDeErros()
        self.validadorDeDados = ValidacoesDeDadosDoUsuario(self.controladorDeErros)
        self.redefinicaoDeSenha = RedefinicaoDeSenhaStaticClassMock()
        
        self.recuperacaoDeSenhaController = RecuperacaoDeSenhaController(
            self.controladorDeErros,
            self.validadorDeDados,
            self.redefinicaoDeSenha
        )
    }
    
    // MARK:: - Testes
    func testEmailParaBuscaDeCadastroEstaNulo() {
        let verificadorDeDadosCadastrados = VerificadorDeDadosCadastradosStaticClass()
        
        let cadastroFoiEncontrado = self.recuperacaoDeSenhaController.buscaUsuarioParaRedefinicaoDeSenha(
            email: nil,
            verificadorDeDadosCadastrados: verificadorDeDadosCadastrados
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(cadastroFoiEncontrado)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[0])
    }
    
    func testEmailEstaVazio() {
        let verificadorDeDadosCadastrados = VerificadorDeDadosCadastradosStaticClass()
        
        let cadastroFoiEncontrado = self.recuperacaoDeSenhaController.buscaUsuarioParaRedefinicaoDeSenha(
            email: "",
            verificadorDeDadosCadastrados: verificadorDeDadosCadastrados
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(cadastroFoiEncontrado)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_email_vazio, erros[0])
    }
    
    func testEmailEstaPreenchidoCorretamenteECadastroFoiEncontradoStaticClass() {
        
        let usuario = Usuario(
            nickName: "teste",
            nomeCompleto: "Testando Junior",
            email: "teste0@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        UsuariosDadosStatic.salvarUsuario(usuario)
        
        let verificadorDeDadosCadastrados = VerificadorDeDadosCadastradosStaticClass()
        
        let cadastroFoiEncontrado = self.recuperacaoDeSenhaController.buscaUsuarioParaRedefinicaoDeSenha(
            email: "teste0@email.com",
            verificadorDeDadosCadastrados: verificadorDeDadosCadastrados
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(cadastroFoiEncontrado)
        XCTAssertEqual(0, erros.count)
    }
    
    func testEmailEstaPreenchidoCorretamenteMasCadastroNaoFoiEncontrado() {
        let verificadorDeDadosCadastrados = VerificadorDeDadosCadastradosStaticClass()
        
        let cadastroFoiEncontrado = self.recuperacaoDeSenhaController.buscaUsuarioParaRedefinicaoDeSenha(
            email: "teste1@email.com",
            verificadorDeDadosCadastrados: verificadorDeDadosCadastrados
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(cadastroFoiEncontrado)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_email_nao_encontrado, erros[0])
    }
    
    func testEmailSenhaERecuperaSenhaEstaoNulos() {
        let senhaPodeSerRedefinida = self.recuperacaoDeSenhaController.alterarSenha(
            email: nil,
            senha: nil,
            repeticaoSenha: nil
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(senhaPodeSerRedefinida)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[0])
    }
    
    func testEmailEstaNulo() {
        let senhaPodeSerRedefinida = self.recuperacaoDeSenhaController.alterarSenha(
            email: nil,
            senha: "",
            repeticaoSenha: ""
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(senhaPodeSerRedefinida)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[0])
    }
    
    func testRepeticaoDeSenhaEstaNula() {
        let senhaPodeSerRedefinida = self.recuperacaoDeSenhaController.alterarSenha(
            email: "",
            senha: "",
            repeticaoSenha: nil
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(senhaPodeSerRedefinida)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[0])
    }
    
    func testSenhaERepeticaoDeSenhaEstaoInvalidos() {
        let senhaPodeSerRedefinida = self.recuperacaoDeSenhaController.alterarSenha(
            email: "email@email.com",
            senha: "1234567",
            repeticaoSenha: ""
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(senhaPodeSerRedefinida)
        XCTAssertEqual(2, erros.count)
        XCTAssertEqual(.erro_senha_tem_menos_de_8_caracteres, erros[0])
        XCTAssertEqual(.erro_repeticao_de_senha_vazio, erros[1])
    }
    
    func testSenhaERepeticaoDeSenhaSaoValidosMasOcorreuUmErroAoSalvarANovaSenha() {
        self.redefinicaoDeSenha.retornoDaFuncaoRedefinirSenha = false
        
        let senhaPodeSerRedefinida = self.recuperacaoDeSenhaController.alterarSenha(
            email: "email@email.com",
            senha: "12345678",
            repeticaoSenha: "12345678"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(senhaPodeSerRedefinida)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_ao_salvar_nova_senha, erros[0])
        XCTAssertEqual(1, self.redefinicaoDeSenha.quantasVezesAFuncaoRedefinirSenhaFoIChamada)
    }
    
    func testSenhaERepeticaoDeSenhaSaoValidosENovaSenhaFoiSalvaComSucesso() {
        self.redefinicaoDeSenha.retornoDaFuncaoRedefinirSenha = true
        
        let senhaPodeSerRedefinida = self.recuperacaoDeSenhaController.alterarSenha(
            email: "email@email.com",
            senha: "12345678",
            repeticaoSenha: "12345678"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(senhaPodeSerRedefinida)
        XCTAssertEqual(0, erros.count)
        XCTAssertEqual(1, self.redefinicaoDeSenha.quantasVezesAFuncaoRedefinirSenhaFoIChamada)
    }

}
