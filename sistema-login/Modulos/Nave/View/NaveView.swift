//
//  NaveView.swift
//  sistema-login
//
//  Created by Leonardo Leite on 24/11/22.
//

import UIKit

class NaveView: UIView {

    // MARK: - Atributos constraints
    private lazy var botaoTopAnchor: NSLayoutConstraint = {
        let topAnchor = self.gerarNaveButton.topAnchor.constraint(equalTo: self.centerYAnchor)
        return topAnchor
    }()

    // MARK: - Componentes
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "SpaceImage")
        return imageView
    }()
    
    private lazy var gerarNaveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Gerar Nave", for: .normal)
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
    
    private lazy var labelNave: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nave"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var dadosNaveTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 10
        tableView.layer.borderWidth = 2
        tableView.layer.borderColor = UIColor.white.cgColor
        tableView.isUserInteractionEnabled = false
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
    public func getBotaoGerarNave() -> UIButton {
        return self.gerarNaveButton
    }
    
    public func getDadosNaveTableView() -> UITableView {
        return self.dadosNaveTableView
    }
    
    // MARK: - Execucoes quando algo acontecer na tela
    public func exibeComponentesCaracteristicasDaNave() -> Void {
        self.addSubview(self.labelNave)
        self.addSubview(self.dadosNaveTableView)
        
        NSLayoutConstraint.activate([
            self.labelNave.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 100),
            self.labelNave.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.labelNave.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            
            self.dadosNaveTableView.topAnchor.constraint(equalTo: self.labelNave.bottomAnchor, constant: 10),
            self.dadosNaveTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            self.dadosNaveTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),
            self.dadosNaveTableView.heightAnchor.constraint(equalToConstant: self.dadosNaveTableView.contentSize.height),
        ])
        
        self.atualizaConstraintDoBotaoGerarNavePraBaixoDaTabelaDeNave()
    }
    
    public func retornaComponentesDaViewPraEstadoInicial() -> Void {
        self.removeConstraint(self.botaoTopAnchor)
        self.labelNave.removeFromSuperview()
        self.dadosNaveTableView.removeFromSuperview()
        
        self.botaoTopAnchor = self.gerarNaveButton.topAnchor.constraint(equalTo: self.centerYAnchor)
        
        NSLayoutConstraint.activate([
            self.botaoTopAnchor
        ])
    }
    
    private func atualizaConstraintDoBotaoGerarNavePraBaixoDaTabelaDeNave() -> Void {
        self.removeConstraint(self.botaoTopAnchor)
        
        self.botaoTopAnchor = self.gerarNaveButton.topAnchor.constraint(equalTo: self.dadosNaveTableView.bottomAnchor, constant: 30)
        
        NSLayoutConstraint.activate([
            self.botaoTopAnchor
        ])
    }
    
    // MARK: - Config Constraints
    private func configsContraints() -> Void {
        self.addSubview(self.backgroundImageView)
        self.addSubview(self.gerarNaveButton)
        
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.botaoTopAnchor,
            self.gerarNaveButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            self.gerarNaveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            self.gerarNaveButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
}

