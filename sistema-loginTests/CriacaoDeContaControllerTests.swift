//
//  CriacaoDeContaControllerTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 13/12/22.
//

import XCTest
@testable import sistema_login

final class CriacaoDeContaControllerTests: XCTestCase {
    
    // MARK: - Atributos
    private var controladorDeErros: ControladorDeErros!
    private var validadorDeDadosDoUsuario: ValidacoesDeDadosDoUsuario!
    private var salvaUsuario: SalvarUsuarioStaticClassMock!
    private var verificadorDeDadosCadastrados: VerificadorDeDadosCadastradosStaticClass!
    
    private var controladorCriacaoDeConta: CriacaoDeContaController!
    
    // MARK: - Pre-sets
    override func setUpWithError() throws {
        self.controladorDeErros = ControladorDeErros()
        self.validadorDeDadosDoUsuario = ValidacoesDeDadosDoUsuario(self.controladorDeErros)
        self.salvaUsuario = SalvarUsuarioStaticClassMock()
        self.verificadorDeDadosCadastrados = VerificadorDeDadosCadastradosStaticClass()
        
        self.controladorCriacaoDeConta = CriacaoDeContaController(
            controladorDeErros,
            validadorDeDadosDoUsuario,
            salvaUsuario,
            verificadorDeDadosCadastrados
        )
    }

    override func tearDownWithError() throws {
       
    }
    
    // MARK: - Testes
    func testTodosOsDadosDoUsuarioEstaoNulos() {
    
        let contaPodeSerCriada = self.controladorCriacaoDeConta.criarConta(
            nickName: nil,
            nomeCompleto: nil,
            email: nil,
            senha: nil,
            repeticaoDeSenha: nil
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriada)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[0])
        
        XCTAssertEqual(0, self.salvaUsuario.quantasVezesAFuncaoSalvarFoiChamada)
    }
    
    func testPrimeiroDadoDoUsuarioEstaNulo() {
        let contaPodeSerCriada = self.controladorCriacaoDeConta.criarConta(
            nickName: nil,
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriada)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[0])
        
        XCTAssertEqual(0, self.salvaUsuario.quantasVezesAFuncaoSalvarFoiChamada)
    }
    
    func testUltimoDadoDoUsuarioEstaNulo() {
        let contaPodeSerCriada = self.controladorCriacaoDeConta.criarConta(
            nickName: "teste0",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: nil
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriada)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[0])
        
        XCTAssertEqual(0, self.salvaUsuario.quantasVezesAFuncaoSalvarFoiChamada)
    }
    
    func testUsuarioContemDadosInvalidos() {
        let contaPodeSerCriada = self.controladorCriacaoDeConta.criarConta(
            nickName: "",
            nomeCompleto: "",
            email: "email@.com",
            senha: "1234567",
            repeticaoDeSenha: "321321312"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriada)
        XCTAssertEqual(5, erros.count)
        
        XCTAssertEqual(.erro_nick_de_usuario_vazio, erros[0])
        XCTAssertEqual(.erro_nome_completo_vazio, erros[1])
        XCTAssertEqual(.erro_email_invalido, erros[2])
        XCTAssertEqual(.erro_senha_tem_menos_de_8_caracteres, erros[3])
        XCTAssertEqual(.erro_repeticao_de_senha_e_senha_sao_diferentes, erros[4])
    }
    
    func testUsuarioTemDadosValidosMasUmaFalhaOcorreAoTentarSalvar() {
        self.salvaUsuario.retornoDaFuncaoSalvar = false
        
        let contaPodeSerCriada = self.controladorCriacaoDeConta.criarConta(
            nickName: "teste1",
            nomeCompleto: "Usuario",
            email: "teste1@email.com",
            senha: "12345678",
            repeticaoDeSenha: "12345678"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriada)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_ao_salvar_usuario, erros[0])
        XCTAssertEqual(1, self.salvaUsuario.quantasVezesAFuncaoSalvarFoiChamada)
    }
    
    func testUsuarioTemDadosValidosEFoiSalvoComSucesso() {
        self.salvaUsuario.retornoDaFuncaoSalvar = true
        
        let contaPodeSerCriada = self.controladorCriacaoDeConta.criarConta(
            nickName: "teste2",
            nomeCompleto: "Usuario",
            email: "teste2@email.com",
            senha: "12345678",
            repeticaoDeSenha: "12345678"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(contaPodeSerCriada)
        XCTAssertEqual(0, erros.count)
        XCTAssertEqual(1, self.salvaUsuario.quantasVezesAFuncaoSalvarFoiChamada)
    }

}
