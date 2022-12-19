//
//  RedefinicaoDeSenhaStaticClassTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 15/12/22.
//

import XCTest
@testable import sistema_login

final class RedefinicaoDeSenhaSystemTests: XCTestCase {
    
    // MARK: - Testes
    func testEmailEEncontradoESenhaEAlterada() {
        let usuariosArmazenamento = UsuariosDadosStatic()
        
        self.salvarUsuario(usuariosArmazenamento)
        
        let redefinicaoDeSenha = RedefinicaoDeSenhaSystem(usuariosArmazenamento: usuariosArmazenamento)
        
        XCTAssertEqual("senha", usuariosArmazenamento.getUsuariosSalvos()[0].getSenhaDoUsuario())
        
        let senhaFoiRedefinida = redefinicaoDeSenha.redefinirSenha(email: "Email", senha: "novasenha")
        
        XCTAssertTrue(senhaFoiRedefinida)
        
        XCTAssertEqual("novasenha", usuariosArmazenamento.getUsuariosSalvos()[0].getSenhaDoUsuario())
        
    }
    
    func testEmailNaoEEncontradoESenhaNaoEAlterada() {
        let redefinicaoDeSenha = RedefinicaoDeSenhaSystem()
        
        let senhaFoiRedefinida = redefinicaoDeSenha.redefinirSenha(email: "Email", senha: "senha")
        
        XCTAssertFalse(senhaFoiRedefinida)
        
    }
    
    // MARK: - Funcoes
    private func salvarUsuario(_ usuariosArmazenamento: UsuariosDadosStatic) -> Void {
        let usuario = Usuario(
            nickName: "Apelido",
            nomeCompleto: "Nome completo",
            email: "Email",
            senha: "senha",
            repeticaoDeSenha: "repeticao de senha"
        )
        
        usuariosArmazenamento.salvarUsuario(usuario)
    }

}
