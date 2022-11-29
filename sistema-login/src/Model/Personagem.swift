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
    
    public func getListaComDadosDoPersonagem() -> [String] {
        let caracteristicasDoPersonagem: [String] = [
            "Nome: \(self.nome)",
            "Altura: \(self.altura)",
            "Peso: \(self.peso)",
            "Cor dos olhos: \(self.corDosOlhos)",
            "Ano de nascimento: \(self.anoNascimento)",
            "Gênero: \(self.genero)"
        ]
        
        return caracteristicasDoPersonagem
    }
    
}
