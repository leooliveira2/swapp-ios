//
//  doisTests.swift
//  sistema-loginTests
//
//  Created by Leonardo Leite on 19/12/22.
//

import XCTest
@testable import sistema_login

final class CriacaoDeContaControllerTests: XCTestCase {
    
    // MARK: - Atributos
    private var controladorDeErros: ControladorDeErros!
    private var validadorDeDadosDoUsuario: ValidacoesDeDadosDoUsuario!
    private var salvaUsuario: SalvarUsuarioSystemMock!
    private var verificadorDeDadosCadastrados: VerificadorDeDadosCadastradosSystemMock!
    
    private var controladorCriacaoDeConta: CriacaoDeContaController!
    
    // MARK: - Pre-sets
    override func setUpWithError() throws {
        self.controladorDeErros = ControladorDeErros()
        self.validadorDeDadosDoUsuario = ValidacoesDeDadosDoUsuario(self.controladorDeErros)
        self.salvaUsuario = SalvarUsuarioSystemMock()
        self.verificadorDeDadosCadastrados = VerificadorDeDadosCadastradosSystemMock()
        
        self.controladorCriacaoDeConta = CriacaoDeContaController(
            controladorDeErros,
            validadorDeDadosDoUsuario,
            salvaUsuario,
            verificadorDeDadosCadastrados
        )
    }

    // MARK: - Testes
    func testTodosOsDadosDoUsuarioEstaoNulos() {
        let contaPodeSerCriada = self.controladorCriacaoDeConta.criarConta(
            nickName: nil,
            nomeCompleto: nil,
            email: nil,
            senha: nil,
            repeticaoDeSenha: nil
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriada)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[0])
    }
    
    func testAlgumDadoDoUsuarioEstaNulo() {
        let nickNameEstaNulo = self.controladorCriacaoDeConta.criarConta(
            nickName: nil,
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let nomeCompletoEstaNulo = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: nil,
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let emailEstaNulo = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "Nome",
            email: nil,
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let senhaEstaNula = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: nil,
            repeticaoDeSenha: "123123123"
        )
        
        let repeticaoDeSenhaEstaNula = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: nil
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(nickNameEstaNulo)
        XCTAssertFalse(nomeCompletoEstaNulo)
        XCTAssertFalse(emailEstaNulo)
        XCTAssertFalse(senhaEstaNula)
        XCTAssertFalse(repeticaoDeSenhaEstaNula)
        
        XCTAssertEqual(5, erros.count)
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[0])
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[1])
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[2])
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[3])
        XCTAssertEqual(.erro_algum_dado_do_usuario_esta_nulo, erros[4])
    }
    
    func testCenariosEmQueONickNameEInvalido() {
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeEmailJaEstaCadastrado = false
        
        let contaPodeSerCriadaComNickNameDoUsuarioVazio = self.controladorCriacaoDeConta.criarConta(
            nickName: "",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let contaPodeSerCriadaComNickNameDoUsuarioTendoMenosDe5Caracteres = self.controladorCriacaoDeConta.criarConta(
            nickName: "cont",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let contaPodeSerCriadaComNickNameDoUsuarioTendoMaisDe32Caracteres = self.controladorCriacaoDeConta.criarConta(
            nickName: "abcdefghijklmnopqrstuvwxyzabcdefg",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let contaPodeSerCriadaComNickNameDoUsuarioNaoSendoUmAlfaNumerico = self.controladorCriacaoDeConta.criarConta(
            nickName: "@_ #$%",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeNickNameJaEstaCadastrado = true
        
        let contaPodeSerCriadaComNickNameDoUsuarioJaCadastrado = self.controladorCriacaoDeConta.criarConta(
            nickName: "Teste",
            nomeCompleto: "Nome",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriadaComNickNameDoUsuarioVazio)
        XCTAssertFalse(contaPodeSerCriadaComNickNameDoUsuarioTendoMenosDe5Caracteres)
        XCTAssertFalse(contaPodeSerCriadaComNickNameDoUsuarioTendoMaisDe32Caracteres)
        XCTAssertFalse(contaPodeSerCriadaComNickNameDoUsuarioNaoSendoUmAlfaNumerico)
        XCTAssertFalse(contaPodeSerCriadaComNickNameDoUsuarioJaCadastrado)
        
        XCTAssertEqual(5, erros.count)
        
        XCTAssertEqual(.erro_nick_de_usuario_vazio, erros[0])
        XCTAssertEqual(.erro_nick_de_usuario_tem_menos_de_5_caracteres, erros[1])
        XCTAssertEqual(.erro_nick_de_usuario_nao_pode_ter_mais_de_32_caracteres, erros[2])
        XCTAssertEqual(.erro_nick_de_usuario_nao_e_um_alfanumerico, erros[3])
        XCTAssertEqual(.erro_nick_de_usuario_ja_esta_cadastrado, erros[4])
    }
    
    func testCenariosEmQueONomeCompletoEInvalido() {
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeNickNameJaEstaCadastrado = false
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeEmailJaEstaCadastrado = false
        
        let contaPodeSerCriadaComNomeCompletoDoUsuarioVazio = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let contaPodeSerCriadaComNomeCompletoDoUsuarioContendoCaracteresInvalidos = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: "122$#%_",
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let nomeCompleto = "abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefgabcdefghijklmnopqrstuvwxyz" + "abcdefgabcdefghijklmnopqrstuvwxyzabcdefgabcdef"
        
        let contaPodeSerCriadaComNomeCompletoDoUsuarioContendoMaisDe130Caracteres = self.controladorCriacaoDeConta.criarConta(
            nickName: "Apelido",
            nomeCompleto: nomeCompleto,
            email: "email@email.com",
            senha: "123123123",
            repeticaoDeSenha: "123123123"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriadaComNomeCompletoDoUsuarioVazio)
        XCTAssertFalse(contaPodeSerCriadaComNomeCompletoDoUsuarioContendoCaracteresInvalidos)
        XCTAssertFalse(contaPodeSerCriadaComNomeCompletoDoUsuarioContendoMaisDe130Caracteres)
        
        XCTAssertEqual(3, erros.count)
        
        XCTAssertEqual(.erro_nome_completo_vazio, erros[0])
        XCTAssertEqual(.erro_nome_completo_so_pode_conter_letras_e_espacos, erros[1])
        XCTAssertEqual(.erro_nome_completo_nao_pode_ter_mais_de_130_caracteres, erros[2])
    }
    
    func testUsuarioTemDadosValidosMasUmaFalhaOcorreAoTentarSalvar() {
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeNickNameJaEstaCadastrado = false
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeEmailJaEstaCadastrado = false
        self.salvaUsuario.retornoDaFuncaoSalvar = false
        
        let contaPodeSerCriada = self.controladorCriacaoDeConta.criarConta(
            nickName: "teste1",
            nomeCompleto: "Usuario",
            email: "teste1@email.com",
            senha: "12345678",
            repeticaoDeSenha: "12345678"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertFalse(contaPodeSerCriada)
        XCTAssertEqual(1, erros.count)
        XCTAssertEqual(.erro_ao_salvar_usuario, erros[0])
    }
    
    func testUsuarioTemDadosValidosEFoiSalvoComSucesso() {
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeNickNameJaEstaCadastrado = false
        self.verificadorDeDadosCadastrados.retornoDaFuncaoVerificaSeEmailJaEstaCadastrado = false
        self.salvaUsuario.retornoDaFuncaoSalvar = true
        
        let contaPodeSerCriada = self.controladorCriacaoDeConta.criarConta(
            nickName: "teste2",
            nomeCompleto: "Usuario",
            email: "teste2@email.com",
            senha: "12345678",
            repeticaoDeSenha: "12345678"
        )
        
        let erros = self.controladorDeErros.getErros()
        
        XCTAssertTrue(contaPodeSerCriada)
        XCTAssertEqual(0, erros.count)
    }

}
