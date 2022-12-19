//
//  SalvarUsuarioStaticClassTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 15/12/22.
//

import XCTest
@testable import sistema_login

final class SalvarUsuarioSystemTests: XCTestCase {
    
    func testUsuarioESalvo() {
        let salvarUsuario = SalvarUsuarioStaticClassMock()
        
        salvarUsuario.retornoDaFuncaoSalvar = true
        
        let usuario = Usuario(nickName: "", nomeCompleto: "", email: "", senha: "", repeticaoDeSenha: "")
        
        let usuarioFoiSalvo = salvarUsuario.salvar(usuario)
        
        XCTAssertTrue(usuarioFoiSalvo)

    }

}
