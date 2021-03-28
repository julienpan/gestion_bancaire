class Comptes : Clients {
  // Dictionnaire contenent les comptes possibles
  var dictCompte : [Int:Double]
  var numCompte : Int

  init(nom:String, prenom:String, adresse:String, numero:Int, dictCompte:[Int:Double], numCompte:Int) {
    self.dictCompte = dictCompte
    self.numCompte = numCompte
    super.init(nom:nom, prenom:prenom, adresse:adresse, numero:numero)
  }

  var getSetDictCompte : [Int:Double] {
    get {
      return self.dictCompte
    }
    set(dictCompte) {
      self.dictCompte = dictCompte
    }
  }

  var getSetNumCompte : Int {
    get {
      return self.numCompte
    }
    set(numCompte) {
      self.numCompte = numCompte
    }
  }

  // Deposer de l'argent dans le compte courant
  func depot(montant:Double) {
    for (cle, valeur) in dictCompte {
      if cle == 1 {
        print("Depot de \(montant) $")
        dictCompte.updateValue(montant + valeur, forKey:1)
      }
    }
  }
  
  // Retirer de l'argent dans le compte courant
  func retirer(montant:Double) {
    for (cle, valeur) in dictCompte {
      if cle == 1 {
        if valeur - montant >= 0 {
          print("Retrait de \(montant) $ du compte dépôt...\n")
          dictCompte.updateValue(valeur - montant, forKey:1)
        } else {
          print("Le montant demandé est plus élevé que la somme actuelle du compte.\n")
        }
      }
    }
  }

  // Afficher le solde des différents comptes
  func affiche() {
    for (cle, valeur) in dictCompte {
      print("Compte \(cle) : \(valeur) $\t")
    }
  }

  func affichen() {
    print("Votre numero de compte est \(numCompte)")
  }

  // Virement entre les comptes
  func virement(montant:Double, compte1:Int, compte2:Int) {
    for (cle, valeur) in dictCompte {
      // virement à partir de Courant
      if cle == compte1 && compte1 == 1 {
        if compte2 == 2 {
          if valeur - montant >= 0 {
            dictCompte.updateValue(valeur - montant, forKey:compte1)
            dictCompte.updateValue(dictCompte[compte2]! + montant, forKey: compte2)
            print("Virement de \(montant) $ du compte \(compte1) au \(compte2)")
          }
        }
        if compte2 == 3 {
          if valeur - montant >= 0 {
            dictCompte.updateValue(valeur - montant, forKey:compte1)
            dictCompte.updateValue(dictCompte[compte2]! + montant, forKey:compte2)
            print("Virement de \(montant) $ du compte \(compte1) au \(compte2)")
          }
        }
      }
      // virement à partir de Livret A
      if cle == compte1 && compte1 == 2 {
        if valeur - montant >= 10 {
          dictCompte.updateValue(valeur - montant, forKey:compte1)
          dictCompte.updateValue(dictCompte[compte2]! + montant, forKey:compte2)
          print("Virement de \(montant) $ du compte \(compte1) au \(compte2)")
        } else {
          dictCompte.updateValue(dictCompte[compte2]! + valeur, forKey:compte2)
          dictCompte.removeValue(forKey:compte1)
          print("Virement de \(valeur) $ car le compte à besoin de 10 $ pour rester ouvert")
          print("Compte \(compte1) cloturer\n")
        }
      }
      // virement à partir de Epargne
      if cle == compte1 && compte1 == 3 {
        dictCompte.updateValue(dictCompte[compte1]! + valeur, forKey:compte2)
        dictCompte.removeValue(forKey:compte1)
        print("Virement de \(valeur) $ car le compte à besoin de 200 $ pour rester ouvert")
        print("Compte \(compte1) cloturer\n")
      }
    }
  }

  // verifie s'il existe un compte depot dès le début
  func verifie() {
    if dictCompte.count == 0 {
      print("Creation d'un compte courant\n")
      dictCompte.updateValue(0, forKey:1)
    }
  }

  // Permet d'ouvrir un compte LivretA ou Epargne en faisant un virement depuis le compte courant
  func ouverture() -> Bool {
    let keyExists2 = dictCompte[2] != nil
    let keyExists3 = dictCompte[3] != nil
    var b = false

    // Si "N" deux fois, quitte le virement
    var count = 0

    if !keyExists2 {
      if dictCompte[1]! >= 10 {
        print("Voulez vous ouvrir un compte Livret A ? (Y/N)\n")
        let res = String(readLine()!)
        if res == "Y" {
          print("Ouverture du compte Livret A\n")
          dictCompte.updateValue(0, forKey:2)
          virement(montant:10, compte1:1, compte2:2)
          b = true
          return b
        } else {
          count += 1
        }
      }
    }

    if !keyExists3 {
      if dictCompte[1]! >= 200 {
        print("Voulez vous ouvrir un compte Epargne ? (Y/N)\n")
        let res = String(readLine()!)
        if res == "Y" {
          print("Ouverture du compte Epargne\n")
          dictCompte.updateValue(0, forKey:3)
          virement(montant:200, compte1:1, compte2:3)
          b = true
          return b
        } else {
          count += 1
        }
      }
    }
    if count == 2 {
      b = true
      return b
    }
    return b
  }

}