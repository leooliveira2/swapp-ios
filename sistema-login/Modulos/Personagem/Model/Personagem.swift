//
//  Personagem.swift
//  sistema-login
//
//  Created by Leonardo Leite on 24/11/22.
//

import UIKit

class Personagem: Codable {
    
    // MARK: - Atributos
    public var name: String = ""
    public var height: String = ""
    public var mass: String = ""
    public var eye_color: String = ""
    public var birth_year: String = ""
    public var gender: String = ""
    
    // MARK: - Getters
    public func getNomePersonagem() -> String {
        return self.name
    }
    
    public func getAlturaPersonagem() -> String {
        return self.height
    }
    
    public func getPesoPersonagem() -> String {
        return self.mass
    }
    
    public func getCorDosOlhosPersonagem() -> String {
        return self.eye_color
    }
    
    public func getAnoNascimentoPersonagem() -> String {
        return self.birth_year
    }
    
    public func getGeneroPersonagem() -> String {
        return self.gender
    }
    
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
