//
//  Usuario.swift
//  sistema-login
//
//  Created by Leonardo Leite on 08/11/22.
//

import UIKit

class Usuario: NSObject {
    
    // MARK: - Atributos
    private let nickNameDeUsuario: String
    private let nomeCompletoDoUsuario: String
    private let emailDoUsuario: String
    private let senhaDoUsuario: String
    private let repeticaoDeSenhaDoUsuario: String
    
    init(nickNameDeUsuario: String, nomeCompletoDoUsuario: String, emailDoUsuario: String, senhaDoUsuario: String, repeticaoDeSenhaDoUsuario: String) {
        self.nickNameDeUsuario = nickNameDeUsuario
        self.nomeCompletoDoUsuario = nomeCompletoDoUsuario
        self.emailDoUsuario = emailDoUsuario
        self.senhaDoUsuario = senhaDoUsuario
        self.repeticaoDeSenhaDoUsuario = repeticaoDeSenhaDoUsuario
    }
    
    public func getNickNameDeUsuario() -> String {
        return self.nickNameDeUsuario
    }
    
    public func getNomeCompletoDoUsuario() -> String {
        return self.nomeCompletoDoUsuario
    }
    
    public func getEmailDoUsuario() -> String {
        return self.emailDoUsuario
    }
    
    public func getSenhaDoUsuario() -> String {
        return self.senhaDoUsuario
    }
    
    public func getRepeteSenhaDoUsuario() -> String {
        return self.repeticaoDeSenhaDoUsuario
    }
    
}
