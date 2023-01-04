//
//  PerfilController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 22/12/22.
//

import UIKit

class PerfilController {
    
    public func removeOsDadosDeLoginDoUsuario() -> Void {
        UserDefaults.standard.set(false, forKey: "esta_logado")
        UserDefaults.standard.removeObject(forKey: "user_id")
    }
    
    public func selecaoDeImagemDePerfilDoUsuario(
        _ selecionadorDeImagem: EscolherImagem,
        _ image: @escaping(_ imagem: UIImage?, _ pathImagem: URL?) -> Void
    ) -> Void {
        selecionadorDeImagem.selecionarImagem() { (imagem, pathImagem) in
            image(imagem, pathImagem)
        }
    }
    
    public func salvaFotoDePerfilDoUsuario(
        pathImagem: URL,
        nickNameDoUsuario: String
    ) -> Bool {
        return true
    }
}
