class Animal
    def initialize
    end
end


class Dog < Animal
    def initialize(breed)
        @breed = breed
    end

    def bark
        puts "woof woof"
    end
end

class Lab < Dog
    def initialize(breed, name)
        super(breed)
        @name = name
    end

    def to_s
        "{#@breed, #@name}"
    end

    def bark
        puts "woof woof labrador"
        super()
    end
end


laby =  Lab.new("Labrador", "Benzy")
puts laby.bark
