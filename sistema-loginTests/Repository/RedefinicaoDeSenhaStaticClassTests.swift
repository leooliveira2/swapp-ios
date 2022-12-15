//
//  RedefinicaoDeSenhaStaticClassTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 15/12/22.
//

import XCTest
@testable import sistema_login

final class RedefinicaoDeSenhaStaticClassTests: XCTestCase {
    
    private var usuario: Usuario!

    override func setUpWithError() throws {
        self.usuario = Usuario(
            nickName: "Usuario",
            nomeCompleto: "Usuario nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
    }
    
    func testEmailEEncontradoESenhaEAlterada() {
        UsuariosDadosStatic.salvarUsuario(self.usuario)
        
        let redefinicaoDeSenha = RedefinicaoDeSenhaStaticClass()
        
        let usuario = UsuariosDadosStatic.getUsuariosSalvos()[0]
        
        XCTAssertEqual("123123123", usuario.getSenhaDoUsuario())
        
        let senhaFoiRedefinida = redefinicaoDeSenha.redefinirSenha(email: "email@email.com", senha: "senhasenha")
        
        XCTAssertTrue(senhaFoiRedefinida)
        
        let usuarioComSenhaAtualizada = UsuariosDadosStatic.getUsuariosSalvos()[0]
        
        XCTAssertEqual("senhasenha", usuarioComSenhaAtualizada.getSenhaDoUsuario())
        
    }
    
    func testEmailNaoEEncontradoESenhaNaoEAlterada() {
        let redefinicaoDeSenha = RedefinicaoDeSenhaStaticClass()
        
        let senhaFoiRedefinida = redefinicaoDeSenha.redefinirSenha(email: "email1@email.com", senha: "senhasenha")
        
        XCTAssertFalse(senhaFoiRedefinida)
        
    }

}
