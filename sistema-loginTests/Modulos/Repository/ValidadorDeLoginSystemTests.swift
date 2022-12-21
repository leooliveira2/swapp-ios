//
//  ValidadorDeLoginSystemTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 20/12/22.
//

import XCTest
@testable import sistema_login

final class ValidadorDeLoginSystemTests: XCTestCase {
    
    // MARK: - Testes
    func testCadastroFoiEncontrado() {
        let usuariosArmazenamento = UsuariosDadosStatic()
        
        self.salvarUsuario(usuariosArmazenamento)
        
        let validadorDeLogin = ValidadorDeLoginSystem(usuariosArmazenamento: usuariosArmazenamento)
        
        let cadastroFoiEncontrado = validadorDeLogin.validarLogin(email: "email@email.com", senha: "123123123")
        
        XCTAssertTrue(cadastroFoiEncontrado)
    }
    
    func testCadastroNaoFoiEncontrado() {
        let validadorDeLogin = ValidadorDeLoginSystem()
        
        let cadastroFoiEncontrado = validadorDeLogin.validarLogin(email: "email2@email.com", senha: "123123123")
        
        XCTAssertFalse(cadastroFoiEncontrado)
    }
    
    // MARK: - Funcoes
    private func salvarUsuario(_ usuariosArmazenamento: UsuariosDadosStatic) -> Void {
        let salvarUsuario = SalvarUsuarioSystem(usuariosArmazenamento: usuariosArmazenamento)
        
        let usuario = Usuario(
            nickName: "usuario",
            nomeCompleto: "nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        _ = salvarUsuario.salvar(usuario)
    }

}
