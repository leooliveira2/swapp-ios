//
//  PersonagensFavoritosViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 28/12/22.
//

import UIKit

class PersonagensFavoritosViewController: UIViewController {
    
    // MARK: - Atributos
    private var listaDePersonagensFavoritos: [Personagem] = []
    
    // MARK: - View
    private lazy var personagensFavoritosView: PersonagensFavoritosView = {
        let view = PersonagensFavoritosView()
        return view
    }()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.personagensFavoritosView
        
        self.personagensFavoritosView.getListaDePersonagensTableView().delegate = self
        self.personagensFavoritosView.getListaDePersonagensTableView().dataSource = self
        
        self.buscaPersonagensFavoritosDoUsuario()
        
        self.verificaQuantosPersonagensExistemParaConfigurarAVisualizacao()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Voltar"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Funcoes
    private func buscaPersonagensFavoritosDoUsuario() -> Void {
        let alertas = Alerta(viewController: self)
        
        guard let instanciaDoBanco = DBManager().openDatabase(DBPath: "dados_usuarios.sqlite") else { return }
        
        guard let nickNameDoUsuario = UserDefaults.standard.string(forKey: "user_id") else {
            alertas.criaAlerta(mensagem: "Erro interno! Favor tentar novamente!")
            return
        }
        
        let personagensFavoritosController = PersonagensFavoritosController(
            instanciaDoBanco: instanciaDoBanco
        )
        
        let buscadorDePersonagensFavoritos = BuscadorDePersonagensFavoritosSQLite(
            instanciaDoBanco: instanciaDoBanco
        )
        
        let buscaDadosDoUsuario = RecuperaDadosDoUsuarioSQLite(instanciaDoBanco: instanciaDoBanco)
        
        guard let listaDePersonagens = personagensFavoritosController.buscaTodosOsPersonagensFavoritosDoUsuario(
            nickNameUsuario: nickNameDoUsuario,
            buscadorDePersonagensFavoritos: buscadorDePersonagensFavoritos,
            buscadorDeDadosDoUsuario: buscaDadosDoUsuario
        ) else {
            alertas.criaAlerta(mensagem: "Erro ao buscar personagens")
            self.listaDePersonagensFavoritos = []
            return
        }
        
        self.listaDePersonagensFavoritos = listaDePersonagens
    }
    
    private func verificaQuantosPersonagensExistemParaConfigurarAVisualizacao() -> Void {
        if self.listaDePersonagensFavoritos.count == 0 {
            self.personagensFavoritosView.configComponentesQuandoNaoHouverPersonagens()
            return
        }
        
        self.personagensFavoritosView.configComponentesComListaDePersonagens()
    }

}

extension PersonagensFavoritosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaDePersonagensFavoritos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.listaDePersonagensFavoritos[indexPath.row].getNomePersonagem()
        cell.tintColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertas = Alerta(viewController: self)
        
        let personagem = self.listaDePersonagensFavoritos[indexPath.row]
        
        let mensagem = "\nAltura: \(personagem.getAlturaPersonagem())" +
                        "\n\nPeso: \(personagem.getPesoPersonagem())" +
                        "\n\nCor dos olhos: \(personagem.getCorDosOlhosPersonagem())" +
                        "\n\nAno de nascimento: \(personagem.getAnoNascimentoPersonagem())" +
                        "\n\nGênero: \(personagem.getGeneroPersonagem())"

        alertas.criaAlerta(titulo: personagem.getNomePersonagem(), mensagem: mensagem)
    }
    
}
