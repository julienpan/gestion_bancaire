class Clients {
  var nom : (String)
  var prenom : (String)
  // Numéro de rue, nom de rue, département
  var adresse : (String)
  var numero : (Int)

  init(nom:String, prenom:String, adresse:String, numero:Int) {

    self.nom = nom
    self.prenom = prenom
    self.adresse = adresse
    self.numero = numero
  }

  var getSetNom : String {
    get {
      return self.nom
    }
    set(nom) {
      self.nom = nom
    }
  }
  var getSetPrenom : String {
    get {
      return self.prenom
    }
    set(prenom) {
      self.prenom = prenom
    }
  }
  var getSetAdresse : String {
    get {
      return self.adresse
    }
    set(adresse) {
      self.adresse = adresse
    }
  }
  var getSetNumero : Int {
    get {
      return self.numero
    }
    set(numero) {
      self.numero = numero
    }
  }
}


