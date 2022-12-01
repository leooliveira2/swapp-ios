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
    
    private lazy var leadingAnchorBarraDeLoading: NSLayoutConstraint = {
        let leadingAnchor = self.barraDeLoading.leadingAnchor.constraint(equalTo: self.fundoDoLoading.leadingAnchor, constant: 20)
        return leadingAnchor
    }()
    
    private lazy var gerandoPersonagemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Gerando Personagem...."
        label.textColor = .blue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
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
    
        self.personagemView.getDadosPersonagemTableView().delegate = self
        self.personagemView.getDadosPersonagemTableView().dataSource = self
        
        self.fundoDoLoading.addSubview(self.barraDeLoading)
        self.fundoDoLoading.addSubview(self.gerandoPersonagemLabel)
        self.view.addSubview(self.fundoDoLoading)
        self.configConstraints()
        
        self.fundoDoLoading.isHidden = true
    }
    
    // MARK: - Actions
    @objc private func acaoBotaoGerarPersonagem(_ sender: UIButton) -> Void {
        let personagemController = PersonagemController()
        
        personagemController.gerarPersonagem(sucesso: { (personagem) in
            let caracteristicasDoPersonagem: [String] = personagem.getListaComDadosDoPersonagem()
            self.adicionaOsDadosDoPersonagemAsLinhasDaTableView(caracteristicasDoPersonagem)
        },
        fracasso: { (erro) in
            let controladorDeAlertas = Alerta(viewController: self)
            self.retornaViewPraEstadoInicialEmCasoDeErroAoBuscarPersonagem(controladorDeAlertas)
            return
        })
        
        if self.qntsVezesOBotaoFoiClicado != 0 {
            return
        }
        
        self.fundoDoLoading.isHidden = false
        self.animacaoQuandoOBotaoGerarPersonagemEClicado()
       
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.atualizaViewParaExibirTabela()
        }
                
    }
    
    // MARK: - Funcoes
    private func adicionaOsDadosDoPersonagemAsLinhasDaTableView(_ caracteristicasDoPersonagem: [String]) -> Void {
        for indice in 0...5 {
            self.personagemView.getDadosPersonagemTableView().cellForRow(at: IndexPath(item: indice, section: 0))?.textLabel?.text = caracteristicasDoPersonagem[indice]
        }
    }
    
    private func atualizaViewParaExibirTabela() -> Void {
        self.personagemView.exibeComponentesCaracteristicasDoPersonagem()
        self.qntsVezesOBotaoFoiClicado += 1
    }
    
    private func retornaViewPraEstadoInicialEmCasoDeErroAoBuscarPersonagem(_ controladorAlertas: Alerta) -> Void {
        controladorAlertas.criaAlerta(mensagem: "Erro ao gerar personagem! Tenta novamente")
        
        self.personagemView.retornaComponentesDaViewPraEstadoInicial()
        self.qntsVezesOBotaoFoiClicado = 0
    }
    
    // MARK: - Animacoes
    private func animacaoQuandoOBotaoGerarPersonagemEClicado() -> Void {
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
            
            self.gerandoPersonagemLabel.topAnchor.constraint(equalTo: self.barraDeLoading.bottomAnchor, constant: 10),
            self.gerandoPersonagemLabel.centerXAnchor.constraint(equalTo: self.fundoDoLoading.centerXAnchor)
        ])
    }
}

// MARK: - Extensoes
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
