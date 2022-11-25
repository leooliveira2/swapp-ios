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
        AF.request("https://swapi.dev/api/people/\(id)/").responseJSON { (response) in
            
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
}

