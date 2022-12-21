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

        requisicao.responseDecodable(of: Personagem.self) { (response) in

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
                print("Não foi possível decodificar o JSON")
                self.animacao.pararAnimacao()
                return
            }
        }
    }
    
    func fazRequisicaoPlaneta(
        id: Int,
        sucesso: @escaping(_ planeta: Planeta) -> Void,
        falha: @escaping(_ erro: Bool) -> Void)
    {
        let requisicao = AF.request("https://swapi.dev/api/planets/\(id)/")
        
        requisicao.responseDecodable(of: Planeta.self) { (response) in
            
            if response.response?.statusCode == 404 {
                falha(false)
            }
            
            switch response.result {
            case .success:
                guard let data = response.data else {
                    falha(false)
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let planeta = try decoder.decode(Planeta.self, from: data)
                    sucesso(planeta)
                } catch {
                    print("Não foi possível decodificar o JSON")
                }
                
                break
                
            case .failure:
                falha(false)
                break
            }
        }
    }
    
    func fazRequisicaoNave(
        id: Int,
        sucesso: @escaping(_ nave: Nave) -> Void,
        falha: @escaping(_ erro: Bool) -> Void)
    {
        let requisicao = AF.request("https://swapi.dev/api/starships/\(id)/")
        
        requisicao.responseDecodable(of: Nave.self) { (response) in
            
            if response.response?.statusCode == 404 {
                falha(false)
                return
            }
            
            switch response.result {
            case .success:
                guard let data = response.data else {
                    falha(false)
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let nave = try decoder.decode(Nave.self, from: data)
                    sucesso(nave)
                } catch {
                    print("Não foi possível decodificar o JSON")
                }
                
                break
                
            case .failure:
                falha(false)
                break
            }
        }
    }
}
