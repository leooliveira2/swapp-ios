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
        
        personagemController.gerarPersonagem(sucesso: { (personagem) in
            print(personagem.getNome())
        },
        fracasso: { (erro) in
            print(erro)
        })
    }
}
