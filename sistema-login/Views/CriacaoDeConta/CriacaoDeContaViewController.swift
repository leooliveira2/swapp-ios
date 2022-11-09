//
//  CriacaoDeContaViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 07/11/22.
//

import UIKit

class CriacaoDeContaViewController: UIViewController {
    
    // MARK: - Atributos
    private lazy var criacaoDeContaView: CriacaoDeContaView = {
        let view = CriacaoDeContaView()
        return view
    }()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = self.criacaoDeContaView
        self.criacaoDeContaView.getBotaoCriarConta().addTarget(self, action: #selector(criarConta(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Voltar"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Funcoes
    @objc private func criarConta(_ sender: UIButton) -> Void {
        self.navigationController?.popViewController(animated: true)
    }

}
