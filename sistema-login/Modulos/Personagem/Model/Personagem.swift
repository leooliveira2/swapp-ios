//
//  Personagem.swift
//  sistema-login
//
//  Created by Leonardo Leite on 24/11/22.
//

import UIKit

class Personagem: Codable {
    
    // MARK: - Atributos
    private var name: String = ""
    private var height: String = ""
    private var mass: String = ""
    private var eye_color: String = ""
    private var birth_year: String = ""
    private var gender: String = ""
    
    // MARK: - Funcoes
    public func getListaComDadosDoPersonagem() -> [String] {
        let caracteristicasDoPersonagem: [String] = [
            "Nome: \(self.name)",
            "Altura: \(self.height)",
            "Peso: \(self.mass)",
            "Cor dos olhos: \(self.eye_color)",
            "Ano de nascimento: \(self.birth_year)",
            "Gênero: \(self.gender)"
        ]
        
        return caracteristicasDoPersonagem
    }
    
}
