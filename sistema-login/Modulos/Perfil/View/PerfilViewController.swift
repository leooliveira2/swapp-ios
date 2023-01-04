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
        
        self.perfilView.getBotaoAdicionarImagemAoPerfil().addTarget(
            self,
            action: #selector(selecionarImagemDePerfil(_:)),
            for: .touchUpInside
        )
        
        self.perfilView.getNickUsuarioLabel().text = self.getNickNameDoUsuario()
        
        self.perfilView.getBotaoSairButton().addTarget(
            self,
            action: #selector(botaoSairFoiClicado(_: )),
            for: .touchUpInside
        )
        
        guard let pathImagem =  UserDefaults.standard.string(forKey: "path_imagem_perfil_\(self.getNickNameDoUsuario())") else { print("hihi"); return }
        
        guard let pathURL = URL(string: pathImagem) else { return }
        
        do {
            let data = try Data(contentsOf: pathURL)
            self.perfilView.getFotoDePerfilImageView().image = UIImage(data: data)
            print("Foto de perfil atualizada com sucesso!")
        } catch {
            print(error.localizedDescription)
        }
        
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
    
    // MARK: - Funcoes
    private func redirecionaParaViewEscolhidaNasOpcoesTableView(indiceClicado: Int) -> Void {
        if indiceClicado == 0 {
            self.navigationController?.pushViewController(PersonagensFavoritosViewController(), animated: true)
            return
        }
        
        if indiceClicado == 1 {
            self.navigationController?.pushViewController(PlanetasFavoritosViewController(), animated: true)
            return
        }
        
        if indiceClicado == 2 {
            self.navigationController?.pushViewController(NavesFavoritasViewController(), animated: true)
            return
        }
    }
    
    @objc func selecionarImagemDePerfil(_ sender: UIButton) -> Void {
        let perfilController = PerfilController()
        
        let selecionadorDeImagem = EscolherImagem(viewController: self)
        perfilController.selecaoDeImagemDePerfilDoUsuario(
            selecionadorDeImagem
        ) { (imagem, pathImagem) in
            
            guard let fotoDePerfil = imagem else { print("ERRRRRRRO"); return }
            guard let pathFotoDePerfil = pathImagem else { print("ERRRRRRO"); return }
            
            let pathString = pathFotoDePerfil.absoluteString

            self.perfilView.getFotoDePerfilImageView().image = fotoDePerfil
            self.salvarPathDaImagem(pathImagem: pathString)
        }
    }
    
    private func salvarPathDaImagem(pathImagem: String) -> Void {
        UserDefaults.standard.set(pathImagem, forKey: "path_imagem_perfil_\(self.getNickNameDoUsuario())")
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
        
//        var config = UIListContentConfiguration.cell()
//        config.text = ""
//        config.secondaryText = ""
//        config.image = UIImage
//        cell.contentConfiguration = config
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.redirecionaParaViewEscolhidaNasOpcoesTableView(indiceClicado: indexPath.row)
    }
    
}
