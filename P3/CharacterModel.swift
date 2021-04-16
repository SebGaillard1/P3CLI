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
    var arme: Weapon
    var type: Type
    
    init(life: Int, name: String, arme: Weapon, type: Type) {
        self.life = life
        self.name = name
        self.arme = arme
        self.type = type
    }
    
    func attack() {
        
    }
    
    func heal() {
        
    }
}

class Knight: Character {
    init(knightName: String) {
        super.init(life: 100, name: knightName, arme: Weapon.init(name: "Sword", degats: 20), type: .Knight)
    }
}

class Archer: Character {
    init(archerName: String) {
        super.init(life: 90, name: archerName, arme: Weapon.init(name: "Bow", degats: 22), type: .Archer)
    }
}

class Wizard: Character {
    init(wizardName: String) {
        super.init(life: 80, name: wizardName, arme: Weapon.init(name: "Spell", degats: 24), type: .Wizard)
    }
}

class Dragon: Character {
    init(dragonName: String) {
        super.init(life: 50, name: dragonName, arme: Weapon.init(name: "Fire", degats: 40), type: .Dragon)
    }
}

class Ninja: Character {
    init(ninjaName: String) {
        super.init(life: 60, name: ninjaName, arme: Weapon.init(name: "Katana", degats: 35), type: .Ninja)
    }
}
class Skeleton: Character {
    init(skeletonName: String) {
        super.init(life: 40, name: skeletonName, arme: Weapon.init(name: "Bone", degats: 30), type: .Skeleton)
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
