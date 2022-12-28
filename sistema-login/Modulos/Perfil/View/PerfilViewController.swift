//
//  SairViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 02/12/22.
//

import UIKit

class PerfilViewController: UIViewController {

    // MARK: - View
    private lazy var perfilView: PerfilView = {
        let view = PerfilView()
        return view
    }()
    
    // MARK: - Atributos
    private let conteudoCelulasOpcoesTableView: [String] = [
        "Personagens favoritos",
        "Planetas favoritos",
        "Naves favoritas"
    ]
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.perfilView
        
        self.perfilView.getOpcoesTableView().delegate = self
        self.perfilView.getOpcoesTableView().dataSource = self
        
        self.perfilView.getNickUsuarioLabel().text = self.getNickNameDoUsuario()
        
        self.perfilView.getBotaoSairButton().addTarget(self, action: #selector(botaoSairFoiClicado(_: )), for: .touchUpInside)
        
        guard let navigationController = self.navigationController else { return }
        
        if navigationController.viewControllers.count > 1 {
            navigationController.viewControllers.removeFirst()
        }
    }
    
    // MARK: - Actions
    @objc private func botaoSairFoiClicado(_ sender: UIButton) -> Void {
        
        let perfilController = PerfilController()
        
        perfilController.removeOsDadosDeLoginDoUsuario()
        
        guard let navigationController = self.navigationController else { return }
        
        navigationController.pushViewController(LoginViewController(), animated: true)
    }
    
    private func getNickNameDoUsuario() -> String {
        guard let nickNameDoUsuario = UserDefaults.standard.string(forKey: "user_id") else { return "" }
        
        return nickNameDoUsuario
    }
        
}

// MARK: - Extensoes
extension PerfilViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.backgroundColor = .black
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.numberOfLines = 2
        
        cell.textLabel?.text = self.conteudoCelulasOpcoesTableView[indexPath.row]
        cell.textLabel?.textColor = .white
        
        return cell
    }
    
}
