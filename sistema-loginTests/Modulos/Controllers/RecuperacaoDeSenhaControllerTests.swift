//
//  umTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 19/12/22.
//

import XCTest
@testable import sistema_login

final class RecuperacaoDeSenhaControllerTests: XCTestCase {
    
    // MARK: - Atributos
    private var controladorDeErros: ControladorDeErros!
    private var validadorDeDados: ValidacoesDeDadosDoUsuario!
    private var redefinicaoDeSenha: RedefinicaoDeSenhaSystemMock!
    
    private var recuperacaoDeSenhaController: RecuperacaoDeSenhaController!
    
    // MARK: - Set-ups
    override func setUpWithError() throws {
        self.controladorDeErros = ControladorDeErros()
        self.validadorDeDados = ValidacoesDeDadosDoUsuario(self.controladorDeErros)
        self.redefinicaoDeSenha = RedefinicaoDeSenhaSystemMock()
        
        self.recuperacaoDeSenhaController = RecuperacaoDeSenhaController(
            self.controladorDeErros,
            self.validadorDeDados,
            self.redefinicaoDeSenha
        )
    }
    
    // MARK: - Testes
    func testEmailParaBuscaDeCadastroEstaNulo() {
        let verificadorDeDadosCadastrados = VerificadorDeDadosCadastradosSystemMock()
        
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
        let verificadorDeDadosCadastrados = VerificadorDeDadosCadastradosSystemMock()
        
        verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeEmailJaEstaCadastrado = true
        
        let cadastroFoiEncontrado = self.recuperacaoDeSenhaController.buscaUsuarioParaRedefinicaoDeSenha(
            email: "",
            verificadorDeDadosCadastrados: verificadorDeDadosCadastrados
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(cadastroFoiEncontrado)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_email_vazio, erros[0])
    }
    
    func testEmailEstaPreenchidoCorretamenteECadastroFoiEncontrado() {
        let verificadorDeDadosCadastrados = VerificadorDeDadosCadastradosSystemMock()
        
        verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeEmailJaEstaCadastrado = true
        
        let cadastroFoiEncontrado = self.recuperacaoDeSenhaController.buscaUsuarioParaRedefinicaoDeSenha(
            email: "email@email.com",
            verificadorDeDadosCadastrados: verificadorDeDadosCadastrados
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(cadastroFoiEncontrado)
        XCTAssertEqual(0, erros.count)
    }
    
    func testEmailEstaPreenchidoCorretamenteMasCadastroNaoFoiEncontrado() {
        let verificadorDeDadosCadastrados = VerificadorDeDadosCadastradosSystemMock()
        
        verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeEmailJaEstaCadastrado = false
        
        let cadastroFoiEncontrado = self.recuperacaoDeSenhaController.buscaUsuarioParaRedefinicaoDeSenha(
            email: "teste@email.com",
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
    
    func testAlgumDadoDoUsuarioEstaNulo() {
        let senhaPodeSerRedefinidaComEmailEstandoNulo = self.recuperacaoDeSenhaController.alterarSenha(
            email: nil,
            senha: "",
            repeticaoSenha: ""
        )
        
        let senhaPodeSerRedefinidaComSenhaEstandoNula = self.recuperacaoDeSenhaController.alterarSenha(
            email: "",
            senha: nil,
            repeticaoSenha: ""
        )
        
        let senhaPodeSerRedefinidaComRepeticaDeSenhaEstandoNula = self.recuperacaoDeSenhaController.alterarSenha(
            email: "",
            senha: "",
            repeticaoSenha: nil
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(senhaPodeSerRedefinidaComEmailEstandoNulo)
        XCTAssertFalse(senhaPodeSerRedefinidaComSenhaEstandoNula)
        XCTAssertFalse(senhaPodeSerRedefinidaComRepeticaDeSenhaEstandoNula)
        
        XCTAssertEqual(3, erros.count)
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[0])
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[1])
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[2])
    }
    
    func testCenariosEmQueASenhaEInvalida() {
        let senhaPodeSerAlteradaComSenhaDoUsuarioVazia = self.recuperacaoDeSenhaController.alterarSenha(
            email: "",
            senha: "",
            repeticaoSenha: ""
        )
        
        let senhaPodeSerAlteradaComSenhaDoUsuarioContendoMenosDe8Caracteres = self.recuperacaoDeSenhaController.alterarSenha(
            email: "",
            senha: "1234567",
            repeticaoSenha: "1234567"
        )
        
        let senhaPodeSerAlteradaComSenhaDoUsuarioContendoMaisDe32Caracteres = self.recuperacaoDeSenhaController.alterarSenha(
            email: "",
            senha: "123456781234567812345678123456781",
            repeticaoSenha: "123456781234567812345678123456781"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(senhaPodeSerAlteradaComSenhaDoUsuarioVazia)
        XCTAssertFalse(senhaPodeSerAlteradaComSenhaDoUsuarioContendoMenosDe8Caracteres)
        XCTAssertFalse(senhaPodeSerAlteradaComSenhaDoUsuarioContendoMaisDe32Caracteres)
        
        XCTAssertEqual(4, erros.count)
        
        XCTAssertEqual(.erro_senha_vazia, erros[0])
        XCTAssertEqual(.erro_repeticao_de_senha_vazio, erros[1])
        XCTAssertEqual(.erro_senha_tem_menos_de_8_caracteres, erros[2])
        XCTAssertEqual(.erro_senha_tem_mais_de_32_caracteres, erros[3])
    }
    
    func testCenarioExtraSenhaInvalida() {
        let senhaPodeSerAlteradaComSenhaDoUsuarioVazia = self.recuperacaoDeSenhaController.alterarSenha(
            email: "",
            senha: "",
            repeticaoSenha: "123123123"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(senhaPodeSerAlteradaComSenhaDoUsuarioVazia)
        
        XCTAssertEqual(2, erros.count)
        
        XCTAssertEqual(.erro_senha_vazia, erros[0])
        XCTAssertEqual(.erro_repeticao_de_senha_e_senha_sao_diferentes, erros[1])
    }
    
    func testCenariosEmQueARepeticaoDeSenhaEInvalida() {
        let senhaPodeSerAlteradaComRepeticaoDeSenhaDoUsuarioVazia = self.recuperacaoDeSenhaController.alterarSenha(
            email: "",
            senha: "123123123",
            repeticaoSenha: ""
        )
        
        let senhaPodeSerAlteradaComRepeticaoDeSenhaDoUsuarioDiferenteDaSenha = self.recuperacaoDeSenhaController.alterarSenha(
            email: "",
            senha: "123123123",
            repeticaoSenha: "321321321"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(senhaPodeSerAlteradaComRepeticaoDeSenhaDoUsuarioVazia)
        XCTAssertFalse(senhaPodeSerAlteradaComRepeticaoDeSenhaDoUsuarioDiferenteDaSenha)
        
        XCTAssertEqual(2, erros.count)
        
        XCTAssertEqual(.erro_repeticao_de_senha_vazio, erros[0])
        XCTAssertEqual(.erro_repeticao_de_senha_e_senha_sao_diferentes, erros[1])
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
    }
    
}
