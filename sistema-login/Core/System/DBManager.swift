//
//  DBManager.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/12/22.
//

import UIKit
import SQLite3

class DBManager {
    
    public func openDatabase(DBPath: String) -> OpaquePointer? {
//        let filePath = "/Users/leonardoleite/Desktop/Projetos/login-IOS/MeuBanco/\(DBPath)"

        let filePath = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ).appendingPathExtension(DBPath)
        
        var db: OpaquePointer?
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("Não foi possível abrir o banco de dados")
            return nil
        }
        
        print("Banco de dados criado com sucesso!")
        return db
    }
    
    public func createTable(criarTabelaString: String, instanciaDoBanco: OpaquePointer) -> Bool {
        var createTableStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(instanciaDoBanco, criarTabelaString, -1, &createTableStatement, nil) != SQLITE_OK {
            print("ERRO NA PREPARACAO DO BANCO")
            return false
        }
        
        if sqlite3_step(createTableStatement) != SQLITE_DONE {
            print("Erro na criacao da tabela pessoa")
            sqlite3_finalize(createTableStatement)
            return false
        }
        
        print("Sucesso na criacao da tabela pessoa!")
        sqlite3_finalize(createTableStatement)
        return true
    }
    
}

//let DB = DBManager()
//
//guard let instanciaDoBanco = DB.openDatabase(DBPath: "UsuariosCadastrados.sqlite") else { return }
//
//let tabelaFoiCriada = DB.createTable(
//    criarTabelaString: "CREATE TABLE IF NOT EXISTS Usuarios(id INTEGER PRIMARY KEY AUTOINCREMENT, nickName TEXT UNIQUE, nomeCompleto TEXT, email UNIQUE, senha TEXT);",
//    instanciaDoBanco: instanciaDoBanco
//)
