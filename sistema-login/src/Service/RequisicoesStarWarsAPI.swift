//
//  RequisicoesStarWarsAPI.swift
//  sistema-login
//
//  Created by Leonardo Leite on 24/11/22.
//

import UIKit
import Alamofire

class RequisicoesStarWarsAPI {
    
    let animacao: Animacao
    
    init(animacao: Animacao) {
        self.animacao = animacao
    }
    
    
    func fazRequisicaoPersonagem(
        id: Int,
        resultado: @escaping(_ personagem: Personagem?) -> Void)
    {
        let requisicao = AF.request("https://swapi.dev/api/people/\(id)/")

        requisicao.responseDecodable(of: Personagem.self) { response in

            if response.response?.statusCode == 404 {
                print("1")
                self.animacao.pararAnimacao()
                resultado(nil)
                return
            }

            guard let data = response.data else {
                print("2")
                self.animacao.pararAnimacao()
                resultado(nil)
                return
            }

            let decoder = JSONDecoder()
            do {
                let personagem = try decoder.decode(Personagem.self, from: data)
                resultado(personagem)
                self.animacao.pararAnimacao()
                return
            } catch {
                self.animacao.pararAnimacao()
                return
            }
        }
    }
    
    func fazRequisicaoPlaneta(
        id: Int,
        resultado: @escaping(_ planeta: Planeta?) -> Void)
    {
        let requisicao = AF.request("https://swapi.dev/api/planets/\(id)/")

        requisicao.responseDecodable(of: Planeta.self) { response in

            if response.response?.statusCode == 404 {
                print("1")
                self.animacao.pararAnimacao()
                resultado(nil)
                return
            }

            guard let data = response.data else {
                print("2")
                self.animacao.pararAnimacao()
                resultado(nil)
                return
            }

            let decoder = JSONDecoder()
            do {
                let planeta = try decoder.decode(Planeta.self, from: data)
                resultado(planeta)
                self.animacao.pararAnimacao()
                return
            } catch {
                self.animacao.pararAnimacao()
                return
            }
        }
    }
    
    func fazRequisicaoNave(
        id: Int,
        resultado: @escaping(_ nave: Nave?) -> Void)
    {
        let requisicao = AF.request("https://swapi.dev/api/starships/\(id)/")

        requisicao.responseDecodable(of: Nave.self) { response in

            if response.response?.statusCode == 404 {
                print("1")
                self.animacao.pararAnimacao()
                resultado(nil)
                return
            }

            guard let data = response.data else {
                print("2")
                self.animacao.pararAnimacao()
                resultado(nil)
                return
            }

            let decoder = JSONDecoder()
            do {
                let nave = try decoder.decode(Nave.self, from: data)
                resultado(nave)
                self.animacao.pararAnimacao()
                return
            } catch {
                self.animacao.pararAnimacao()
                return
            }
        }
    }
}
