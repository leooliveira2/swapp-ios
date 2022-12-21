//
//  PlanetaViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class PlanetaViewController: UIViewController, ExibeTableViewDelegate {
    
    public func exibeTableView(caracteristicas: [String]) {
        self.tableViewPodeSerExibida = true
    }
    
    @Published private var tableViewPodeSerExibida: Bool = false
    
    // MARK: - Atributos
    private lazy var planetaView: PlanetaView = {
        let view = PlanetaView()
        return view
    }()
    
    private var qntsVezesOBotaoFoiClicado: Int = 0
    
    // MARK: - Componentes da animacao
    private lazy var fundoDoLoading: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var barraDeLoading: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        return view
    }()
    
    private lazy var gerandoPlanetaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Gerando Planeta...."
        label.textColor = .blue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var leadingAnchorBarraDeLoading: NSLayoutConstraint = {
        let leadingAnchor = self.barraDeLoading.leadingAnchor.constraint(equalTo: self.fundoDoLoading.leadingAnchor, constant: 20)
        return leadingAnchor
    }()
    
    
    
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
        
        self.fundoDoLoading.addSubview(self.barraDeLoading)
        self.fundoDoLoading.addSubview(self.gerandoPlanetaLabel)
        self.view.addSubview(self.fundoDoLoading)
        self.configConstraints()
        
        self.fundoDoLoading.isHidden = true
    }
    
    // MARK: - Actions
    @objc private func acaoBotaoGerarPlaneta(_ sender: UIButton) -> Void {
//        let animacao = Animacao(myView: self.view)
//        
//        let planetaController = PlanetaController(animacao: animacao, vC: self)
//        
//        planetaController.gerarPlaneta(sucesso: { (planeta) in
//            let caracteristicasDoPlaneta: [String] = planeta.getListaComDadosDoPlaneta()
//            self.adicionaOsDadosDoPlanetaAsLinhasDaTableView(caracteristicasDoPlaneta)
//        },
//        fracasso: { (erro) in
//            let controladorDeAlertas = Alerta(viewController: self)
//            self.retornaViewPraEstadoInicialEmCasoDeErroAoBuscarPlaneta(controladorDeAlertas)
//            return
//        })
//        
//        if self.qntsVezesOBotaoFoiClicado != 0 {
//            return
//        }
//        
//        self.fundoDoLoading.isHidden = false
//        self.animacaoQuandoOBotaoGerarPlanetaEClicado()
//       
//        let seconds = 1.0
//        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
//            self.atualizaViewParaExibirTabela()
//        }
                
    }
    
    // MARK: - Funcoes
    private func adicionaOsDadosDoPlanetaAsLinhasDaTableView(_ caracteristicasDoPlaneta: [String]) -> Void {
        for indice in 0...5 {
            self.planetaView.getDadosPlanetaTableView().cellForRow(at: IndexPath(item: indice, section: 0))?.textLabel?.text = caracteristicasDoPlaneta[indice]
        }
    }
    
    private func atualizaViewParaExibirTabela() -> Void {
        self.planetaView.exibeComponentesCaracteristicasDoPlaneta()
        self.qntsVezesOBotaoFoiClicado += 1
    }
    
    private func retornaViewPraEstadoInicialEmCasoDeErroAoBuscarPlaneta(_ controladorAlertas: Alerta) -> Void {
        controladorAlertas.criaAlerta(mensagem: "Erro ao gerar planeta! Tenta novamente")
        
        self.planetaView.retornaComponentesDaViewPraEstadoInicial()
        self.qntsVezesOBotaoFoiClicado = 0
    }
    
    // MARK: - Animacoes
    private func animacaoQuandoOBotaoGerarPlanetaEClicado() -> Void {
        let posicaoInicialBarraDeLoading = self.leadingAnchorBarraDeLoading.constant
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.autoreverse], animations: {
            self.leadingAnchorBarraDeLoading.constant = self.fundoDoLoading.frame.midX
            self.view.layoutIfNeeded()
        }) { (_ ) in
            self.leadingAnchorBarraDeLoading.constant = posicaoInicialBarraDeLoading
            self.fundoDoLoading.isHidden = true
        }
    }
    
    // MARK: - Config constraints
    private func configConstraints() -> Void {
        NSLayoutConstraint.activate([
            self.fundoDoLoading.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
            self.fundoDoLoading.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60),
            self.fundoDoLoading.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -60),
            self.fundoDoLoading.heightAnchor.constraint(equalToConstant: 80),
            
            self.barraDeLoading.topAnchor.constraint(equalTo: self.fundoDoLoading.topAnchor, constant: 20),
            self.leadingAnchorBarraDeLoading,
            self.barraDeLoading.heightAnchor.constraint(equalToConstant: 5),
            self.barraDeLoading.widthAnchor.constraint(equalToConstant: 50),
            
            self.gerandoPlanetaLabel.topAnchor.constraint(equalTo: self.barraDeLoading.bottomAnchor, constant: 10),
            self.gerandoPlanetaLabel.centerXAnchor.constraint(equalTo: self.fundoDoLoading.centerXAnchor)
        ])
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

