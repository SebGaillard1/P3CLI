//
//  GameBrain.swift
//  P3
//
//  Created by Sebastien Gaillard on 21/04/2021.
//

import Foundation

class GameBrain {
    
    var charactersArray = [Character]() // Ce tableau se remplit a chaque fois qu'un joueur choisi un personnage. (Il contiendra donc 6 'Character' à la fin de la sélection)

    // Cette méthode renvoi le tableau des personnages encore en vie du joueur 1
    func getCharactersAliveP1() -> [Character] {
        return gameBrain.charactersArray[0..<3].filter { (c) -> Bool in
            c.life > 0
        }
    }
    
    // Cette méthode renvoi le tableau des personnages encore en vie du joueur 2
    func getCharactersAliveP2() -> [Character] {
        return gameBrain.charactersArray[3..<6].filter { (c) -> Bool in
            c.life > 0
        }
    }
    
    //MARK: - Partie Attaque
    
    // Cette méthode affiche à l'utilisateur les personnages en vie, parmi lesquels il choisi le personnage qui va attaquer
    func userChooseAttacker() {
        
        var index = 0 // Le chiffre qui s'affiche dans la console permettant le choix du personnage
        var charsAliveAttacking = [Character]() // Tableau des personnages encore en vie du joueur qui attaque
        var charsAliveAttacked = [Character]() // Tableau des personnages encore en vie du joueur qui subit l'attaque
                
        if gameCycle.playerPlaying == 1 { // En fonction du joueur à qui s'est le tour, j'attribue telle ou telle liste de personnages
            charsAliveAttacking = getCharactersAliveP1()
            charsAliveAttacked = getCharactersAliveP2()
        } else {
            charsAliveAttacking = getCharactersAliveP2()
            charsAliveAttacked = getCharactersAliveP1()
        }
        
        print("\nLe joueur \(gameCycle.playerPlaying) choisi le personnage qui va attaquer :")
        
        // Ici boucle for pour afficher la liste de personnages qui peuvent attaquer avec leurs infos utiles
        for character in charsAliveAttacking {
            index += 1
            print("\(index) - \(character.type) : \(character.name), \(character.weapon.degats) dgts")
        }
        
        let userInput = readLine() // On récupère la saisie de l'utilisateur
        
        switch userInput {
        case "1":
            print("\(charsAliveAttacking[0].name) selectionné") // On avertit l'utilisateur du personnage selectionné
            userChooseTarget(characterAttacking: charsAliveAttacking[0], ennemyCharactersAlive: charsAliveAttacked)
        case "2":
            if charsAliveAttacking.count > 1 { // Les cas 2 et 3 nécessitent le check d'une condition : y a t il 2 ou 3 personnages ?
                print("\(charsAliveAttacking[1].name) selectionné")
                userChooseTarget(characterAttacking: charsAliveAttacking[1], ennemyCharactersAlive: charsAliveAttacked)
            } else { // S'il n'y a qu'un seul personnage encore en vie et que l'utilisateur saisi '2', c'est une saisie invalide
                print("Saisie incorrecte, recommencez.")
                userChooseAttacker()
            }
        case "3":
            if charsAliveAttacking.count > 2 {
                print("\(charsAliveAttacking[2].name) selectionné")
                userChooseTarget(characterAttacking: charsAliveAttacking[2], ennemyCharactersAlive: charsAliveAttacked)
            } else {
                print("Saisie incorrecte, recommencez.")
                userChooseAttacker()
            }
        default: // Si l'utilisateur choisi autre chose que '1'/'2'/'3', c'est forcément une saisie invalide, il doit donc saisir à nouveau
            print("Saisie incorrecte, recommencez.")
            userChooseAttacker()
        }
    }
    
    // Cette méthode affiche dans la console les personnages encore en vie de l'équipe adverse et permet la sélection du personnage à attaquer (elle appelle aussi la méthode attack)
    func userChooseTarget(characterAttacking: Character, ennemyCharactersAlive: [Character]) {
        
        var index = 0 // Le chiffre qui s'affiche dans la console permettant le choix du personnage
        
        // On affiche la liste des personnages encore en vie qui peuvent subir une attaque.
        print("\nChoisissez le personnage qui va recevoir l'attaque : ")
        for character in ennemyCharactersAlive {
            index += 1
            print("\(index) - \(character.type) : \(character.name), \(character.life) pdv")
        }
        
        let userInput = readLine() // On récupère l'entrée utilisateur
        
        switch userInput {
        case "1":
            attack(with: characterAttacking, in: ennemyCharactersAlive, index: userInput!)
        case "2":
            if ennemyCharactersAlive.count > 1 {
                attack(with: characterAttacking, in: ennemyCharactersAlive, index: userInput!)
            } else {
                print("Saisie incorrecte, recommencez.")
                attack(with: characterAttacking, in: ennemyCharactersAlive, index: userInput!)
            }
        case "3":
            if ennemyCharactersAlive.count > 2 {
                attack(with: characterAttacking, in: ennemyCharactersAlive, index: userInput!)
            } else {
                print("Saisie incorrecte, recommencez.")
                userChooseTarget(characterAttacking: characterAttacking, ennemyCharactersAlive: ennemyCharactersAlive)
            }
        default:
            print("Saisie incorrecte, recommencez.")
            userChooseTarget(characterAttacking: characterAttacking, ennemyCharactersAlive: ennemyCharactersAlive)
        }
    }
    
    // Cette méthode réalise l'attaque
    func attack(with characterAttacking: Character, in charactersAlive: [Character], index userInput: String) {
        
        let index = Int(userInput)! - 1 // Index de la cible dans le tableau de personnages vivants du joueur ennemi
        randomChest(characterAttacking: characterAttacking) // On fait apparaitre ou non un coffre avant d'attaquer
        
        charactersAlive[index].life -= characterAttacking.weapon.degats // On applique les dégats au personnage attaqué
        print("\(characterAttacking.name) attaque \(charactersAlive[index].name) avec \(characterAttacking.weapon.name) et lui inflige \(characterAttacking.weapon.degats) dégâts !")
        checkIfCharacterDie(character: charactersAlive[index]) // On regarde si le personnage est mort ou non
    }
    
    // Cette méthode check si le personnage qui vient d'être attaqué est mort et agit en fonction
    func checkIfCharacterDie(character: Character) {
        
        if character.life <= 0 { // Si le personnage qui vient de subir l'attaque à 0 pdv ou moins c'est qu'il est mort.
            print("\nLe personnage \(character.type) nommé \(character.name) est mort !")
            gameCycle.endOfTurn()
        } else {
            print("Il lui reste \(character.life) pdv.") // Sinon il est encore vivant. On informe les joueurs des pdv restants
            gameCycle.endOfTurn() // Puis c'est la fin du tour
        }
    }
    
    //MARK: - Partie soin
    
    // Cette méthode est appelée quand le joueur choisi de soigner. Elle permet la selection du joueur qui fait le soin
    func selectCharacterHealing() {
        
        var index = 0
        var charAliveHeal = [Character]() // Tableau des personnages du joueur pour le heal
        
        
        if gameCycle.playerPlaying == 1 {
            charAliveHeal = getCharactersAliveP1()
        } else {
            charAliveHeal = getCharactersAliveP2()
        }
        
        print("\nLe joueur \(gameCycle.playerPlaying) choisi le personnage qui va soigner :")
        
        for character in charAliveHeal {
            index += 1
            print("\(index) - \(character.type) : \(character.name), \(character.heal) soin")
        }
        
        let userInput = readLine()
        
        switch userInput {
        case "1":
            print("\(charAliveHeal[0].name) selected")
            selectTargetAndHeal(characterHealing: charAliveHeal[0], charactersAlive: charAliveHeal)
        case "2":
            if charAliveHeal.count > 1 {
                print("\(charAliveHeal[1].name) selected")
                selectTargetAndHeal(characterHealing: charAliveHeal[1], charactersAlive: charAliveHeal)
            } else {
                print("Saisie incorrecte, recommencez.")
                selectCharacterHealing()
            }
        case "3":
            if charAliveHeal.count > 2 {
                print("\(charAliveHeal[2].name) selected")
                selectTargetAndHeal(characterHealing: charAliveHeal[2], charactersAlive: charAliveHeal)
            } else {
                print("Saisie incorrecte, recommencez.")
                selectCharacterHealing()
            }
        default:
            print("Saisie incorrecte, recommencez.")
            selectCharacterHealing()
        }
    }
    
    // Cette méthode permet la selection du personnage qui recoit le soin et effectue le soin
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
            gameCycle.endOfTurn()
        case "2":
            if charactersAlive.count > 1 {
                charactersAlive[1].life += characterHealing.heal
                print("\(characterHealing.name) soigne \(charactersAlive[1].name) de \(characterHealing.heal) pdv. Il a désormais \(charactersAlive[1].life) pdv")
                gameCycle.endOfTurn()
            } else {
                print("Saisie incorrecte, recommencez.")
                selectTargetAndHeal(characterHealing: characterHealing, charactersAlive: charactersAlive)
            }
        case "3":
            if charactersAlive.count > 2 {
                charactersAlive[2].life += characterHealing.heal
                print("\(characterHealing.name) soigne \(charactersAlive[2].name) de \(characterHealing.heal) pdv. Il a désormais \(charactersAlive[2].life) pdv")
                gameCycle.endOfTurn()
            } else {
                print("Saisie incorrecte, recommencez.")
                selectTargetAndHeal(characterHealing: characterHealing, charactersAlive: charactersAlive)
            }
        default:
            print("Saisie incorrecte, recommencez.")
            selectTargetAndHeal(characterHealing: characterHealing, charactersAlive: charactersAlive)
        }
        
    }
    
    //MARK: - Partie coffre
    
    // Cette méthode fait apparaitre ou non un coffre et change l'arme du personnage
    func randomChest(characterAttacking: Character) {
        
        let randomInt = Int.random(in: 0...99) // Génère un chiffre aléatoire entre 0 et 99
        switch randomInt {
        case 0..<5:
            characterAttacking.weapon = Weapon(name: "Épée légendaire", degats: 50)
            print("\nIncroyable, un coffre vient d'apparaître devant vous. Il contient une arme très rare : une épée légendaire !")
        case 5..<15:
            characterAttacking.weapon = Weapon(name: "Bâton magique", degats: 40)
            print("\nSuperbe, un coffre vient d'apparaître devant vous. Il contient une arme rare, un bâton magique !")
        case 15..<30:
            characterAttacking.weapon = Weapon(name: "Marteau", degats: 30)
            print("\nUn coffre vient d'apparaître devant vous, il contient un marteau !")
        case 30..<35:
            characterAttacking.weapon = Weapon(name: "Canne à pêche", degats: 10)
            print("\nUn coffre vient d'apparaître devant vous mais son contenu risque de vous déplaire... Il contient une canne à pêche !")
        default:
            () // On ne fait rien
        }
    }

}
