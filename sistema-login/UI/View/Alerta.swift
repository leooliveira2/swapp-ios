//
//  Alerta.swift
//  sistema-login
//
//  Created by Leonardo Leite on 08/11/22.
//

import UIKit

class Alerta: NSObject {
    
    private let vC: UIViewController
    
    init(viewController: UIViewController) {
        self.vC = viewController
    }
    
    public func criaAlerta(titulo: String = "Erro", mensagem: String) -> Void {
        
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        
        let acaoContinuar = UIAlertAction(title: "Continuar", style: .cancel, handler: nil)
        
        alerta.addAction(acaoContinuar)
        
        self.vC.present(alerta, animated: true, completion: nil)
    }
    
    public func criaAlertaPersonalizadoExibicaoDeFavoritos(
        titulo: String,
        mensagem: String,
        handler: @escaping (UIAlertAction) -> Void
    ) -> Void
    {
        let alerta = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        
        let acaoContinuar = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        let acaoRemover = UIAlertAction(title: "Remover", style: .destructive, handler: handler)
        
        alerta.addAction(acaoContinuar)
        alerta.addAction(acaoRemover)
        
        self.vC.present(alerta, animated: true, completion: nil)
    }
}
