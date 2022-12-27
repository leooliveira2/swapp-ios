//
//  VerificadorDePersonagensJaAdicionadosAUmUsuarioRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 27/12/22.
//

import UIKit

protocol VerificadorDePersonagensJaAdicionadosAUmUsuarioRepository {

    func verificaSePersonagemJaEstaFavoritadoPeloUsuario(
        personagem: Personagem,
        nickNameDeUsuario: String
    ) -> Bool
    
}

import SQLite3

class VerificadorDePersonagensJaAdicionadosAUmUsuarioSQLite: VerificadorDePersonagensJaAdicionadosAUmUsuarioRepository {
    
    private let buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioRepository
    private let instanciaDoBanco: OpaquePointer
    
    init(buscadorDeDadosDoUsuario: RecuperaDadosDoUsuarioRepository, instanciaDoBanco: OpaquePointer) {
        self.buscadorDeDadosDoUsuario = buscadorDeDadosDoUsuario
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    public func verificaSePersonagemJaEstaFavoritadoPeloUsuario(
        personagem: Personagem,
        nickNameDeUsuario: String
    ) -> Bool
    {
        guard let idDoUsuario = self.buscadorDeDadosDoUsuario.getIdDoUsuario(nickName: nickNameDeUsuario) else { return false }
        
        let selectStatementString = "SELECT nome FROM personagens_favoritos WHERE id_usuario = ? AND nome = ?;"
        var selectStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, selectStatementString, -1, &selectStatement, nil) != SQLITE_OK {
            print("Erro ao fazer o prepare dos dados em VerificadorDePersonagensJaAdicionadosAUmUsuarioSQLite!")
            return false
        }
        
        sqlite3_bind_int(selectStatement, 1, Int32(idDoUsuario))
        sqlite3_bind_text(selectStatement, 2, (personagem.getNomePersonagem() as NSString).utf8String, -1, nil)
    
        if sqlite3_step(selectStatement) != SQLITE_ROW {
            sqlite3_finalize(selectStatement)
            return false
        }
        
        let nomePersonagemVindoDoBanco = String(describing: String(cString: sqlite3_column_text(selectStatement, 0)))
        
        sqlite3_finalize(selectStatement)
        
        if nomePersonagemVindoDoBanco != personagem.getNomePersonagem() {
            return false
        }
        
        return true
    }
}
