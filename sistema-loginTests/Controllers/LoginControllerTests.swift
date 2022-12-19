//
//  tresTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 19/12/22.
//

import XCTest
@testable import sistema_login

final class LoginControllerTests: XCTestCase {
    
    // MARK: - Atributos
    private var controladorDeErros: ControladorDeErros!
    private var validadorDeLogin: ValidadorDeLoginSystemMock!
    private var validadorDeDadosDoUsuario: ValidacoesDeDadosDoUsuario!
    
    private var loginController: LoginController!

    // MARK: - Pre-sets
    override func setUpWithError() throws {
        self.controladorDeErros = ControladorDeErros()
        self.validadorDeLogin = ValidadorDeLoginSystemMock()
        self.validadorDeDadosDoUsuario = ValidacoesDeDadosDoUsuario(self.controladorDeErros)
        
        self.loginController = LoginController(self.controladorDeErros, self.validadorDeLogin, self.validadorDeDadosDoUsuario)
    }
    
    // MARK: - Testes
    func testEmailESenhaEstaoNulos() {
        let loginFoiRealizado = self.loginController.fazerLogin(email: nil, senha: nil)
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(loginFoiRealizado)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[0])
        
    }
    
    func testAlgumDadoDoUsuarioEstaNulo() {
        let loginPodeSerRealizadoComEmailNulo = self.loginController.fazerLogin(email: nil, senha: "")
        
        let loginPodeSerRealizadoComSenhaNula = self.loginController.fazerLogin(email: "", senha: nil)
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(loginPodeSerRealizadoComEmailNulo)
        XCTAssertFalse(loginPodeSerRealizadoComSenhaNula)
        
        XCTAssertEqual(2, erros.count)
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[0])
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[1])
    }
    
    func testEmailESenhaEstaoVazios() {
        let loginFoiRealizado = self.loginController.fazerLogin(email: "", senha: "")
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(loginFoiRealizado)
        XCTAssertEqual(2, erros.count)
        XCTAssertEqual(.erro_email_vazio, erros[0])
        XCTAssertEqual(.erro_senha_vazia, erros[1])
    }
    
    func testSomenteEmailEstaVazio() {
        let loginFoiRealizado = self.loginController.fazerLogin(email: "", senha: "123123123")
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(loginFoiRealizado)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_email_vazio, erros[0])
    }
    
    func testSomenteSenhaEstaVazia() {
        let loginFoiRealizado = self.loginController.fazerLogin(email: "email@email.com", senha: "")
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(loginFoiRealizado)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_senha_vazia, erros[0])
    }
    
    func testEmailESenhaEstaoPreenchidosCorretamenteECadastroFoiEncontrado() {
        self.validadorDeLogin.retornoDaFuncaoValidarLogin = true
        
        let loginFoiRealizado = self.loginController.fazerLogin(email: "email@email.com", senha: "123123123")
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(loginFoiRealizado)
        XCTAssertEqual(0, erros.count)
        XCTAssertTrue(((UserDefaults.standard.value(forKey: "esta_logado") as? Bool) != nil))
        XCTAssertEqual("email@email.com", UserDefaults.standard.value(forKey: "user_id") as? String)
        
        UserDefaults.standard.removeObject(forKey: "esta_logado")
        UserDefaults.standard.removeObject(forKey: "user_id")
    }
    
    func testEmailESenhaEstaoPreenchidosCorretamenteMasCadastroNaoExiste() {
        self.validadorDeLogin.retornoDaFuncaoValidarLogin = false
        
        let loginFoiRealizado = self.loginController.fazerLogin(email: "teste@email.com", senha: "123123123")
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(loginFoiRealizado)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_cadastro_nao_encontrado, erros[0])
    }

}
