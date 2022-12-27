//
//  PersonagemViewController.swift
//  sistema-login
//
//  Created by Leonardo Leite on 23/11/22.
//

import UIKit

class PersonagemViewController: UIViewController {
    
    // MARK: - View
    private lazy var personagemView: PersonagemView = {
        let view = PersonagemView()
        return view
    }()
    
    // MARK: - Atributos
    private var animacao: Animacao?
    private var personagem: Personagem?
    private var personagemJaEstaFavoritado: Bool = false
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = self.personagemView
        
        self.personagemView.getBotaoGerarPersonagem().addTarget(
            self,
            action: #selector(acaoBotaoGerarPersonagem(_:)),
            for: .touchUpInside
        )
        
        self.personagemView.getAdicionarAosFavoritosButton().addTarget(
            self,
            action: #selector(acaoBotaoAdicionarAosFavoritos(_:)),
            for: .touchUpInside
        )
        
        self.personagemView.getDadosPersonagemTableView().delegate = self
        self.personagemView.getDadosPersonagemTableView().dataSource = self
        
        self.animacao = Animacao(view: self.personagemView)
        
        // akmskamsakms
        guard let instanciaDoBanco = DBManager().openDatabase(DBPath: "dados_usuarios.sqlite") else { print("Erro ao abrir banco aqui oh"); return }
        
        Crud().deleteTodosOsPersonagensPorId(id: 2, instanciaDoBanco: instanciaDoBanco)
        
    }
    
    // MARK: - Actions
    @objc private func acaoBotaoGerarPersonagem(_ sender: UIButton) -> Void {
        guard let animacao = self.animacao else { return }
        
        self.personagemJaEstaFavoritado = false
        
        self.personagemView.execucaoQuandoOBotaoAdicionarAosFavoritosForDesmarcado()
        
        self.personagemView.exibeComponentesCaracteristicasDoPersonagem()
        
        animacao.iniciarAnimacao()
        
        let personagemController = PersonagemController()
        
        let requisicoesSWAPI = RequisicoesStarWarsAPI()
        
        personagemController.gerarPersonagem(requisicoesSWAPI: requisicoesSWAPI) { personagem in
            self.personagem = personagem
            
            guard let nickNameDoUsuario = UserDefaults.standard.string(forKey: "user_id") else { return }
            
            let jaEstaFavoritado = self.verificaSePersonagemJaEstaFavoritado(personagem: personagem, nickName: nickNameDoUsuario)
            
            if jaEstaFavoritado {
                self.personagemJaEstaFavoritado = true
                self.personagemView.execucaoQuandoUmPersonagemForAdicionadoAosFavoritos()
            }
            
            let dadosPersonagem = personagem.getListaComDadosDoPersonagem()
            self.adicionaOsDadosDoPersonagemAsLinhasDaTableView(dadosPersonagem)
            print(dadosPersonagem)
            animacao.pararAnimacao()
        } fracasso: {
            let alerta = Alerta(viewController: self)
            self.retornaViewPraEstadoInicialEmCasoDeErroAoBuscarPersonagem(alerta)
            animacao.pararAnimacao()
        }
    }
    
    @objc private func acaoBotaoAdicionarAosFavoritos(_ sender: UIButton) -> Void {
        let alerta = Alerta(viewController: self)
        
        let personagemController = PersonagemController()
        
        guard let personagem = self.personagem else { print("ERRRRRrRO"); return }
        
        guard let nickNameDoUsuario = UserDefaults.standard.string(forKey: "user_id") else { return }
        
        guard let instanciaDoBanco = DBManager().openDatabase(DBPath: "dados_usuarios.sqlite") else { print("Erro ao abrir banco aqui oh"); return }
        
        let buscadorDeDadosDoUsuario = RecuperaDadosDoUsuarioSQLite(instanciaDoBanco: instanciaDoBanco)
        
        if self.personagemJaEstaFavoritado {
            let removePersonagemDosFavoritos = RemovePersonagemDosFavoritosSQLite(
                buscadorDeDadosDoUsuario: buscadorDeDadosDoUsuario,
                instanciaDoBanco: instanciaDoBanco
            )
            
            let personagemFoiRemovido = personagemController.removerPersonagemDosFavoritos(
                personagem: personagem,
                nickNameDoUsuario: nickNameDoUsuario,
                buscadorDeDadosDoUsuario: buscadorDeDadosDoUsuario,
                removePersonagemDosFavoritos: removePersonagemDosFavoritos
            )
            
            if personagemFoiRemovido {
                alerta.criaAlerta(titulo: "Sucesso", mensagem: "\(personagem.getNomePersonagem()) foi removido com sucesso de seus favoritos")
                self.personagemView.execucaoQuandoOBotaoAdicionarAosFavoritosForDesmarcado()
                self.personagemJaEstaFavoritado = false
                return
            }
            
            alerta.criaAlerta(mensagem: "Erro ao remover personagem!")
        }
        
        let adicionaAosFavoritos = SalvarPersonagemFavoritoSQLite(instanciaDoBanco: instanciaDoBanco)
        
        let personagemFoiSalvo = personagemController.adicionarPersonagemAosFavoritos(
            personagem,
            adicionaAosFavoritos: adicionaAosFavoritos,
            buscaDadosDoUsuario: buscadorDeDadosDoUsuario,
            nickNameDoUsuario: nickNameDoUsuario
        )
        
        if personagemFoiSalvo {
            alerta.criaAlerta(titulo: "Sucesso", mensagem: "Personagem adicionado aos favoritos")
            
            print("----------------------------")
            Crud().exibirTodosOsDadosDosPersonagens(db: instanciaDoBanco)
            Crud().exibeTodosOsUsuariosSalvos(instanciaDoBanco: instanciaDoBanco)
            print("----------------------------")
            
            self.personagemView.execucaoQuandoUmPersonagemForAdicionadoAosFavoritos()
            self.personagemJaEstaFavoritado = true
            
        }
        
    }
    
    private func verificaSePersonagemJaEstaFavoritado(personagem: Personagem, nickName: String) -> Bool {
        guard let instanciaDoBanco = DBManager().openDatabase(DBPath: "dados_usuarios.sqlite") else { print("Erro ao abrir banco aqui oh"); return false }
        
        let buscadorDeDadosDoUsuario = RecuperaDadosDoUsuarioSQLite(instanciaDoBanco: instanciaDoBanco)

        let verificadorDePersonagensSalvosPorUsuario = VerificadorDePersonagensJaAdicionadosAUmUsuarioSQLite(buscadorDeDadosDoUsuario: buscadorDeDadosDoUsuario, instanciaDoBanco: instanciaDoBanco)
        
        let personagemJaEstaFavoritado = verificadorDePersonagensSalvosPorUsuario.verificaSePersonagemJaEstaFavoritadoPeloUsuario(personagem: personagem, nickNameDeUsuario: nickName)
        
        print(personagemJaEstaFavoritado)
        
        return personagemJaEstaFavoritado
    }
    
    // MARK: - Funcoes
    private func adicionaOsDadosDoPersonagemAsLinhasDaTableView(_ caracteristicasDoPersonagem: [String]) -> Void {
        for indice in 0...5 {
            self.personagemView.getDadosPersonagemTableView().cellForRow(at: IndexPath(item: indice, section: 0))?.textLabel?.text = caracteristicasDoPersonagem[indice]
        }
    }
    
    private func retornaViewPraEstadoInicialEmCasoDeErroAoBuscarPersonagem(_ controladorAlertas: Alerta) -> Void {
        controladorAlertas.criaAlerta(mensagem: "Erro ao gerar personagem! Tenta novamente")
        
        self.personagemView.retornaComponentesDaViewPraEstadoInicial()
    }
}

// MARK: - Extensoes
extension PersonagemViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.backgroundColor = .lightGray
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
                
        return cell
    }

}
