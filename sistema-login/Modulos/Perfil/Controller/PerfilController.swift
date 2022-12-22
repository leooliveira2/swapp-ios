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
}
