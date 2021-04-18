//
//  Attack.swift
//  P3
//
//  Created by Sebastien Gaillard on 18/04/2021.
//

import Foundation

func selectCharacterAttacking() {
    
    var index = 0
    
    updateArrayOfCharactersAlive()
    
    if playerPlaying == 1 {
        print("\nLe joueur 1 choisi le personnage qui va attaquer :")
        for character in charactersAliveP1 {
            index += 1
            print("\(index) - \(character.type) : \(character.name), \(character.arme.degats) dgts")
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
            print("\(index) - \(character.type) : \(character.name), \(character.arme.degats) dgts")
        }
        
        let userInput = readLine()
        
        switch userInput {
        case "1":
            print("\(charactersAliveP2[0].name) selected")
            selectTargetAndAttack(characterAttacking: charactersAliveP2[0], charactersAlive: charactersAliveP1)
        case "2":
            if charactersAliveP2.count > 1 {
                print("\(charactersAliveP2[1].name) selected")
                selectTargetAndAttack(characterAttacking: charactersAliveP2[1], charactersAlive: charactersAliveP1)
            } else {
                print("Saisie incorrecte, recommencez.")
                selectCharacterAttacking()
            }
        case "3":
            if charactersAliveP2.count > 2 {
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
        print("\(index) - \(character.type) : \(character.name), \(character.life) pdv")
    }
    
    let userInput = readLine()
    
    switch userInput {
    case "1":
        randomChest(characterAttacking: characterAttacking)
        charactersAlive[0].life -= characterAttacking.arme.degats
        print("\(characterAttacking.name) attaque \(charactersAlive[0].name) avec \(characterAttacking.arme.name) et lui inflige \(characterAttacking.arme.degats) dégâts !")
        checkIfCharacterDie(character: charactersAlive[0])
    case "2":
        if charactersAlive.count > 1 {
            randomChest(characterAttacking: characterAttacking)
            charactersAlive[1].life -= characterAttacking.arme.degats
            print("\(characterAttacking.name) attaque \(charactersAlive[1].name) avec \(characterAttacking.arme.name) et lui inflige \(characterAttacking.arme.degats) dégâts !")
            checkIfCharacterDie(character: charactersAlive[1])
        } else {
            print("Saisie incorrecte, recommencez.")
            selectTargetAndAttack(characterAttacking: characterAttacking, charactersAlive: charactersAlive)
        }
    case "3":
        if charactersAlive.count > 2 {
            randomChest(characterAttacking: characterAttacking)
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
