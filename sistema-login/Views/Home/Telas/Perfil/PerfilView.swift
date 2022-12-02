//
//  PerfilView.swift
//  sistema-login
//
//  Created by Leonardo Leite on 02/12/22.
//

import UIKit

class PerfilView: UIView {

    // MARK: - Componentes
    private lazy var perfilLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Perfil"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    private lazy var fotoDePerfilImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 50
        imageView.layer.borderWidth = 10
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.image = UIImage(systemName: "person.circle.fill")
        return imageView
    }()
    
    // MARK: - Inicializadores
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .darkGray
        
        self.configsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Funcoes
    public func getFotoDePerfilImageView() -> UIImageView {
        return self.fotoDePerfilImageView
    }
    
    // MARK: - Config constraints
    private func configsConstraints() -> Void {
        self.addSubview(perfilLabel)
        self.addSubview(self.fotoDePerfilImageView)
        
        NSLayoutConstraint.activate([
            self.perfilLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.perfilLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            self.fotoDePerfilImageView.topAnchor.constraint(equalTo: self.perfilLabel.bottomAnchor, constant: 10),
            self.fotoDePerfilImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.fotoDePerfilImageView.widthAnchor.constraint(equalToConstant: 100),
            self.fotoDePerfilImageView.heightAnchor.constraint(equalToConstant: 100)
        
        ])
    }

}
