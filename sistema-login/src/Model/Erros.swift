//
//  Erros.swift
//  sistema-login
//
//  Created by Leonardo Leite on 08/11/22.
//

import Foundation

enum Erros: String {
    case erro_nick_de_usuario_vazio = "O campo apelido do usuário não pode ser vazio!"
    case erro_nick_de_usuario_tem_menos_de_5_caracteres = "O apelido de usuário não pode ter menos de 5 caracteres!"
    case erro_nick_de_usuario_nao_pode_ter_mais_de_32_caracteres = "O apelido de usuário pode conter no máximo 32 caracteres!"
    case erro_nick_de_usuario_nao_e_um_alfanumerico = "O apelido só pode conter letras (sem acentos ou espaços) ou números!"
    case erro_nick_de_usuario_ja_esta_cadastrado = "Apelido escolhido já está em uso! Por favor, escolha outro!"
    
    case erro_nome_completo_vazio = "O campo nome não pode ser vazio!"
    case erro_nome_completo_so_pode_conter_letras_e_espacos = "O nome só pode conter letras e espaços!"
    case erro_nome_completo_nao_pode_ter_mais_de_130_caracteres = "O nome pode conter no máximo 130 caracteres!"
    
    case erro_email_vazio = "O campo e-mail não pode ser vazio!"
    case erro_email_invalido = "O e-mail informado é inválido!"
    case erro_email_tem_mais_de_150_caracteres = "O e-mail pode conter no máximo 150 caracteres!"
    case erro_email_ja_esta_cadastrado = "Este e-mail já está cadastrado! Por favor, escolha outro!"
    
    case erro_senha_vazia = "O campo senha não pode ser vazio!"
    case erro_senha_tem_menos_de_8_caracteres = "A senha precisa ter no mínimo 8 caracteres!"
    case erro_senha_tem_mais_de_32_caracteres = "A senha pode conter no máximo 32 caracteres!"
    
    case erro_repeticao_de_senha_vazio = "O campo repetição da senha não pode ser vazio!"
    case erro_repeticao_de_senha_e_senha_sao_diferentes = "A repetição da senha e a senha devem ser iguais!"
    
    case erro_cadastro_nao_encontrado = "Usuário não encontrado! Verifique seus dados e tente novamente"
    
    case erro_algum_dado_do_usuario_esta_nulo = "Tente novamente!"
    
    case erro_email_nao_encontrado = "E-mail não encontrado!"
    
    case erro_ao_salvar_usuario = "Erro ao salvar seu usuário! Por favor, tente novamente"
    
    case erro_ao_salvar_nova_senha = "Erro ao salvar nova senha! Por favor, tente novamente"
}

