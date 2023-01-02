//
//  PlanetasFavoritosViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 28/12/22.
//

import UIKit

class PlanetasFavoritosViewController: UIViewController {

    // MARK: - Atributos
    private var listaDePlanetasFavoritos: [Planeta] = []
    
    // MARK: - View
    private lazy var planetasFavoritosView: PlanetasFavoritosView = {
        let view = PlanetasFavoritosView()
        return view
    }()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.planetasFavoritosView
        
        self.planetasFavoritosView.getListaDePlanetasTableView().delegate = self
        self.planetasFavoritosView.getListaDePlanetasTableView().dataSource = self
        
        self.buscaPlanetasFavoritosDoUsuario()
        
        self.verificaQuantosPlanetasExistemParaConfigurarAVisualizacao()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Voltar"
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Funcoes
    private func buscaPlanetasFavoritosDoUsuario() -> Void {
        let alertas = Alerta(viewController: self)
        
        guard let instanciaDoBanco = DBManager().openDatabase(DBPath: "dados_usuarios.sqlite") else { return }
        
        guard let nickNameDoUsuario = UserDefaults.standard.string(forKey: "user_id") else {
            alertas.criaAlerta(mensagem: "Erro interno! Favor tentar novamente!")
            return
        }
        
        let planetasFavoritosController = PlanetasFavoritosController(
            instanciaDoBanco: instanciaDoBanco
        )
        
        let buscadorDePlanetasFavoritos = BuscadorDePlanetasFavoritosSQLite(
            instanciaDoBanco: instanciaDoBanco
        )
        
        let buscaDadosDoUsuario = RecuperaDadosDoUsuarioSQLite(instanciaDoBanco: instanciaDoBanco)
        
        guard let listaDePlanetas = planetasFavoritosController.buscaTodosOsPlanetasFavoritosDoUsuario(
            nickNameUsuario: nickNameDoUsuario,
            buscadorDePlanetasFavoritos: buscadorDePlanetasFavoritos,
            buscadorDeDadosDoUsuario: buscaDadosDoUsuario
        ) else {
            alertas.criaAlerta(mensagem: "Erro ao buscar planetas")
            self.listaDePlanetasFavoritos = []
            return
        }
        
        self.listaDePlanetasFavoritos = listaDePlanetas
    }
    
    private func verificaQuantosPlanetasExistemParaConfigurarAVisualizacao() -> Void {
        if self.listaDePlanetasFavoritos.count == 0 {
            self.planetasFavoritosView.configComponentesQuandoNaoHouverPlanetas()
            return
        }
        
        self.planetasFavoritosView.configComponentesComListaDePlanetas()
    }
    
    private func acoesQuandoOBotaoRemoverPlanetaForClicado(
        planeta: Planeta,
        indice: IndexPath
    ) -> Void
    {
        let alertas = Alerta(viewController: self)
        
        guard let instanciaDoBanco = DBManager().openDatabase(DBPath: "dados_usuarios.sqlite") else { return }
        
        guard let nickNameDoUsuario = UserDefaults.standard.string(forKey: "user_id") else {
            alertas.criaAlerta(mensagem: "Erro ao remover planeta")
            return
        }
        
        let buscadorDeDadosDoUsuario = RecuperaDadosDoUsuarioSQLite(instanciaDoBanco: instanciaDoBanco)
        
        let removePlanetaFavorito = RemovePlanetaDosFavoritosSQLite(
            instanciaDoBanco: instanciaDoBanco
        )
        
        let planetasFavoritosController = PlanetasFavoritosController(
            instanciaDoBanco: instanciaDoBanco
        )
        
        let planetaFoiRemovido = planetasFavoritosController.removePlanetaDosFavoritosDoUsuario(
            planeta: planeta,
            nickNameDoUsuario: nickNameDoUsuario,
            buscadorDeDadosDoUsuario: buscadorDeDadosDoUsuario,
            removePlanetaFavorito: removePlanetaFavorito
        )
        
        if !planetaFoiRemovido {
            alertas.criaAlerta(mensagem: "Erro ao remover planeta")
            return
        }
        
        self.listaDePlanetasFavoritos.remove(at: indice.row)
        self.planetasFavoritosView.getListaDePlanetasTableView().reloadData()
        
        if self.listaDePlanetasFavoritos.count == 0 {
            self.planetasFavoritosView.configComponentesQuandoNaoHouverPlanetas()
        }

    }

}

extension PlanetasFavoritosViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaDePlanetasFavoritos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = self.listaDePlanetasFavoritos[indexPath.row].getNome()
        cell.tintColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertas = Alerta(viewController: self)
        
        let planeta = self.listaDePlanetasFavoritos[indexPath.row]
        
        let mensagem = "\nDiametro: \(planeta.getDiametro())" +
                       "\n\nClima: \(planeta.getClima())" +
                       "\n\nGravidade: \(planeta.getGravidade())" +
                       "\n\nTerreno: \(planeta.getTerreno())" +
                       "\n\nPopulação: \(planeta.getPopulacao())"

        alertas.criaAlertaPersonalizadoExibicaoDeFavoritos(
            titulo: planeta.getNome(),
            mensagem: mensagem,
            handler: { _ in
                self.acoesQuandoOBotaoRemoverPlanetaForClicado(
                    planeta: planeta,
                    indice: indexPath
                )
            }
        )
    }
    
}

