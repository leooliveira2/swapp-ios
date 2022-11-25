//
//  Personagem.swift
//  sistema-login
//
//  Created by Leonardo Leite on 24/11/22.
//

import UIKit
import ObjectMapper

class Personagem: Mappable {
    
    // MARK: - Atributos
    private var nome: String = ""
    private var altura: String = ""
    private var peso: String = ""
    private var corDosOlhos: String = ""
    private var anoNascimento: String = ""
    private var genero: String = ""
    
    // MARK: - Inicializadores
    required init?(map: ObjectMapper.Map) {}
    
    func mapping(map: ObjectMapper.Map) {
        self.nome               <- map["name"]
        self.altura             <- map["height"]
        self.peso               <- map["mass"]
        self.corDosOlhos        <- map["eye_color"]
        self.anoNascimento      <- map["birth_year"]
        self.genero             <- map["gender"]
    }
    
    public func getNome() -> String {
        return self.nome
    }
    
    public func getAltura() -> String {
        return self.altura
    }
    
    public func getPeso() -> String {
        return self.peso
    }
    
    public func getCorDosOlhos() -> String {
        return self.corDosOlhos
    }
    
    public func getAnoNascimento() -> String {
        return self.anoNascimento
    }
    
    public func getGenero() -> String {
        return self.genero
    }
}
