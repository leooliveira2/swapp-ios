//
//  Personagem.swift
//  sistema-login
//
//  Created by Leonardo Leite on 24/11/22.
//

import UIKit

class Personagem: NSObject {

    private let nome: String
    private let altura: Double
    private let peso: Double
    private let corDosOlhos: String
    private let dataNascimento: String
    private let genero: String
    
    init(_ nome: String, _ altura: Double, _ peso: Double, _ corDosOlhos: String,
         _ dataNascimento: String, _ genero: String
    
    ) {
        self.nome = nome
        self.altura = altura
        self.peso = peso
        self.corDosOlhos = corDosOlhos
        self.dataNascimento = dataNascimento
        self.genero = genero
    }
}
