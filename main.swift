// Contient la liste des comptes client
var tabComptes = [Comptes]()
// Un compte basique (1:Courant, 2:LivretA, 3:Epargne)
var compte = [Int:Double]()
// Numero de compte du premier client

// Creation d'un compte client et l'ajoute dans la liste
func createComptes() {

  var b = true

  print("Entrez votre nom")
  let n = String(readLine()!)
  print("Entrez votre prénom")
  let p = String(readLine()!)
  print("Entrez votre adresse (Numéro de rue, nom de rue, département)")
  let a = String(readLine()!)
  print("Entrez votre numéro de téléphone")
  let num = Int(readLine()!)!

  for i in tabComptes {
    if n == i.nom && p == i.prenom && a == i.adresse && num == i.numero {
      print("Le compte existe déja")
      b = false
    }
  }
  if b == true {
    let nc = tabComptes.count + 1
    let c = Comptes(nom:n, prenom:p, adresse:a,numero:num, dictCompte:compte, numCompte:nc)
    tabComptes.append(c)
    print("Votre numéro de compte est \(nc)\n")
  }
}

// Cloturer un compte client 
func delete() {

    var count = 0

    print("Entrez le nom\n")
    let n = String(readLine()!)
    print("Entrez le prénom\n")
    let p = String(readLine()!)
    print("Entrez l'adresse (Numéro de rue, nom de rue, département)\n")
    let a = String(readLine()!)
    print("Entrez le numéro de téléphone\n")
    let num = Int(readLine()!)!

    for i in tabComptes {
      if n == i.nom && p == i.prenom && a == i.adresse && num == i.numero {
        print("Compte supprimer : \(i)\n")
        tabComptes.remove(at:count)
      } else {
        print("Compte introuvable.\n")
      }
      count += 1
    }
}

// Modifier l'adresse ou le numero de telephone du client
func modifier() {

  print("Entrez le nom\n")
  let n = String(readLine()!)
  print("Entrez le prénom\n")
  let p = String(readLine()!)
  print("Entrez l'adresse (Numéro de rue, nom de rue, département)\n")
  let a = String(readLine()!)
  print("Entrez le numéro de téléphone\n")
  let num = Int(readLine()!)!

  for i in tabComptes {
    if n == i.nom && p == i.prenom && a == i.adresse && num == i.numero {
      print("Voulez vous modifier l'adresse (1) ou le numero de telephone (2) ?\n")
      let res = Int(readLine()!)!
      if res == 1 {
        print("Entrer la nouvelle adresse (Numéro de rue, nom de rue, département)")
        let mod = String(readLine()!)
        i.adresse = mod
      } else {
        print("Entrer le nouveau numero de telephone")
        let mod = Int(readLine()!)!
        i.numero = mod
      }
    } else {
      print("Les identifiants sont incorrectes")
    }
  }
}

// Les actions du client
func cli(c:Comptes) {

  print("depot      : Deposer de l'argent")
  print("retirer    : Retirer de l'argent")
  print("afficher   : Affiche son solde")
  print("affichern  : Affiche son numero de compte")
  print("ouverture  : Ouvrir un compte Livret A ou Epargne")
  print("virement   : Faire des virements")
  print("virementc  : Faire un virement à un autre client")
  print("conseiller : Passer en conseiller")
  print("q          : Quittez\n")

  let choix = String(readLine()!)

  switch choix {

    case "depot"      :   // permet de verifier s'il existe un compte depot, sinon elle le cree
                          c.verifie()
                          print("Entrer le montant à deposer : \n")
                          let s = Double(readLine()!)!
                          c.depot(montant:s)
                          // Des que l'action est fini retourne sur les actions possibles
                          return cli(c:c)

    case "afficher"   :   c.affiche()
                          return cli(c:c)

    case "affichern"  :   c.affichen()
                          return cli(c:c)

    case "retirer"    :   c.verifie()
                          if c.dictCompte[1] == 0 {
                            print("Impossible de retirer dans un compte vide, deposer de l'argent d'abord")
                            return cli(c:c)
                          } else {
                              print("Entrer le montant a retirer")
                              let s = Double(readLine()!)!
                              c.retirer(montant:s)
                          }
                          return cli(c:c)

    case "ouverture"  :   c.verifie()
                          if c.dictCompte[1] == 0 {
                            print("Impossible d'ouvrir un compte sans argent dans le compte courant")
                            return cli(c:c)
                          } else {
                              if c.ouverture() == true {
                                return cli(c:c)
                              } else {
                                print("Erreur d'ouverture")
                                return cli(c:c)
                              }
                          }
                        
    case "virement"   :   c.verifie()
                          if c.dictCompte[1] == 0 {
                            print("Aucune action de virement possible")
                            return cli(c:c)
                          }
                          if c.ouverture() == false {
                            c.affiche()
                            print("Entrez le compte source et le compte destination (1, 2, 3) et (4) pour retour\n")
                            let c1 = Int(readLine()!)!
                            // Si la premiere entree est 4, on fait retour
                            if c1 == 4 {
                              return cli(c:c)
                            }
                            let c2 = Int(readLine()!)!
                            print("Entrez le montant du virement\n")
                            let m = Double(readLine()!)!
                            c.virement(montant:m, compte1:c1, compte2:c2)
                            return cli(c:c)
                          } else {
                            return cli(c:c)
                          }
    case "virementc"  :   c.verifie()
                          if c.dictCompte[1]! != 0 {
                            print("Entrer la somme du virement")
                            let m = Double(readLine()!)!
                            print("Entrer le numero de compte du client")
                            let nc = Int(readLine()!)!
                            print("Entrer le nom de la personne")
                            let n = String(readLine()!)
                            print("Entrer le prenom de la personne")
                            let p = String(readLine()!)
                            for i in tabComptes {
                              if i.numCompte == nc && i.nom == n && i.prenom == p {
                                if i.dictCompte.count == 1 {
                                  print("Virement de \(m) $ au client \(nc)\n")
                                  c.retirer(montant:m)
                                  i.depot(montant:m)
                                } else {
                                  print("Le client ne possède pas encore de compte courant ouvert\n")
                                }  
                              }
                            }
                          }
                          return cli(c:c)

    case "conseiller" :   return conseiller()

    case "q"          :   break

    default           :   print("Commande non reconnue\n")
                          return cli(c:c)
  }
}

// Les actions du conseiller
func conseiller() {

  print("creer      : Creer un compte client")
  print("connexion  : Se connceter à un compte")
  print("cloturer   : Cloturer un compte client")
  print("afficher   : Affiche la liste des comptes client")
  print("modifier   : Modifier l'adresse ou le numero de telephone")
  print("q          : Quittez\n")

  let choix = String(readLine()!)

  switch choix {
    case "creer"     :  createComptes()
                        return conseiller()

    case "connexion" :  print("Entrez les donnees personnelles : ") 
                        print("Entrez votre nom")
                        let n = String(readLine()!)
                        print("Entrez votre prénom")
                        let p = String(readLine()!)
                        print("Entrez votre numéro de téléphone")
                        let num = Int(readLine()!)!

                        for i in tabComptes {
                          if n == i.nom && p == i.prenom && num == i.numero {
                            print("Compte trouve\n")
                            return cli(c:i)
                          }        
                        }
                        print("Compte introuvable, voici la liste : \(tabComptes)\n")
                        return conseiller()

    case "cloturer" :   delete()
                        return conseiller()

    case "afficher" :   print(tabComptes) 
                        return conseiller()

    case "modifier" :   modifier()
                        return conseiller()

    case "q"        :   break

    default         :   print("La commande entree n'existe pas\n")
                        return conseiller()
  }
}

// Le programme commence avec le conseiller
conseiller()