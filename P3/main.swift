//
//  main.swift
//  P3
//
//  Created by Sebastien Gaillard on 16/04/2021.
//

import Foundation

var charactersList = [Character]()

var charactersAliveP1 = [Character]()
var charactersAliveP2 = [Character]()

var playerPlaying = 1 // Vaut 1 ou 2. Indique à quel joueur c'est le tour.

startGame()




func startGame() {
    
    print("Bienvenue dans le jeu")
    playerChooseCharacter()
    
}

func playerChooseCharacter() {
    
    if charactersList.count < 6 { // Quand on passe à 6, les 2 joueurs ont choisi, on lance la partie
        if charactersList.count < 3 { // Dans ce cas c'est le joueur 1 qui choisi ses personnages
            print("\nLe joueur 1 choisi son personnage \(charactersList.count + 1) : \n1 - Chevalier \n2 - Archer \n3 - Sorcier \n4 - Dragon \n5 - Ninja \n6 - Squelette \n\nTapez un chiffre puis appuyez sur Entrer.")
        } else {
            print("\nLe joueur 2 choisi son personnage \(charactersList.count - 2) : \n1 - Chevalier \n2 - Archer \n3 - Sorcier \n4 - Dragon \n5 - Ninja \n6 - Squelette \n\nTapez un chiffre puis appuyez sur Entrer.")
        }
        
        let userInput = readLine()
        
        switch userInput {
        case "1":
            let characterName = setCharacterName()
            if characterName != nil {
                charactersList.append(Knight(knightName: characterName!))
                playerChooseCharacter()
            }
        case "2":
            let characterName = setCharacterName()
            if characterName != nil {
                charactersList.append(Archer(archerName: characterName!))
                playerChooseCharacter()
            }
        case "3":
            let characterName = setCharacterName()
            if characterName != nil {
                charactersList.append(Wizard(wizardName: characterName!))
                playerChooseCharacter()
            }
        case "4":
            let characterName = setCharacterName()
            if characterName != nil {
                charactersList.append(Dragon(dragonName: characterName!))
                playerChooseCharacter()
            }
        case "5":
            let characterName = setCharacterName()
            if characterName != nil {
                charactersList.append(Ninja(ninjaName: characterName!))
                playerChooseCharacter()
            }
        case "6":
            let characterName = setCharacterName()
            if characterName != nil {
                charactersList.append(Skeleton(skeletonName: characterName!))
                playerChooseCharacter()
            }
        default:
            print("\nSaisie invalide. Saisissez un chiffre entre 1 et 6.")
            playerChooseCharacter()
        }
    } else {
        startFight()
    }
    
}

func setCharacterName() -> String? {
    
    print("Veuillez saisir un nom pour votre personnage.")
    
    if let userInputName = readLine() {
        for character in charactersList {
            if userInputName == character.name {
                print("\nNom déjà utilisé, le nom doit être unique.")
                _ = setCharacterName()
            }
        }
        return userInputName
    }
    return nil
}



func startFight() {
    print("-----------------------------------------")
    print("Le combat commence ! \nJoueur 1, veux tu :\n1 - Attaquer\n2 - Soigner ?")
    
    let userInput = readLine()
    
    switch userInput {
    case "1":
        selectCharacterAttacking()
    case "2":
        heal()
    default:
        print("Saisie incorrecte. Saisissez 1 ou 2")
        startFight()
    }
    
}

func heal() {
    
}

func selectCharacterAttacking() {
    
    var index = 0
    
    updateCharactersAlive()
    
    if playerPlaying == 1 {
        print("\nLe joueur 1 choisi le personnage qui va attaquer :")
        for character in charactersAliveP1 {
            index += 1
            print("\(index) - \(character.type) : \(character.name)")
        }
        
        let userInput = readLine()
        
        switch userInput {
        case "1":
            print("\(charactersAliveP1[0].name) selected")
            selectTargetAndAttack(characterAttacking: charactersAliveP1[0], charactersAlive: charactersAliveP2)
        case "2":
            if charactersAliveP1.count > 1 {
            print("\(charactersAliveP1[1].name) selected")
                selectTargetAndAttack(characterAttacking: charactersAliveP1[1], charactersAlive: charactersAliveP2)
            } else {
                print("Saisie incorrecte, recommencez.")
                selectCharacterAttacking()
            }
        case "3":
            if charactersAliveP1.count > 2 {
            print("\(charactersAliveP1[2].name) selected")
                selectTargetAndAttack(characterAttacking: charactersAliveP1[2], charactersAlive: charactersAliveP2)
            } else {
                print("Saisie incorrecte, recommencez.")
                selectCharacterAttacking()
            }
        default:
            print("Saisie incorrecte, recommencez.")
            selectCharacterAttacking()
        }
        
        
    } else {
        print("\nLe joueur 2 choisi le personnage qui va attaquer :")
        
        for character in charactersAliveP2 {
            index += 1
            print("\(index) - \(character.type) : \(character.name)")
        }
        
        let userInput = readLine()
        
        switch userInput {
        case "1":
            print("\(charactersAliveP2[0].name) selected")
            selectTargetAndAttack(characterAttacking: charactersAliveP2[0], charactersAlive: charactersAliveP1)
        case "2":
            if charactersAliveP1.count > 1 {
            print("\(charactersAliveP2[1].name) selected")
                selectTargetAndAttack(characterAttacking: charactersAliveP2[1], charactersAlive: charactersAliveP1)
            } else {
                print("Saisie incorrecte, recommencez.")
                selectCharacterAttacking()
            }
        case "3":
            if charactersAliveP1.count > 2 {
            print("\(charactersAliveP2[2].name) selected")
                selectTargetAndAttack(characterAttacking: charactersAliveP2[2], charactersAlive: charactersAliveP1)
            } else {
                print("Saisie incorrecte, recommencez.")
                selectCharacterAttacking()
            }
        default:
            print("Saisie incorrecte, recommencez.")
            selectCharacterAttacking()
        }
        
    }
}

func selectTargetAndAttack(characterAttacking: Character, charactersAlive: [Character]) {
    
    var index = 0
    
    print("\nChoisissez le personnage qui va recevoir l'attaque : ")
    for character in charactersAlive {
        index += 1
        print("\(index) - \(character.type) : \(character.name)")
    }
    
    let userInput = readLine()
    
    switch userInput {
    case "1":
        charactersAlive[0].life -= characterAttacking.arme.degats
        print("\(characterAttacking.name) attaque \(charactersAlive[0].name) avec \(characterAttacking.arme.name) et lui inflige \(characterAttacking.arme.degats) dégâts !")
        checkIfCharacterDie(character: charactersAlive[0])
    case "2":
        if charactersAlive.count > 1 {
            charactersAlive[1].life -= characterAttacking.arme.degats
            print("\(characterAttacking.name) attaque \(charactersAlive[1].name) avec \(characterAttacking.arme.name) et lui inflige \(characterAttacking.arme.degats) dégâts !")
            checkIfCharacterDie(character: charactersAlive[1])
        } else {
            print("Saisie incorrecte, recommencez.")
            selectTargetAndAttack(characterAttacking: characterAttacking, charactersAlive: charactersAlive)
        }
    case "3":
        if charactersAlive.count > 2 {
            charactersAlive[2].life -= characterAttacking.arme.degats
            print("\(characterAttacking.name) attaque \(charactersAlive[2].name) avec \(characterAttacking.arme.name) et lui inflige \(characterAttacking.arme.degats) dégâts !")
            checkIfCharacterDie(character: charactersAlive[2])
        } else {
            print("Saisie incorrecte, recommencez.")
            selectTargetAndAttack(characterAttacking: characterAttacking, charactersAlive: charactersAlive)
        }
    default:
        print("Saisie incorrecte, recommencez.")
        selectTargetAndAttack(characterAttacking: characterAttacking, charactersAlive: charactersAlive)
    }
    
}

func checkIfCharacterDie(character: Character) {
    if playerPlaying == 1 {
        playerPlaying = 2
    } else {
        playerPlaying = 1
    }
    
    if character.life <= 0 {
        print("Le personnage \(character.type) nommé \(character.name) est mort !")
        isGameFinished() // Quand un personnage meurt on check l'état de la partie. Si une équipe est vide de personnage c'est fini
    } else {
        print("Il a maintenant \(character.life) pdv.")
        isGameFinished()
    }
    
}

func isGameFinished() {
    
    updateCharactersAlive()
    
    if charactersAliveP2.count == 0 {
        print("Tous les personnages du joueur 2 sont morts. LE JOUEUR 1 A GAGNÉ !!!")
    } else if charactersAliveP1.count == 0 {
        print("Tous les personnages du joueur 1 sont morts. LE JOUEUR 2 A GAGNÉ !!!")
    } else {
        selectCharacterAttacking()
    }
}

func updateCharactersAlive() {
    charactersAliveP1.removeAll()
    charactersAliveP2.removeAll()
    
    for character in charactersList[0..<3] {
        if character.life > 0 {
            charactersAliveP1.append(character)
        }
    }
    
    for character in charactersList[3..<6] {
        if character.life > 0 {
            charactersAliveP2.append(character)
        }
    }
}
