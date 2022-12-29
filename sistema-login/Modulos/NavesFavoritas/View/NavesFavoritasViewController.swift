//
//  NavesFavoritasViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 28/12/22.
//

import UIKit

class NavesFavoritasViewController: UIViewController {
    
    // MARK: - Atributos
    private var listaDeNavesFavoritas: [Nave] = []
    
    // MARK: - View
    private lazy var navesFavoritasView: NavesFavoritasView = {
        let view = NavesFavoritasView()
        return view
    }()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.navesFavoritasView
        
        self.navesFavoritasView.getListaDeNavesTableView().delegate = self
        self.navesFavoritasView.getListaDeNavesTableView().dataSource = self
        
        self.buscaNavesFavoritasDoUsuario()
        
        self.verificaQuantasNavesExistemParaConfigurarAVisualizacao()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Voltar"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Funcoes
    private func buscaNavesFavoritasDoUsuario() -> Void {
        let alertas = Alerta(viewController: self)
        
        guard let instanciaDoBanco = DBManager().openDatabase(DBPath: "dados_usuarios.sqlite") else { return }
        
        guard let nickNameDoUsuario = UserDefaults.standard.string(forKey: "user_id") else {
            alertas.criaAlerta(mensagem: "Erro interno! Favor tentar novamente!")
            return
        }
        
        let navesFavoritasController = NavesFavoritasController(
            instanciaDoBanco: instanciaDoBanco
        )
        
        let buscadorDeNavesFavoritas = BuscadorDeNavesFavoritasSQLite(
            instanciaDoBanco: instanciaDoBanco
        )
        
        let buscaDadosDoUsuario = RecuperaDadosDoUsuarioSQLite(instanciaDoBanco: instanciaDoBanco)
        
        guard let listaDeNaves = navesFavoritasController.buscaTodasAsNavesFavoritasDoUsuario(
            nickNameUsuario: nickNameDoUsuario,
            buscadorDeNavesFavoritas: buscadorDeNavesFavoritas,
            buscadorDeDadosDoUsuario: buscaDadosDoUsuario
        ) else {
            alertas.criaAlerta(mensagem: "Erro ao buscar naves")
            self.listaDeNavesFavoritas = []
            return
        }
        
        self.listaDeNavesFavoritas = listaDeNaves
    }
    
    private func verificaQuantasNavesExistemParaConfigurarAVisualizacao() -> Void {
        if self.listaDeNavesFavoritas.count == 0 {
            self.navesFavoritasView.configComponentesQuandoNaoHouverNaves()
            return
        }
        
        self.navesFavoritasView.configComponentesComListaDeNaves()
    }

}

extension NavesFavoritasViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaDeNavesFavoritas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.listaDeNavesFavoritas[indexPath.row].getNome()
        cell.tintColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertas = Alerta(viewController: self)
        
        let nave = self.listaDeNavesFavoritas[indexPath.row]
        
        let mensagem = "\nModelo: \(nave.getModelo())" +
                        "\n\nFabricante: \(nave.getFabricante())" +
                        "\n\nCusto em créditos: \(nave.getCustoEmCreditos())" +
                        "\n\nComprimento: \(nave.getComprimento())" +
                        "\n\nPassageiros: \(nave.getPassageiros())"

        alertas.criaAlerta(titulo: nave.getNome(), mensagem: mensagem)
    }
    
}
