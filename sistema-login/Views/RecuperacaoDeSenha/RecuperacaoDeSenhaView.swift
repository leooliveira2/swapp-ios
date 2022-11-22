//
//  RecuperacaoDeSenhaView.swift
//  sistema-login
//
//  Created by Leonardo Leite on 22/11/22.
//

import UIKit

class RecuperacaoDeSenhaView: UIView {

    // MARK: - Componentes
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "BGLogin")
        return imageView
    }()
    
    private lazy var tituloRecuperaSenhaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Recuperar senha"
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "E-mail"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(red: 52/255, green: 52/255, blue: 52/255, alpha: 1.0)
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(
            string: "Informe seu e-mail",
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.4)
            ]
        )
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.5
        textField.layer.borderColor = UIColor.white.cgColor
        return textField
    }()
    
    private lazy var usuarioNaoEncontradoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        label.text = "Usuário não encontrado!"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.borderWidth = 1.5
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.cornerRadius = 10
        return label
    }()
    
    private lazy var linhaDeSeparacaoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    // MARK: - Inicializadores
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Funcoes
    private func exibeLabelCasoOUsuarioNaoExista() -> Void {
        self.addSubview(self.usuarioNaoEncontradoLabel)
        
        NSLayoutConstraint.activate([
            self.usuarioNaoEncontradoLabel.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 20),
            self.usuarioNaoEncontradoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            self.usuarioNaoEncontradoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            self.usuarioNaoEncontradoLabel.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    private func exibeComponentesNecessariosParaRedefinicaoDaSenha() -> Void {
        self.addSubview(self.linhaDeSeparacaoView)
        
        NSLayoutConstraint.activate([
            self.linhaDeSeparacaoView.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 30),
            self.linhaDeSeparacaoView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.linhaDeSeparacaoView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.linhaDeSeparacaoView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    // MARK: - Constraints
    private func configsConstraints() -> Void {
        self.addSubview(self.backgroundImageView)
        self.addSubview(self.tituloRecuperaSenhaLabel)
        self.addSubview(self.emailLabel)
        self.addSubview(self.emailTextField)
        
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.tituloRecuperaSenhaLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.tituloRecuperaSenhaLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.emailLabel.topAnchor.constraint(equalTo: self.tituloRecuperaSenhaLabel.bottomAnchor, constant: 30),
            self.emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            self.emailTextField.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 5),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 45),
                        
        ])
    }
    
}
