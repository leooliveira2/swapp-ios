//
//  PersonagemView.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class PersonagemView: UIView {

    // MARK: - Atributos
    private lazy var botaoTopAnchor: NSLayoutConstraint = {
        let topAnchor = self.gerarPersonagemButton.topAnchor.constraint(equalTo: self.centerYAnchor)
        return topAnchor
    }()

    // MARK: - Componentes
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "SpaceImage")
        return imageView
    }()
    
    private lazy var gerarPersonagemButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Gerar Personagem", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0), for: .normal)
        button.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 20
        return button
    }()
    
    private lazy var labelPersonagem: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Personagem"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var dadosPersonagemTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 10
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = UIColor.white.cgColor
//        tableView.register(PersonagemTableViewCell.self, forCellReuseIdentifier: PersonagemTableViewCell.identificador)
        return tableView
    }()
    
    // MARK: - Inicializadores
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configsContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Funcoes
    public func getBotaoGerarPersonagem() -> UIButton {
        return self.gerarPersonagemButton
    }
    
    public func getDadosPersonagemTableView() -> UITableView {
        return self.dadosPersonagemTableView
    }
    
    // MARK: - Execucoes quando algo acontecer na tela
    public func exibeComponentesCaracteristicasDoPersonagem() -> Void {
        self.addSubview(self.labelPersonagem)
        self.addSubview(self.dadosPersonagemTableView)
        
        NSLayoutConstraint.activate([
            self.labelPersonagem.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            self.labelPersonagem.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.labelPersonagem.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            self.dadosPersonagemTableView.topAnchor.constraint(equalTo: self.labelPersonagem.bottomAnchor, constant: 10),
            self.dadosPersonagemTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.dadosPersonagemTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            self.dadosPersonagemTableView.heightAnchor.constraint(equalToConstant: self.dadosPersonagemTableView.contentSize.height),
        ])
        
        self.atualizaConstraintDoBotaoGerarPersonagemPraBaixoDaTabelaDePersonagem()
    }
    
    public func retornaComponentesDaViewPraEstadoInicial() -> Void {
        self.removeConstraint(self.botaoTopAnchor)
        self.labelPersonagem.removeFromSuperview()
        self.dadosPersonagemTableView.removeFromSuperview()
        
        self.botaoTopAnchor = self.gerarPersonagemButton.topAnchor.constraint(equalTo: self.centerYAnchor)
        
        NSLayoutConstraint.activate([
            self.botaoTopAnchor
        ])
    }
    
    private func atualizaConstraintDoBotaoGerarPersonagemPraBaixoDaTabelaDePersonagem() -> Void {
        self.removeConstraint(self.botaoTopAnchor)
        
        self.botaoTopAnchor = self.gerarPersonagemButton.topAnchor.constraint(equalTo: self.dadosPersonagemTableView.bottomAnchor, constant: 30)
        
        NSLayoutConstraint.activate([
            self.botaoTopAnchor
        ])
    }
    
    // MARK: - Config Constraints
    private func configsContraints() -> Void {
        self.addSubview(self.backgroundImageView)
        self.addSubview(self.gerarPersonagemButton)
        
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.botaoTopAnchor,
            self.gerarPersonagemButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            self.gerarPersonagemButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
      
            self.gerarPersonagemButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}
