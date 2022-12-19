//
//  RedefinicaoDeSenhaStaticClassTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 15/12/22.
//

import XCTest
@testable import sistema_login

final class RedefinicaoDeSenhaSystemTests: XCTestCase {
    
    func testEmailEEncontradoESenhaEAlterada() {
        
        let usuariosArmazenamento = UsuariosDadosStatic()
        
        let usuario = Usuario(nickName: "nome", nomeCompleto: "nome", email: "nome", senha: "nome", repeticaoDeSenha: "nome")
        
        usuariosArmazenamento.salvarUsuario(usuario)
        
        let redefinicaoDeSenha = RedefinicaoDeSenhaSystem(usuariosArmazenamento: usuariosArmazenamento)
        
        XCTAssertEqual("nome", usuariosArmazenamento.getUsuariosSalvos()[0].getSenhaDoUsuario())
        
        let senhaFoiRedefinida = redefinicaoDeSenha.redefinirSenha(email: "nome", senha: "sobrenome")
        
        XCTAssertTrue(senhaFoiRedefinida)
        
        XCTAssertEqual("sobrenome", usuariosArmazenamento.getUsuariosSalvos()[0].getSenhaDoUsuario())
        
        
    }
    
    func testEmailNaoEEncontradoESenhaNaoEAlterada() {
        let usuariosArmazenamento = UsuariosDadosStatic()
        
        let redefinicaoDeSenha = RedefinicaoDeSenhaSystem(usuariosArmazenamento: usuariosArmazenamento)
        
        let senhaFoiRedefinida = redefinicaoDeSenha.redefinirSenha(email: "nome", senha: "sobrenome")
        
        XCTAssertFalse(senhaFoiRedefinida)
        
    }

}
