//
//  PersonagemViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class PersonagemViewController: UIViewController {
    
    // MARK: - View
    private lazy var personagemView: PersonagemView = {
        let view = PersonagemView()
        return view
    }()
    
    // MARK: - Atributos
    private var animacao: Animacao?
    
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
        
        self.animacao = Animacao(view: self.personagemView)
    }
    
    // MARK: - Actions
    @objc private func acaoBotaoGerarPersonagem(_ sender: UIButton) -> Void {
        guard let animacao = self.animacao else { return }
        
        self.personagemView.exibeComponentesCaracteristicasDoPersonagem()
        
        animacao.iniciarAnimacao()
        
        let requisicoesSWAPI = RequisicoesStarWarsAPI()
    
        let personagemController = PersonagemController(requisicoesSWAPI: requisicoesSWAPI)
        
        personagemController.gerarPersonagem { personagem in
            let dadosPersonagem = personagem.getListaComDadosDoPersonagem()
            self.adicionaOsDadosDoPersonagemAsLinhasDaTableView(dadosPersonagem)
            print(dadosPersonagem)
            animacao.pararAnimacao()
        } fracasso: {
            let alerta = Alerta(viewController: self)
            self.retornaViewPraEstadoInicialEmCasoDeErroAoBuscarPersonagem(alerta)
            animacao.pararAnimacao()
        }
    }
    
    // MARK: - Funcoes
    private func adicionaOsDadosDoPersonagemAsLinhasDaTableView(_ caracteristicasDoPersonagem: [String]) -> Void {
        for indice in 0...5 {
            self.personagemView.getDadosPersonagemTableView().cellForRow(at: IndexPath(item: indice, section: 0))?.textLabel?.text = caracteristicasDoPersonagem[indice]
        }
    }
    
    private func retornaViewPraEstadoInicialEmCasoDeErroAoBuscarPersonagem(_ controladorAlertas: Alerta) -> Void {
        controladorAlertas.criaAlerta(mensagem: "Erro ao gerar personagem! Tenta novamente")
        
        self.personagemView.retornaComponentesDaViewPraEstadoInicial()
    }
}

// MARK: - Extensoes
extension PersonagemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.backgroundColor = .lightGray
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                
        return cell
    }

}
