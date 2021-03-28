# Projet : Gestion de comptes bancaires - Swift

Écrire une application qui modélise partiellement la gestion de comptes bancaires.
La gestion de la banque est effectuée par un conseiller (à savoir vous) qui peut gérer
des clients (ouverture de compte pour un client et clôture de compte pour une client).
Un Client : Est défini par un nom, prénom, une adresse (numéro de rue, nom de rue
et département), numéro de téléphone et il peut contenir 3 comptes qui se définissent
comme suit :

1. Compte courant :
  ✓ On peut y déposer de l’argent
  ✓ On peut y retirer sans découvert (Il est interdit d’avoir une somme négative
dans le compte)
  ✓ Afficher le solde
2. Compte LivretA :
  ✓ On peut faire un virement depuis et vers le compte courant et le compte
  épargne 
  ✓ On ne pas retirer d’argent sans passer par le compte courant
  ✓ Le compte doit avoir au minimum 10 euros sinon il sera clôturé

3. Compte épargne :
• Le compte doit à l’ouverture avoir 200 euros minimum
• On peut faire un virement depuis le compte courant et le compte livretA 
• Si on fait un virement vers les autres comptes, on vire la somme totale ce qui
clôture le compte.

Le programme devra permettre :
• De se connecter en qualité de conseiller ou de client.
• Permettre Au conseiller :
  a. De se connecter en se présentant en tant que conseiller
  b. D’ouvrir un compte à un nouveau client en saisissant les données
  personnelles du client en s’assurant qu’il n’existe pas dans la banque si ce
  dernier lister les différents comptes qu’il contient.
  c. De clôturer un compte à la demande d’un client (la clôture est irréversible) .
  D’afficher l’ensemble des clients de la banque
  e. De modifier en mettant à jour uniquement l’adresse ou le numéro de
  téléphone du client

Le programme devra permettre au client selon son choix de :
  a. De connecter à son espace personnel en entrant son nom, prénom et numéro
  de téléphone
  b. Déposer une somme sur son compte
  c. Retirer une somme d’argent de son compte
  d. Afficher son solde
  e. Effectuer des virements entre ses différents comptes.
