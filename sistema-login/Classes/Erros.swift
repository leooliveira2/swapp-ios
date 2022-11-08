//
//  Erros.swift
//  sistema-login
//
//  Created by Leonardo Leite on 08/11/22.
//

import Foundation

enum Erros: String {
    case erro_nick_de_usuario_vazio = "O campo usuário não pode ser vazio!"
    case erro_nick_de_usuario_tem_menos_de_5_caracteres = "O apelido de usuário não pode ter menos de 5 caracteres!"
    case erro_nick_de_usuario_nao_e_um_alfanumerico = "O apelido só pode conter letras (sem acentos ou espaços) ou números!"
    case erro_nick_de_usuario_nao_pode_ter_mais_de_32_caracteres = "O apelido de usuário pode conter no máximo 32 caracteres!"
    
    case erro_nome_completo_vazio = "O campo nome não pode ser vazio!"
    case erro_nome_completo_contem_caracteres_invalidos = "O nome só pode conter letras!"
    case erro_nome_completo_nao_pode_ter_mais_de_130_caracteres = "O nome pode conter no máximo 130 caracteres!"
    
    case erro_email_vazio = "O campo e-mail não pode ser vazio!"
    
    
    case erro_senha_vazia = "O campo senha não pode ser vazio!"
    
    
    case erro_repeticao_de_senha_vazio = "O campo repetição da senha não pode ser vazio!"
    
    
}
