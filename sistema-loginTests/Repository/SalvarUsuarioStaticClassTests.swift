//
//  SalvarUsuarioStaticClassTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 15/12/22.
//

import XCTest
@testable import sistema_login

final class SalvarUsuarioStaticClassTests: XCTestCase {

    override func setUpWithError() throws {
        
    }
    
    func testUsuarioESalvo() {
        let salvarUsuario = SalvarUsuarioStaticClass()
        
        let usuario = Usuario(
            nickName: "Usuario",
            nomeCompleto: "Nome",
            email: "testandoSalvar@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let usuarioFoiSalvo = salvarUsuario.salvar(usuario)
        
        XCTAssertTrue(usuarioFoiSalvo)
        
        for usuarioSalvo in UsuariosDadosStatic.getUsuariosSalvos() {
            if usuarioSalvo === usuario {
                XCTAssertEqual("testandoSalvar@email.com", usuarioSalvo.getEmailDoUsuario())
            }
        }
    }


}
