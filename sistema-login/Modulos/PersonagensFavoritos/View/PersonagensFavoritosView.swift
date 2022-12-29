//
//  PersonagensFavoritosView.swift
//  sistema-login
//
//  Created by Leonardo Leite on 28/12/22.
//

import UIKit

class PersonagensFavoritosView: UIView {

    // MARK: - Componentes
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "SpaceImage")
        return imageView
    }()
    
    private lazy var semPersonagemLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sua lista de personagens esta vazia!"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = .lightGray
        label.layer.cornerRadius = 20
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.clipsToBounds = true
        return label
    }()
    
    // MARK: - Inicializadores
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configComponentes()
        
        self.configComponentesQuandoNaoHouverPersonagens()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Config componentes
    private func configComponentes() -> Void {
        self.addSubview(self.backgroundImage)
        
        NSLayoutConstraint.activate([
            self.backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.backgroundImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func configComponentesQuandoNaoHouverPersonagens() -> Void {
        self.addSubview(self.semPersonagemLabel)
        
        NSLayoutConstraint.activate([
            self.semPersonagemLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.semPersonagemLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.semPersonagemLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.semPersonagemLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        
        ])
    }
}
