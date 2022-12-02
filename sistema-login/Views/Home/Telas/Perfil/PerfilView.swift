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
    
    
    
    // MARK: - Inicializadores
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .darkGray
        
        self.configsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Config constraints
    private func configsConstraints() -> Void {
        self.addSubview(perfilLabel)
        
        NSLayoutConstraint.activate([
            self.perfilLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            self.perfilLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        
        ])
    }

}
