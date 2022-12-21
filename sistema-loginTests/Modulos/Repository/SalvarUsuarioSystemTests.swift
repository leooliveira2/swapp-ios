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
        let salvarUsuario = SalvarUsuarioSystem()
        
        let usuario = Usuario(
            nickName: "Usuario",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let usuarioFoiSalvo = salvarUsuario.salvar(usuario)
        
        XCTAssertTrue(usuarioFoiSalvo)
        
        let verificadorDeDadosSalvos = VerificadorDeDadosCadastradosSystem()
        
        XCTAssertTrue(verificadorDeDadosSalvos.verificaSeNickNameJaEstaCadastrado("Usuario"))
    }

}
