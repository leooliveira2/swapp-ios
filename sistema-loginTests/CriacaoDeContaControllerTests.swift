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
    private var salvaUsuario: SalvarUsuarioStaticClass!
    private var verificadorDeDadosCadastrados: VerificadorDeDadosCadastradosStaticClass!
    
    private var controladorCriacaoDeConta: CriacaoDeContaController!
    
    // MARK: - Pre-sets
    override func setUpWithError() throws {
        self.controladorDeErros = ControladorDeErros()
        self.validadorDeDadosDoUsuario = ValidacoesDeDadosDoUsuario(self.controladorDeErros)
        self.salvaUsuario = SalvarUsuarioStaticClass()
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
    }
    
    func testUltimoDadoDoUsuarioEstaNulo() {
        let contaPodeSerCriada = self.controladorCriacaoDeConta.criarConta(
            nickName: "Usuario",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: nil
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriada)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[0])
    }
    
    

    

}
