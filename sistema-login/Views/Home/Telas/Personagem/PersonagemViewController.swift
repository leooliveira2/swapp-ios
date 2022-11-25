//
//  PersonagemViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class PersonagemViewController: UIViewController {

    // MARK: - Atributos
    private lazy var personagemView: PersonagemView = {
        let view = PersonagemView()
        return view
    }()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.personagemView
        
        self.personagemView.getBotaoGerarPersonagem().addTarget(
            self,
            action: #selector(acaoBotaoGerarPersonagem(_:)),
            for: .touchUpInside
        )
    }
    
    // MARK: - Funcoes
    @objc private func acaoBotaoGerarPersonagem(_ sender: UIButton) -> Void {
        let personagemController = PersonagemController()
        
        let requisicaoDeuCerto = personagemController.gerarPersonagem()
        
        if requisicaoDeuCerto {
            print("Deu certo")
        } else {
            print("Nao deu certo")
        }
    }
}
