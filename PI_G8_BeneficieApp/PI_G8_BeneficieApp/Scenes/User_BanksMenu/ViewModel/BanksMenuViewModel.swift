//
//  BanksMenuViewModel.swift
//  PI_G8_BeneficieApp
//
//  Created by Dominique Nascimento Bezerra on 07/12/20.
//  Copyright © 2020 Juan Souza. All rights reserved.
//

import Foundation

class BanksMenuViewModel {
    var arrayBanks = [
        BankAccount(name: "PIX", photo: "PIX", agency: "", accountType: "Conta Corrente", accountNumber: "", accountBeneficited: ""),
        BankAccount(name: "Santander", photo: "BancoSantander", agency: "", accountType: "Conta ", accountNumber: "", accountBeneficited: "Mudadores"),
        BankAccount(name: "Nubank", photo: "BancoNubank", agency: "0001", accountType: "Conta Corrente", accountNumber: "000000-1", accountBeneficited: "Mudadores"),
        BankAccount(name: "Inter", photo: "BancoInter", agency: "BancoInter", accountType: "Conta ", accountNumber: "", accountBeneficited: "Mudadores"),
        BankAccount(name: "Bradesco", photo: "BancoBradesco", agency: "3142-9", accountType: "Conta Poupança", accountNumber: "1001908-7", accountBeneficited: "Mudadores"),
        BankAccount(name: "Banco do Brasil", photo: "BancoDoBrasil", agency: "1197-5", accountType: "Conta Corrente", accountNumber: "53923-6", accountBeneficited: "Mudadores"),
        BankAccount(name: "Caixa", photo: "BancoCaixa", agency: "3205", accountType: "Conta Poupança", accountNumber: "34102-3 Operação: 013", accountBeneficited: "Mudadores"),
        BankAccount(name: "Itaú", photo: "BancoItau", agency: "5488", accountType: "Conta ", accountNumber: "01610-5", accountBeneficited: "Mudadores")
    ]
}
