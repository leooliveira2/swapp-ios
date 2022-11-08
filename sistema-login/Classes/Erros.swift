//
//  Erros.swift
//  sistema-login
//
//  Created by Leonardo Leite on 08/11/22.
//

import Foundation

enum Erros: String {
    case erro_usuario_vazio = "O campo usuário não pode ser vazio!"
    case erro_nome_vazio = "O campo nome não pode ser vazio!"
    case erro_email_vazio = "O campo e-mail não pode ser vazio!"
    case erro_senha_vazia = "O campo senha não pode ser vazio!"
    case erro_repeticao_de_senha_vazio = "O campo repetição da senha não pode ser vazio!"
}
