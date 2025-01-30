
// Weapon class with string as its type.
class Weapon {
    var weapon: String
    init(weaponType: String) {
        weapon = weaponType
    }
}

// Armor class with string as its type.
class Armor {
    var armor: String
    init(armorType: String) {
        armor = armorType
    }
}

// A superclass of character with qualities shared by its sub-classes.
class RPGCharacter {
    var maxSpellPoints: Int
    var maxHealthPoints: Int
    var currSpellPoints: Int
    var currHealthPoints: Int
    var name: String
    var characterWeapon: String // Weapon? if we were to declare it as a Weapon class with nil
    var characterArmor: String  // Armor? if we were to declare it as an Armor class with nil
    var protectionPoints: Int
    init(characterName: String) {
        name = characterName
        maxSpellPoints = 0
        maxHealthPoints = 0
        currHealthPoints = 0
        currSpellPoints = 0
        characterWeapon = "none"
        characterArmor = "none"
        protectionPoints = 10
    }
    
    // A function for character to wield a weapon.
    func wield(weaponObject: Weapon) {
        characterWeapon = weaponObject.weapon
        print("\(name) is now wielding a(n) \(characterWeapon)")
    }
    
    // A function for a character to put on armor.
    func putOnArmor(armorObject: Armor) {
        characterArmor = armorObject.armor
        print("\(name) is now wearing \(characterArmor)")
    }
    
    // A function for a character to unwield.
    func unwield(weaponObject: Weapon) {
        characterWeapon = "none"
        print("\(name) is no longer wielding anything.")
    }
    
    // A function for a character to take off armor.
    func takeOffArmor(armorObject: Armor) {
        characterArmor = "none"
        print("\(name) is no longer wearing anything.")
    }
    
    // A function for a character to fight and do damage with or without a weapon.
    func fight(opponent: RPGCharacter) {
        print("\(name) attacks \(opponent.name) with a(n) \(characterWeapon)")
        var damagePoints = 1
        if (characterWeapon == "dagger") {
            damagePoints = 4
        } else if (characterWeapon == "staff" || characterWeapon == "axe") {
            damagePoints = 6
        } else if (characterWeapon == "sword") {
            damagePoints = 10
        }
        opponent.currHealthPoints -= damagePoints
        print("\(name) does \(damagePoints) damage to \(opponent.name)")
        print("\(opponent.name) is now down to \(opponent.currHealthPoints) health")
        checkForDefeat(character: opponent)
    }
    
    // A function that shows stats for a character.
    func show() {
        print("\(name)")
        print("   Current Health:  \(currHealthPoints)")
        print("   Current Spell Points:  \(currSpellPoints)")
        print("   Wielding:  \(characterWeapon)")
        print("   Wearing:  \(characterArmor)")
        if (characterArmor == "plate") {
            protectionPoints = 2
        } else if (characterArmor == "chain") {
            protectionPoints = 5
        } else if (characterArmor == "leather") {
            protectionPoints = 8
        }
        print("   Armor class:  \(protectionPoints)")
    }
    
    // A function that checks if the character is defeated.
    func checkForDefeat(character:RPGCharacter) {
        if (character.currHealthPoints <= 0) {
            print("\(character.name) has been defeated!")
        }
    }
}

// A fighter class that inherits from RPGCharacter and has specific beginning stats.
class Fighter: RPGCharacter {
    init(name: String) {
        super.init(characterName: name)
        super.maxHealthPoints = 40
        super.maxSpellPoints = 0
        super.currSpellPoints = 0
        super.currHealthPoints = 40
    }
}

// A wizard class that inherits from RPGCharacter and has its own stats to start with.
class Wizard: RPGCharacter{
    init(name: String) {
        super.init(characterName: name)
        super.maxHealthPoints = 16
        super.maxSpellPoints = 20
        super.currSpellPoints = 20
        super.currHealthPoints = 16
    }
    
    // The function overrides the RPGCharacter's wield function and can only wield specific weapons.
    override func wield(weaponObject: Weapon) {
        if (weaponObject.weapon == "dagger" || weaponObject.weapon == "staff") {
            super.wield(weaponObject: weaponObject) // the second weaponObject is from the parameter of my override func wield
        } else {
            print("Weapon not allowed for this character class.")
        }
    }
    
    // A wizard cannot put on armor.
    override func putOnArmor(armorObject: Armor) {
        print("Armor is not allowed for this character class.")
    }
    
    // A function that allows wizard to cast spell on its opponent.
    func castSpell(spellName: String, target: RPGCharacter) {
        var spellCost = 0
        var spellEffect = 0
        var characterSpellName = spellName
        
        if (spellName == "Fireball") {
            spellCost = 3
            spellEffect = 5
            characterSpellName = "Fireball"
        } else if (spellName == "Lightning Bolt") {
            spellCost = 10
            spellEffect = 10
            characterSpellName = "Lightning Bolt"
        } else if (spellName == "Heal") {
            spellCost = 6
            spellEffect = 6
            characterSpellName = "Heal"
        }
        
        // If spellCost is insufficient, print insufficient spell points.
        if (currSpellPoints < spellCost) {
            return print("Insufficient spell points")
        } else if (characterSpellName == "Heal" && currSpellPoints >= spellCost) { // Uses heal.
            currSpellPoints -= spellCost
            target.currHealthPoints += spellEffect
            if (target.currHealthPoints >= target.maxHealthPoints) {
                target.currHealthPoints = target.maxHealthPoints
            }
            print("\(name) casts \(characterSpellName) at \(target.name)")
            print("\(name) heals \(target.name) for \(spellEffect) health points")
            print("\(target.name) is now at \(target.currHealthPoints) health")
        } else if ((characterSpellName == "Fireball" || characterSpellName == "Lightning Bolt") && currSpellPoints >= spellCost) { // Uses the other spells.
            currSpellPoints -= spellCost
            target.currHealthPoints -= spellEffect
            print("\(name) casts \(characterSpellName) at \(target.name)")
            print("\(name) does \(spellEffect) damage to \(target.name)")
            print("\(target.name) is now down to \(target.currHealthPoints) health")
        } else { // If it's not the above spells, then it's an unknown spell.
            return print("Unknown spell name. Spell failed.")
        }
    }
}

// top level code

let plateMail = Armor(armorType: "plate")
let chainMail = Armor(armorType: "chain")
let sword = Weapon(weaponType: "sword")
let staff = Weapon(weaponType: "staff")
let axe = Weapon(weaponType: "axe")

let gandalf = Wizard(name: "Gandalf the Grey")
gandalf.wield(weaponObject: staff)

let aragorn = Fighter(name: "Aragorn")
aragorn.putOnArmor(armorObject: plateMail)
aragorn.wield(weaponObject: axe)

gandalf.show()
aragorn.show()

gandalf.castSpell(spellName: "Fireball", target: aragorn)
aragorn.fight(opponent: gandalf)

gandalf.show()
aragorn.show()

gandalf.castSpell(spellName: "Lightning Bolt", target: aragorn)
aragorn.wield(weaponObject: sword)

gandalf.show()
aragorn.show()

gandalf.castSpell(spellName: "Heal", target: gandalf)
aragorn.fight(opponent: gandalf)
