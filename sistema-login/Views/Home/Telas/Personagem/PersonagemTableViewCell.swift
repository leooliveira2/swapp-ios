//
//  PersonagemTableViewCell.swift
//  sistema-login
//
//  Created by Leonardo Leite on 25/11/22.
//

import UIKit

class PersonagemTableViewCell: UITableViewCell {
    
    // MARK: - Atributos
    static let identificador: String = "PersonagemTableViewCell"
    
    // MARK: - Componentes
    let personagemView: PersonagemView = {
        let view = PersonagemView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Inicializadores
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(self.personagemView)
        self.backgroundColor = .lightGray
        self.configsConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configs Constraints
    private func configsConstraints() -> Void {
        NSLayoutConstraint.activate([
            self.personagemView.topAnchor.constraint(equalTo: self.topAnchor),
            self.personagemView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.personagemView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.personagemView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }

}
