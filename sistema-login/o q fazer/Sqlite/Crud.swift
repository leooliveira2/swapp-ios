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
        let queryStatementString = "SELECT * FROM Usuarios"
        var queryStatement: OpaquePointer? = nil

        var usuarios: [Any] = []

        if sqlite3_prepare_v2(instanciaDoBanco, queryStatementString, -1, &queryStatement, nil) != SQLITE_OK {
            print("Erro ao ler dados do banco!")
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
}
