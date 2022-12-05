//
//  NaveViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class NaveViewController: UIViewController {
    
    // MARK: - Atributos
    private lazy var naveView: NaveView = {
        let view = NaveView()
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
    
    private lazy var gerandoNaveLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Gerando Nave...."
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
        self.view = self.naveView
        
        self.naveView.getBotaoGerarNave().addTarget(
            self,
            action: #selector(acaoBotaoGerarNave(_:)),
            for: .touchUpInside
        )
    
        self.naveView.getDadosNaveTableView().delegate = self
        self.naveView.getDadosNaveTableView().dataSource = self
        
        self.fundoDoLoading.addSubview(self.barraDeLoading)
        self.fundoDoLoading.addSubview(self.gerandoNaveLabel)
        self.view.addSubview(self.fundoDoLoading)
        self.configConstraints()
        
        self.fundoDoLoading.isHidden = true
    }
    
    // MARK: - Actions
    @objc private func acaoBotaoGerarNave(_ sender: UIButton) -> Void {
        let naveController = NaveController()
        
        naveController.gerarNave(sucesso: { (nave) in
            let caracteristicasDaNave: [String] = nave.getListaComDadosDaNave()
            self.adicionaOsDadosDaNaveAsLinhasDaTableView(caracteristicasDaNave)
        },
        fracasso: { (erro) in
            let controladorDeAlertas = Alerta(viewController: self)
            self.retornaViewPraEstadoInicialEmCasoDeErroAoBuscarNave(controladorDeAlertas)
            return
        })
        
        if self.qntsVezesOBotaoFoiClicado != 0 {
            return
        }
        
        self.fundoDoLoading.isHidden = false
        self.animacaoQuandoOBotaoGerarNaveEClicado()
       
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.atualizaViewParaExibirTabela()
        }
                
    }
    
    // MARK: - Funcoes
    private func adicionaOsDadosDaNaveAsLinhasDaTableView(_ caracteristicasDaNave: [String]) -> Void {
        for indice in 0...5 {
            self.naveView.getDadosNaveTableView().cellForRow(at: IndexPath(item: indice, section: 0))?.textLabel?.text = caracteristicasDaNave[indice]
        }
    }
    
    private func atualizaViewParaExibirTabela() -> Void {
        self.naveView.exibeComponentesCaracteristicasDaNave()
        self.qntsVezesOBotaoFoiClicado += 1
    }
    
    private func retornaViewPraEstadoInicialEmCasoDeErroAoBuscarNave(_ controladorAlertas: Alerta) -> Void {
        controladorAlertas.criaAlerta(mensagem: "Erro ao gerar nave! Tenta novamente")
        
        self.naveView.retornaComponentesDaViewPraEstadoInicial()
        self.qntsVezesOBotaoFoiClicado = 0
    }
    
    // MARK: - Animacoes
    private func animacaoQuandoOBotaoGerarNaveEClicado() -> Void {
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
            
            self.gerandoNaveLabel.topAnchor.constraint(equalTo: self.barraDeLoading.bottomAnchor, constant: 10),
            self.gerandoNaveLabel.centerXAnchor.constraint(equalTo: self.fundoDoLoading.centerXAnchor)
        ])
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
                
        return cell
    }

}
