//
//  Heal.swift
//  P3
//
//  Created by Sebastien Gaillard on 18/04/2021.
//

import Foundation


func selectCharacterHealing() {
    
    var index = 0
    updateArrayOfCharactersAlive()
    
    if playerPlaying == 1 {
        print("\nLe joueur 1 choisi le personnage qui va soigner :")
        for character in charactersAliveP1 {
            index += 1
            print("\(index) - \(character.type) : \(character.name), \(character.life) pdv")
        }
        let userInput = readLine()
        
        switch userInput {
        case "1":
            print("\(charactersAliveP1[0].name) selected")
            selectTargetAndHeal(characterHealing: charactersAliveP1[0], charactersAlive: charactersAliveP1)
        case "2":
            if charactersAliveP1.count > 1 {
                print("\(charactersAliveP1[1].name) selected")
                selectTargetAndHeal(characterHealing: charactersAliveP1[1], charactersAlive: charactersAliveP1)
            } else {
                print("Saisie incorrecte, recommencez.")
                selectCharacterHealing()
            }
        case "3":
            if charactersAliveP1.count > 2 {
                print("\(charactersAliveP1[2].name) selected")
                selectTargetAndHeal(characterHealing: charactersAliveP1[2], charactersAlive: charactersAliveP1)
            } else {
                print("Saisie incorrecte, recommencez.")
                selectCharacterHealing()
            }
        default:
            print("Saisie incorrecte, recommencez.")
            selectCharacterHealing()
        }
        
        
    } else {
        print("\nLe joueur 2 choisi le personnage qui va soigner :")
        
        for character in charactersAliveP2 {
            index += 1
            print("\(index) - \(character.type) : \(character.name), \(character.life) pdv")
        }
        
        let userInput = readLine()
        
        switch userInput {
        case "1":
            print("\(charactersAliveP2[0].name) selected")
            selectTargetAndHeal(characterHealing: charactersAliveP2[0], charactersAlive: charactersAliveP2)
        case "2":
            if charactersAliveP2.count > 1 {
                print("\(charactersAliveP2[1].name) selected")
                selectTargetAndHeal(characterHealing: charactersAliveP2[1], charactersAlive: charactersAliveP2)
            } else {
                print("Saisie incorrecte, recommencez.")
                selectCharacterHealing()
            }
        case "3":
            if charactersAliveP2.count > 2 {
                print("\(charactersAliveP2[2].name) selected")
                selectTargetAndHeal(characterHealing: charactersAliveP2[2], charactersAlive: charactersAliveP2)
            } else {
                print("Saisie incorrecte, recommencez.")
                selectCharacterHealing()
            }
        default:
            print("Saisie incorrecte, recommencez.")
            selectCharacterHealing()
        }
        
    }
}


func selectTargetAndHeal(characterHealing: Character, charactersAlive: [Character]) {
    
    var index = 0
    
    print("\nChoisissez le personnage qui va recevoir le soin : ")
    for character in charactersAlive {
        index += 1
        print("\(index) - \(character.type) : \(character.name), \(character.life) pdv")
    }
    
    let userInput = readLine()
    
    switch userInput {
    case "1":
        charactersAlive[0].life += characterHealing.heal
        print("\(characterHealing.name) soigne \(charactersAlive[0].name) de \(characterHealing.heal) pdv. Il a désormais \(charactersAlive[0].life) pdv")
        endOfTurn()
    case "2":
        if charactersAlive.count > 1 {
            charactersAlive[1].life += characterHealing.heal
            print("\(characterHealing.name) soigne \(charactersAlive[1].name) de \(characterHealing.heal) pdv. Il a désormais \(charactersAlive[1].life) pdv")
            endOfTurn()
        } else {
            print("Saisie incorrecte, recommencez.")
            selectTargetAndHeal(characterHealing: characterHealing, charactersAlive: charactersAlive)
        }
    case "3":
        if charactersAlive.count > 2 {
            charactersAlive[2].life += characterHealing.heal
            print("\(characterHealing.name) soigne \(charactersAlive[2].name) de \(characterHealing.heal) pdv. Il a désormais \(charactersAlive[2].life) pdv")
            endOfTurn()
        } else {
            print("Saisie incorrecte, recommencez.")
            selectTargetAndHeal(characterHealing: characterHealing, charactersAlive: charactersAlive)
        }
    default:
        print("Saisie incorrecte, recommencez.")
        selectTargetAndHeal(characterHealing: characterHealing, charactersAlive: charactersAlive)
    }
    
}

