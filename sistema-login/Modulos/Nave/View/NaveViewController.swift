//
//  NaveViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class NaveViewController: UIViewController {
    
    // MARK: - View
    private lazy var naveView: NaveView = {
        let view = NaveView()
        return view
    }()

    // MARK: - Atributos
    private var animacao: Animacao?
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.naveView
        
        self.naveView.getBotaoGerarNave().addTarget(
            self,
            action: #selector(acaoBotaoGerarNave(_:)),
            for: .touchUpInside
        )
        
        self.naveView.getDadosNaveTableView().delegate = self
        self.naveView.getDadosNaveTableView().dataSource = self
        
        self.animacao = Animacao(view: self.naveView)
        
    }
    
    // MARK: - Actions
    @objc private func acaoBotaoGerarNave(_ sender: UIButton) -> Void {
        guard let animacao = self.animacao else { return }
        
        self.naveView.exibeComponentesCaracteristicasDaNave()
        
        animacao.iniciarAnimacao()
        
        let requisicoesSWAPI = RequisicoesStarWarsAPI()
    
        let naveController = NaveController(requisicoesSWAPI: requisicoesSWAPI)
        
        naveController.gerarNave { nave in
            let dadosNave = nave.getListaComDadosDaNave()
            self.adicionaOsDadosDaNaveAsLinhasDaTableView(dadosNave)
            print(dadosNave)
            animacao.pararAnimacao()
        } fracasso: {
            let alerta = Alerta(viewController: self)
            self.retornaViewPraEstadoInicialEmCasoDeErroAoBuscarNave(alerta)
            animacao.pararAnimacao()
        }

    }
    
    // MARK: - Funcoes
    private func adicionaOsDadosDaNaveAsLinhasDaTableView(_ caracteristicasDaNave: [String]) -> Void {
        for indice in 0...5 {
            self.naveView.getDadosNaveTableView().cellForRow(at: IndexPath(item: indice, section: 0))?.textLabel?.text = caracteristicasDaNave[indice]
        }
    }
    
    private func retornaViewPraEstadoInicialEmCasoDeErroAoBuscarNave(_ controladorAlertas: Alerta) -> Void {
        controladorAlertas.criaAlerta(mensagem: "Erro ao gerar nave! Tenta novamente")
        
        self.naveView.retornaComponentesDaViewPraEstadoInicial()
    }

}

// MARK: - Extensoes
extension NaveViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.backgroundColor = .lightGray
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.numberOfLines = 4
                
        return cell
    }

}
