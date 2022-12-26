//
//  VerificadorDeDadosJaCadastradosRepository.swift
//  sistema-login
//
//  Created by Leonardo Leite on 06/12/22.
//

import UIKit

protocol VerificadorDeDadosCadastradosRepository {
    
    func verificaSeNickNameJaEstaCadastrado(_ nickName: String) -> Bool
    
    func verificaSeEmailJaEstaCadastrado(_ email: String) -> Bool
}

class VerificadorDeDadosCadastradosSystem: VerificadorDeDadosCadastradosRepository {
    
    private let usuariosArmazenamento: UsuariosDadosStatic
    
    init(usuariosArmazenamento: UsuariosDadosStatic? = nil) {
        self.usuariosArmazenamento = usuariosArmazenamento ?? UsuariosDadosStatic().getInstance()
    }
    
    public func verificaSeNickNameJaEstaCadastrado(_ nickName: String) -> Bool {
        let usuariosSalvos = usuariosArmazenamento.getUsuariosSalvos()
        
        for usuario in usuariosSalvos {
            if usuario.getNickNameDeUsuario() == nickName {
                return true
            }
        }
        
        return false
    }
    
    public func verificaSeEmailJaEstaCadastrado(_ email: String) -> Bool {
        let usuariosSalvos = usuariosArmazenamento.getUsuariosSalvos()
        
        for usuario in usuariosSalvos {
            if usuario.getEmailDoUsuario() == email {
                return true
            }
        }
        
        return false
    }
    
}

import SQLite3

class VerificadorDeDadosCadastradosSQLite: VerificadorDeDadosCadastradosRepository {
    
    // MARK: - Atributos
    let instanciaDoBanco: OpaquePointer
    
    // MARK: - Inicializador
    init(instanciaDoBanco: OpaquePointer) {
        self.instanciaDoBanco = instanciaDoBanco
    }
    
    // MARK: - Funcoes
    func verificaSeNickNameJaEstaCadastrado(_ nickName: String) -> Bool {
        let selectStatementString = "SELECT nickName FROM Usuarios WHERE nickName = ?;"
        var selectStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, selectStatementString, -1, &selectStatement, nil) != SQLITE_OK {
            print("Erro ao ler dados do banco!")
            return false
        }
        
        sqlite3_bind_text(selectStatement, 1, (nickName as NSString).utf8String, -1, nil)
    
        if sqlite3_step(selectStatement) == SQLITE_ROW {
            let nickNameVindoDoBanco = String(describing: String(cString: sqlite3_column_text(selectStatement, 0)))
            
            if nickNameVindoDoBanco == nickName {
                sqlite3_finalize(selectStatement)
                return true
            }
            
        }
        
        sqlite3_finalize(selectStatement)
        return false
    }
    
    func verificaSeEmailJaEstaCadastrado(_ email: String) -> Bool {
        let selectStatementString = "SELECT email FROM Usuarios WHERE email = ?;"
        var selectStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.instanciaDoBanco, selectStatementString, -1, &selectStatement, nil) != SQLITE_OK {
            print("Erro ao ler dados do banco!")
            return false
        }
        
        sqlite3_bind_text(selectStatement, 1, (email as NSString).utf8String, -1, nil)
    
        if sqlite3_step(selectStatement) == SQLITE_ROW {
            let emailVindoDoBanco = String(describing: String(cString: sqlite3_column_text(selectStatement, 0)))
            
            if emailVindoDoBanco == email {
                sqlite3_finalize(selectStatement)
                return true
            }
            
        }
        
        sqlite3_finalize(selectStatement)
        return false
    }
    
}
