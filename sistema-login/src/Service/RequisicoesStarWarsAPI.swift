//
//  RequisicoesStarWarsAPI.swift
//  sistema-login
//
//  Created by Leonardo Leite on 24/11/22.
//

import UIKit
import Alamofire
import ObjectMapper

class RequisicoesStarWarsAPI: NSObject {
    
    func fazRequisicaoPersonagem(
        id: Int,
        sucesso: @escaping(_ personagem: Personagem) -> Void,
        falha: @escaping(_ erro: Bool) -> Void)
    {
        AF.request("https://swapi.py4e.com/api/people/\(id)/").responseJSON { (response) in
            
            if response.response?.statusCode == 404 {
                falha(false)
            }
            
            switch response.result {
            case .success:
                guard let data = response.value else {
                    falha(false)
                    return
                }
                
                guard let personagem = Mapper<Personagem>().map(JSONObject: data) else {
                    falha(false)
                    return
                }
                sucesso(personagem)
                break
                
            case .failure:
                falha(false)
                break
            }
        }
    }
    
    func fazRequisicaoPlaneta(
        id: Int,
        sucesso: @escaping(_ planeta: Planeta) -> Void,
        falha: @escaping(_ erro: Bool) -> Void)
    {
        let requisicao = AF.request("https://swapi.py4e.com/api/planets/\(id)/")
        
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
}
