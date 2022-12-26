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
    private var dadosPersonagem: [String] = []
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.personagemView
        
        self.personagemView.getBotaoGerarPersonagem().addTarget(
            self,
            action: #selector(acaoBotaoGerarPersonagem(_:)),
            for: .touchUpInside
        )
        
        self.personagemView.getAdicionarAosFavoritosButton().addTarget(
            self,
            action: #selector(acaoBotaoAdicionarAosFavoritos(_:)),
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
            self.dadosPersonagem = personagem.getListaComDadosDoPersonagem()
            self.adicionaOsDadosDoPersonagemAsLinhasDaTableView(self.dadosPersonagem)
            print(self.dadosPersonagem)
            animacao.pararAnimacao()
        } fracasso: {
            let alerta = Alerta(viewController: self)
            self.retornaViewPraEstadoInicialEmCasoDeErroAoBuscarPersonagem(alerta)
            animacao.pararAnimacao()
        }
    }
    
    @objc private func acaoBotaoAdicionarAosFavoritos(_ sender: UIButton) -> Void {
        let alerta = Alerta(viewController: self)
        
        alerta.criaAlerta(titulo: "Sucesso", mensagem: "Personagem adicionado aos favoritos")
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
