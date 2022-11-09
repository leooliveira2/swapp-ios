//
//  Alerta.swift
//  sistema-login
//
//  Created by Leonardo Leite on 08/11/22.
//

import UIKit

class Alerta: NSObject {
    
    private let viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    public func criaAlerta(titulo: String = "Erro", mensagem: String) -> Void {
        
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        
        let acaoContinuar = UIAlertAction(title: "Continuar", style: .cancel, handler: nil)
        
        alerta.addAction(acaoContinuar)
        
        self.viewController.present(alerta, animated: true, completion: nil)
    }
}
