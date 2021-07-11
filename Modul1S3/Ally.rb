require_relative "Hero"

class Ally < Hero
    def initialize(name,hitpoint,damage_attack, deflect_ability)
        super(name, hitpoint, damage_attack, deflect_ability)
    end

    def healed(heal_point)
        puts "#{name} is healed. Restored #{heal_point} point"
        @hitpoint+=heal_point
    end
end
