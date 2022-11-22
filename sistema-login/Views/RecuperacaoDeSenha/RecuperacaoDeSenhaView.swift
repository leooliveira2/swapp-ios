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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
