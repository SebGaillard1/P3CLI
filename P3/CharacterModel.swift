//
//  CharacterModel.swift
//  P3
//
//  Created by Sebastien Gaillard on 16/04/2021.
//

import Foundation

class Character {
    
    var life: Int
    var name: String
    var weapon: Weapon
    var type: Type
    var heal: Int
    
    init(life: Int, name: String, arme: Weapon, type: Type, heal: Int) {
        self.life = life
        self.name = name
        self.weapon = arme
        self.type = type
        self.heal = heal
    }
    
}

class Knight: Character {
    init(knightName: String) {
        super.init(life: 100, name: knightName, arme: Weapon.init(name: "Épée", degats: 20), type: .Knight, heal: 10)
    }
}

class Archer: Character {
    init(archerName: String) {
        super.init(life: 90, name: archerName, arme: Weapon.init(name: "Flêches", degats: 22), type: .Archer, heal: 10)
    }
}

class Wizard: Character {
    init(wizardName: String) {
        super.init(life: 80, name: wizardName, arme: Weapon.init(name: "Sort", degats: 24), type: .Wizard, heal: 10)
    }
}

class Dragon: Character {
    init(dragonName: String) {
        super.init(life: 50, name: dragonName, arme: Weapon.init(name: "Feu", degats: 40), type: .Dragon, heal: 12)
    }
}

class Ninja: Character {
    init(ninjaName: String) {
        super.init(life: 60, name: ninjaName, arme: Weapon.init(name: "Katana", degats: 35), type: .Ninja, heal: 15)
    }
}
class Skeleton: Character {
    init(skeletonName: String) {
        super.init(life: 40, name: skeletonName, arme: Weapon.init(name: "Os", degats: 30), type: .Skeleton, heal: 20)
    }
}


enum Type {
    case Knight
    case Archer
    case Wizard
    case Dragon
    case Ninja
    case Skeleton
}
