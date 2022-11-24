//
//  NaveView.swift
//  sistema-login
//
//  Created by Leonardo Leite on 24/11/22.
//

import UIKit

class NaveView: UIView {

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
    
    // MARK: - Inicializadores
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configs constraints
    private func configsConstraints() -> Void {
        self.addSubview(self.backgroundImageView)
        self.addSubview(self.gerarNaveButton)
        
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        
            self.gerarNaveButton.topAnchor.constraint(equalTo: self.centerYAnchor),
            self.gerarNaveButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            self.gerarNaveButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            self.gerarNaveButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
