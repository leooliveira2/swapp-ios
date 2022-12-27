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
        
//        print(filePath.relativePath)
        
        var db: OpaquePointer?
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("Não foi possível abrir o banco de dados")
            return nil
        }
        
        print("Banco de dados foi acessado com sucesso!")
        
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, "PRAGMA foreign_keys = ON;", -1, &statement, nil) != SQLITE_OK {
            print("erro ao preparar chave estrangeira para uso!")
        }
        
        sqlite3_finalize(statement)
        
        return db
    }
    
    public func createTable(criarTabelaString: String, instanciaDoBanco: OpaquePointer) -> Bool {
        var createTableStatement: OpaquePointer?
        
        if sqlite3_prepare_v2(instanciaDoBanco, criarTabelaString, -1, &createTableStatement, nil) != SQLITE_OK {
            print("ERRO NA PREPARACAO DO BANCO")
            return false
        }
        
        if sqlite3_step(createTableStatement) != SQLITE_DONE {
            print("Erro na criacao da tabela")
            sqlite3_finalize(createTableStatement)
            return false
        }
        
        print("Sucesso na criacao da tabela!")
        sqlite3_finalize(createTableStatement)
        return true
    }
    
}

// MARK: - Comandos que usei pra fazer o banco e as tabelas
//guard let novoDb = DBManager().openDatabase(DBPath: "teste9.sqlite") else { return }
//
//DBManager().createTable(criarTabelaString: "CREATE TABLE IF NOT EXISTS usuarios (id INTEGER PRIMARY KEY AUTOINCREMENT, nickName TEXT UNIQUE NOT NULL, nomeCompleto TEXT NOT NULL, email TEXT UNIQUE NOT NULL, senha TEXT NOT NULL);"
//                        , instanciaDoBanco: novoDb)
//
//DBManager().createTable(criarTabelaString: "CREATE TABLE IF NOT EXISTS personagens_favoritos (id INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, altura TEXT NOT NULL, peso TEXT NOT NULL, corDosOlhos TEXT NOT NULL, anoNascimento TEXT NOT NULL, genero TEXT NOT NULL, id_usuario INTEGER NOT NULL, CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON DELETE CASCADE);", instanciaDoBanco: novoDb)
//
//let salvaUsuario = SalvarUsuarioSQLite(instanciaDoBanco: novoDb)
//salvaUsuario.salvar(Usuario(nickName: "Leonardo", nomeCompleto: "Leonardo", email: "Email@email.com", senha: "senha", repeticaoDeSenha: "senha"))
//
//let salvaPersonagemComoFavorito = SalvarPersonagemFavoritoSQLite(instanciaDoBanco: novoDb)
//
//let personagem = Personagem()
//personagem.name = "Luke Skywalker"
//personagem.height = "171"
//personagem.mass = "77"
//personagem.eye_color = "blue"
//personagem.birth_year = "19BBY"
//personagem.gender = "male"
//
//salvaPersonagemComoFavorito.salvarComoFavorito(personagem, idUsuario: 1)
