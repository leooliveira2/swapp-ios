//
//  PlanetaViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class PlanetaViewController: UIViewController {
    
    // MARK: - View
    private lazy var planetaView: PlanetaView = {
        let view = PlanetaView()
        return view
    }()
    
    // MARK: - Atributos
    private var animacao: Animacao?
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.planetaView
        
        self.planetaView.getBotaoGerarPlaneta().addTarget(
            self,
            action: #selector(acaoBotaoGerarPlaneta(_:)),
            for: .touchUpInside
        )
        
        self.planetaView.getDadosPlanetaTableView().delegate = self
        self.planetaView.getDadosPlanetaTableView().dataSource = self
        
        self.animacao = Animacao(view: self.planetaView)
    }
    
    // MARK: - Actions
    @objc private func acaoBotaoGerarPlaneta(_ sender: UIButton) -> Void {
        guard let animacao = self.animacao else { return }
        
        self.planetaView.exibeComponentesCaracteristicasDoPlaneta()
        
        animacao.iniciarAnimacao()
        
        let requisicoesSWAPI = RequisicoesStarWarsAPI(animacao: animacao)
    
        let planetaController = PlanetaController(requisicoesSWAPI: requisicoesSWAPI)
        
        planetaController.gerarPlaneta { planeta in
            let dadosPlaneta = planeta.getListaComDadosDoPlaneta()
            self.adicionaOsDadosDoPlanetaAsLinhasDaTableView(dadosPlaneta)
            print(dadosPlaneta)
        } fracasso: {
            let alerta = Alerta(viewController: self)
            self.retornaViewPraEstadoInicialEmCasoDeErroAoBuscarPlaneta(alerta)
            print("Hello men hehe")
        }
    }
    
    // MARK: - Funcoes
    private func adicionaOsDadosDoPlanetaAsLinhasDaTableView(_ caracteristicasDoPlaneta: [String]) -> Void {
        for indice in 0...5 {
            self.planetaView.getDadosPlanetaTableView().cellForRow(at: IndexPath(item: indice, section: 0))?.textLabel?.text = caracteristicasDoPlaneta[indice]
        }
    }
    
    private func retornaViewPraEstadoInicialEmCasoDeErroAoBuscarPlaneta(_ controladorAlertas: Alerta) -> Void {
        controladorAlertas.criaAlerta(mensagem: "Erro ao gerar planeta! Tenta novamente")
        
        self.planetaView.retornaComponentesDaViewPraEstadoInicial()
    }
}

// MARK: - Extensoes
extension PlanetaViewController: UITableViewDelegate, UITableViewDataSource {
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

