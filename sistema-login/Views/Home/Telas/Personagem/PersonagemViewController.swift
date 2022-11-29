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
    
    private var qntsVezesOBotaoFoiClicado: Int = 0
    
    private var caracteristicasDoPersonagem: [String] = []
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.personagemView
        
        self.personagemView.getBotaoGerarPersonagem().addTarget(
            self,
            action: #selector(acaoBotaoGerarPersonagem(_:)),
            for: .touchUpInside
        )
    
        self.personagemView.getDadosPersonagemTableView().delegate = self
        self.personagemView.getDadosPersonagemTableView().dataSource = self
    }
    
    // MARK: - Funcoes
    @objc private func acaoBotaoGerarPersonagem(_ sender: UIButton) -> Void {
        let personagemController = PersonagemController()
        
        personagemController.gerarPersonagem(sucesso: { (personagem) in
            self.caracteristicasDoPersonagem = personagem.getListaComDadosDoPersonagem()
            
            for indice in 0...5 {
                self.personagemView.getDadosPersonagemTableView().cellForRow(at: IndexPath(item: indice, section: 0))?.textLabel?.text = self.caracteristicasDoPersonagem[indice]
            }
            
        },
        fracasso: { (erro) in
            Alerta(viewController: self).criaAlerta(mensagem: "Erro ao gerar personagem! Tenta novamente")
            self.personagemView.retornaComponentesDaViewPraEstadoInicial()
            self.qntsVezesOBotaoFoiClicado = 0
            return
        })
        
        if self.qntsVezesOBotaoFoiClicado != 0 {
            return
        }
        
        self.personagemView.exibeComponentesCaracteristicasDoPersonagem()
        self.qntsVezesOBotaoFoiClicado += 1
        
    }
    
}

extension PersonagemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = self.personagemView.getDadosPersonagemTableView().dequeueReusableCell(
//            withIdentifier: PersonagemTableViewCell.identificador, for: indexPath
//        ) as? PersonagemTableViewCell
        
        let cell = UITableViewCell()
        cell.backgroundColor = .lightGray
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                
        return cell
    }

}
