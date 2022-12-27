//
//  Crud.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/12/22.
//

import UIKit
import SQLite3

class Crud {

    public func exibeTodosOsUsuariosSalvos(instanciaDoBanco: OpaquePointer) -> Void {
        let queryStatementString = "SELECT * FROM usuarios"
        var queryStatement: OpaquePointer? = nil

        var usuarios: [Any] = []

        if sqlite3_prepare_v2(instanciaDoBanco, queryStatementString, -1, &queryStatement, nil) != SQLITE_OK {
            print("Erro ao ler dados do banco!")
            return
        } else {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let nickName = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let nomeCompleto = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let senha = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))

                var listaProvisoria: [Any] = []
                listaProvisoria.append(id)
                listaProvisoria.append(nickName)
                listaProvisoria.append(nomeCompleto)
                listaProvisoria.append(email)
                listaProvisoria.append(senha)

                usuarios.append(listaProvisoria)
            }
        }

        sqlite3_finalize(queryStatement)

        for usuario in usuarios {
            print(usuario)
        }
    }
    
    public func deletaUsuarioPorID(id: Int, instanciaDoBanco: OpaquePointer) -> Void {
        let deleteStatementString = "DELETE FROM usuarios WHERE id = ?;"
        var deleteStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(instanciaDoBanco, deleteStatementString, -1, &deleteStatement, nil) != SQLITE_OK {
            print("Erro ao ler dados do banco!")
            return
        }
        
        sqlite3_bind_int(deleteStatement, 1, Int32(id))
        
        if sqlite3_step(deleteStatement) != SQLITE_DONE {
            print("Não foi possivel deletar a pessoa de id \(id)")
            sqlite3_finalize(deleteStatement)
            return
        }
        
        print("Sucesso ao deletar pessoa com id \(id)")
        sqlite3_finalize(deleteStatement)
        
    }

    public func exibirTodosOsDadosDosPersonagens(db: OpaquePointer) -> Void {
        let queryStatementString = "SELECT * FROM personagens_favoritos"
        var queryStatement: OpaquePointer? = nil

        var personagens: [Any] = []

        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) != SQLITE_OK {
            print("Erro ao ler dados do banco!")
            return
        } else {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let nome = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let altura = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let peso = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let corDosOlhos = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let anoNascimento = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let genero = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let id_usuario = sqlite3_column_int(queryStatement, 7)
                
                var listaProvisoria: [Any] = []
                listaProvisoria.append(id)
                listaProvisoria.append(nome)
                listaProvisoria.append(altura)
                listaProvisoria.append(peso)
                listaProvisoria.append(corDosOlhos)
                listaProvisoria.append(anoNascimento)
                listaProvisoria.append(genero)
                listaProvisoria.append(id_usuario)

                personagens.append(listaProvisoria)
            }
        }

        sqlite3_finalize(queryStatement)

        for personagem in personagens {
            print(personagem)
        }
    }
    
    public func deletaPersonagemPorID(id: Int, instanciaDoBanco: OpaquePointer) -> Void {
        let deleteStatementString = "DELETE FROM personagens_favoritos WHERE id = ?;"
        var deleteStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(instanciaDoBanco, deleteStatementString, -1, &deleteStatement, nil) != SQLITE_OK {
            print("Erro ao ler dados do banco!")
            return
        }
        
        sqlite3_bind_int(deleteStatement, 1, Int32(id))
        
        if sqlite3_step(deleteStatement) != SQLITE_DONE {
            print("Não foi possivel deletar o personagem de id \(id)")
            sqlite3_finalize(deleteStatement)
            return
        }
        
        print("Sucesso ao deletar personagem com id \(id)")
        sqlite3_finalize(deleteStatement)
        
    }
    
    public func deleteTodosOsPersonagensPorId(id: Int, instanciaDoBanco: OpaquePointer) -> Void {
        let deleteStatementString = "DELETE FROM personagens_favoritos;"
        var deleteStatement: OpaquePointer? = nil

        if sqlite3_prepare_v2(instanciaDoBanco, deleteStatementString, -1, &deleteStatement, nil) != SQLITE_OK {
            print("Erro ao ler dados do banco!")
            return
        }
        
        
        if sqlite3_step(deleteStatement) != SQLITE_DONE {
            print("Não foi possivel deletar os personagens")
            sqlite3_finalize(deleteStatement)
            return
        }
        
        print("Sucesso ao deletar personagens")
        sqlite3_finalize(deleteStatement)
    }
    
}
