//
//  GameCycle.swift
//  P3
//
//  Created by Sebastien Gaillard on 21/04/2021.
//

import Foundation

var gameBrain = GameBrain()

class GameCycle {
    
    var playerPlaying = 1 // Vaut 1 ou 2. Indique à quel joueur c'est le tour.
    var numberOfTurn = 0 // Compteur pour le nombres de tours dans la partie
    
    func startGame() {
        
        print("Bienvenue dans le jeu")
        playersChooseCharacters()
    }
    
    // Cette méthode permet la selection initiale des personnages
    func playersChooseCharacters() {
        
        // Quand on passe à 6, les 2 joueurs ont choisi, on lance la partie
        if gameBrain.charactersArray.count < 6 {
            
            showSelectionState() // On affiche à qui c'est de choisir
            
            let userInput = readLine() //On récupère l'input
            
            switch userInput { // Si la saisie est valide on ajoute un Character dans le tableau des Characters
            case "1":
                gameBrain.charactersArray.append(Knight(knightName: userCharacterName()))
                playersChooseCharacters()
            case "2":
                gameBrain.charactersArray.append(Archer(archerName: userCharacterName()))
                playersChooseCharacters()
            case "3":
                gameBrain.charactersArray.append(Wizard(wizardName: userCharacterName()))
                playersChooseCharacters()
            case "4":
                gameBrain.charactersArray.append(Dragon(dragonName: userCharacterName()))
                playersChooseCharacters()
            case "5":
                gameBrain.charactersArray.append(Ninja(ninjaName: userCharacterName()))
                playersChooseCharacters()
            case "6":
                gameBrain.charactersArray.append(Skeleton(skeletonName: userCharacterName()))
                playersChooseCharacters()
            default:
                print("\nSaisie invalide. Saisissez un chiffre entre 1 et 6.")
                playersChooseCharacters()
            }
        } else { // On passe ici quand 6 personnages ont été ajouté dans le tableau charactersList
            startFight() // On démarre le combat
        }
    }
    
    // Cette méthode affiche dans la console à qui est ce de choisir
    func showSelectionState() {
        
        if gameBrain.charactersArray.count < 3 { // Dans ce cas c'est le joueur 1 qui choisi ses personnages
            print("\nLe joueur 1 choisi son personnage \(gameBrain.charactersArray.count + 1) : \n1 - Chevalier \n2 - Archer \n3 - Sorcier \n4 - Dragon \n5 - Ninja \n6 - Squelette \n\nTapez un chiffre puis appuyez sur Entrer.")
        } else {
            print("\nLe joueur 2 choisi son personnage \(gameBrain.charactersArray.count - 2) : \n1 - Chevalier \n2 - Archer \n3 - Sorcier \n4 - Dragon \n5 - Ninja \n6 - Squelette \n\nTapez un chiffre puis appuyez sur Entrer.")
        }
    }
    
    // Cette méthode renvoie un nom unique. (Elle est récursive tant que le nom saisi n'est pas unique)
    func userCharacterName() -> String {
        
        print("Veuillez saisir un nom pour votre personnage.")
        var userInputName = readLine() ?? ""
        
        // On check si le nom n'est pas vide
        let userIsEmpty = userInputName.trimmingCharacters(in: .whitespacesAndNewlines)
        if userIsEmpty.isEmpty {
            print("Vous n'avez pas saisi de nom !")
            userInputName = userCharacterName()
        }
        
        for character in gameBrain.charactersArray { // On parcourt chaque objet du tableau charactersList
            if userInputName == character.name { // Si le nom saisi par l'utilisateur se trouve déjà dans la propriété d'un des objets existant, c'est true
                print("\n'\(userInputName)' déjà utilisé, le nom doit être unique.") // On averti l'utilisateur
                userInputName = userCharacterName() // On rappelle cette même méthode pourqu'il resaisisse un nom
            }
        }
        
        return userInputName // On return le nom choisi par l'utilisateur s'il est unique
    }
    
    // Cette méthode informe que le combat commence et lance le 1er tour
    func startFight() {
        
        print("----------------------------------------------------------------------")
        print("Le combat commence !")
        nextTurn()
    }
    
    // Cette méthode est appelée à chaque nouveau tour. En fonction du choix du joueur à qui c'est le tour, elle appelle la méthode d'attaque ou de soin.
    // Elle incrémente aussi le compteur de tours
    func nextTurn() {
        
        print("\nJoueur \(playerPlaying), veux tu :\n1 - Attaquer\n2 - Soigner")
        
        let userInput = readLine()
        
        switch userInput {
        case "1":
            numberOfTurn += 1
            gameBrain.userChooseAttacker()
        case "2":
            numberOfTurn += 1
            gameBrain.selectCharacterHealing()
        default:
            print("Saisie incorrecte. Saisissez 1 ou 2")
            nextTurn()
        }
    }
    
    // Cette méthode est appelée à la fin d'un tour. Soit elle détecte qu'un des joueurs à tous ses personnages de mort et appelle la méthode de fin de partie
    // Soit elle change la valeur de la variable 'joueur à qui c'est le tour'
    func endOfTurn() {
        
        // Si un des deux joueurs à tous ses personnages de mort, c'est la fin de la partie et on appelle la méthode appropriée
        if gameBrain.getCharactersAliveP2().count == 0 {
            print("\nTous les personnages du joueur 2 sont morts. LE JOUEUR 1 A GAGNÉ !!!")
            gameEnded()
        } else if gameBrain.getCharactersAliveP1().count == 0 {
            print("\nTous les personnages du joueur 1 sont morts. LE JOUEUR 2 A GAGNÉ !!!")
            gameEnded()
        } else {
            
            // Sinon on change tout simplement le joueur actuel et on lance un nouveau tour
            playerPlaying = playerPlaying == 1 ? 2 : 1
            nextTurn()
        }
    }
    
    // Cette méthode est appelée à la fin d'une partie. Elle affiche le compte rendu de la partie
    func gameEnded() {
        
        print("/n/n-----------------------------------------------------------------------")
        print("Compte rendu de la partie :")
        print("La partie c'est terminée en \(numberOfTurn) tours.") // On affiche le nombre total de tours
        print("Voici l'état des personnages :\n\nJoueur 1 :")
        
        // Cette boucle for affiche chacun des personnages du joueurs 1, mort ou vivant. S'ils sont vivants, les pdv sont affichés
        for character in gameBrain.charactersArray[0..<3] {
            if character.life <= 0 {
                character.life = 0
                print("\(character.type) : \(character.name) \(character.life) pdv")
            } else {
                print("\(character.type) : \(character.name) est resté vivant avec \(character.life) pdv !")
            }
        }
        
        // Cette boucle for affiche chacun des personnages du joueurs 2, mort ou vivant. S'ils sont vivants, les pdv sont affichés
        print("\nJoueur 2 :")
        for character in gameBrain.charactersArray[3..<6] {
            if character.life <= 0 {
                character.life = 0
                print("\(character.type) : \(character.name) \(character.life) pdv")
            } else {
                print("\(character.type) : \(character.name) est resté vivant avec \(character.life) pdv !")
            }
        }
    }
}
