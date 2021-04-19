//
//  main.swift
//  P3
//
//  Created by Sebastien Gaillard on 16/04/2021.
//

import Foundation

var charactersArray = [Character]() // Tableau de l'ensemble des personnages (6)

var charactersAliveP1 = [Character]() // Tableau contenant les perso du joueur 1 qui ont health > 0 (vivants)
var charactersAliveP2 = [Character]()

var playerPlaying = 1 // Vaut 1 ou 2. Indique à quel joueur c'est le tour.

var numberOfTurn = 0 // Compteur pour le nombres de tours dans la partie


startGame()




func startGame() {
    
    print("Bienvenue dans le jeu")
    playersChooseCharacters()
    
}

func playersChooseCharacters() {
    
    if charactersArray.count < 6 { // Quand on passe à 6, les 2 joueurs ont choisi, on lance la partie
        if charactersArray.count < 3 { // Dans ce cas c'est le joueur 1 qui choisi ses personnages
            print("\nLe joueur 1 choisi son personnage \(charactersArray.count + 1) : \n1 - Chevalier \n2 - Archer \n3 - Sorcier \n4 - Dragon \n5 - Ninja \n6 - Squelette \n\nTapez un chiffre puis appuyez sur Entrer.")
        } else {
            print("\nLe joueur 2 choisi son personnage \(charactersArray.count - 2) : \n1 - Chevalier \n2 - Archer \n3 - Sorcier \n4 - Dragon \n5 - Ninja \n6 - Squelette \n\nTapez un chiffre puis appuyez sur Entrer.")
        }
        
        let userInput = readLine() //On récupère l'input
        
        switch userInput {
        case "1":
            let characterName = setCharacterName()
            if characterName != nil {
                charactersArray.append(Knight(knightName: characterName!))
                playersChooseCharacters()
            }
        case "2":
            let characterName = setCharacterName()
            if characterName != nil {
                charactersArray.append(Archer(archerName: characterName!))
                playersChooseCharacters()
            }
        case "3":
            let characterName = setCharacterName()
            if characterName != nil {
                charactersArray.append(Wizard(wizardName: characterName!))
                playersChooseCharacters()
            }
        case "4":
            let characterName = setCharacterName()
            if characterName != nil {
                charactersArray.append(Dragon(dragonName: characterName!))
                playersChooseCharacters()
            }
        case "5":
            let characterName = setCharacterName()
            if characterName != nil {
                charactersArray.append(Ninja(ninjaName: characterName!))
                playersChooseCharacters()
            }
        case "6":
            let characterName = setCharacterName()
            if characterName != nil {
                charactersArray.append(Skeleton(skeletonName: characterName!))
                playersChooseCharacters()
            }
        default:
            print("\nSaisie invalide. Saisissez un chiffre entre 1 et 6.")
            playersChooseCharacters()
        }
    } else { // On passe ici quand 6 personnages ont été ajouté dans le tableau charactersList
        startFight() // On démarre le combat
    }
    
}

func setCharacterName() -> String? {
    
    print("Veuillez saisir un nom pour votre personnage.")
    
    if let userInputName = readLine() {
        for character in charactersArray { // On parcourt chaque objet du tableau charactersList
            if userInputName == character.name { // Si le nom saisi par l'utilisateur se trouve déjà dans la propriété d'un des objets existant, c'est true
                print("\nNom déjà utilisé, le nom doit être unique.") // On averti l'utilisateur
                _ = setCharacterName() // On rappelle cette même fonction pourqu'il resaisisse un nom
            }
        }
        return userInputName // On return le nom choisi par l'utilisateur s'il est unique
    }
    return nil
}



func startFight() {
    
    print("----------------------------------------------------------------------")
    print("Le combat commence !")
    nextTurn()

}

func nextTurn() {
    
    print("\nJoueur \(playerPlaying), veux tu :\n1 - Attaquer\n2 - Soigner")
    
    let userInput = readLine()
    
    switch userInput {
    case "1":
        numberOfTurn += 1
        selectCharacterAttacking()
    case "2":
        numberOfTurn += 1
        selectCharacterHealing()
    default:
        print("Saisie incorrecte. Saisissez 1 ou 2")
        nextTurn()
    }
}





func checkIfCharacterDie(character: Character) {

    if character.life <= 0 {
        print("\nLe personnage \(character.type) nommé \(character.name) est mort !")
        endOfTurn()
    } else {
        print("Il lui reste \(character.life) pdv.")
        endOfTurn()
    }
    
}

func endOfTurn() {
    
    updateArrayOfCharactersAlive()
    
    if charactersAliveP2.count == 0 {
        print("\nTous les personnages du joueur 2 sont morts. LE JOUEUR 1 A GAGNÉ !!!")
        gameEnded()
    } else if charactersAliveP1.count == 0 {
        print("\nTous les personnages du joueur 1 sont morts. LE JOUEUR 2 A GAGNÉ !!!")
        gameEnded()
    } else {
        if playerPlaying == 1 {
            playerPlaying = 2
        } else {
            playerPlaying = 1
        }
        
        nextTurn()
    }
    
}

func updateArrayOfCharactersAlive() {
    
    charactersAliveP1.removeAll()
    charactersAliveP2.removeAll()
    
    for character in charactersArray[0..<3] {
        if character.life > 0 {
            charactersAliveP1.append(character)
        }
    }
    
    for character in charactersArray[3..<6] {
        if character.life > 0 {
            charactersAliveP2.append(character)
        }
    }
    
}

func randomChest(characterAttacking: Character) {
    
    let randomInt = Int.random(in: 0...100)
    switch randomInt {
    case 0..<5:
        characterAttacking.arme = Weapon(name: "Épée légendaire", degats: 50)
        print("Incroyable, un coffre vient d'apparaître devant vous. Il contient une arme très rare !")
    case 5..<15:
        characterAttacking.arme = Weapon(name: "Bâton magique", degats: 40)
        print("Superbe, un coffre vient d'apparaître devant vous. Il contient une arme rare !")
    case 15..<30:
        characterAttacking.arme = Weapon(name: "Marteau", degats: 30)
        print("Un coffre vient d'apparaître devant vous !")
    case 30..<35:
        characterAttacking.arme = Weapon(name: "Canne à pêche", degats: 10)
        print("Un coffre vient d'apparaître devant vous mais son contenu risque de vous déplaire... !")
    default:
        () // On ne fait rien
    }
}

func gameEnded() {
    print("/n/n-----------------------------------------------------------------------")
    print("Compte rendu de la partie :")
    print("La partie c'est terminée en \(numberOfTurn) tours.")
    print("Voici l'état des personnages :\n\nJoueur 1 :")
    
    for character in charactersArray[0..<3] {
        if character.life <= 0 {
            character.life = 0
            print("\(character.type) : \(character.name) \(character.life) pdv")
        } else {
            print("\(character.type) : \(character.name) est resté vivant avec \(character.life) pdv !")
        }
        
    }
    
    print("\nJoueur 2 :")
    for character in charactersArray[3..<6] {
        if character.life <= 0 {
            character.life = 0
            print("\(character.type) : \(character.name) \(character.life) pdv")
        } else {
            print("\(character.type) : \(character.name) est resté vivant avec \(character.life) pdv !")
        }
    }
}
