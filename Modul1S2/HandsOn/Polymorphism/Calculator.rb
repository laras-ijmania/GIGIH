class Calculator
    def add(number1, number2)
        number1 + number2
    end
end

calculator = Calculator.new

integer = calculator.add(1,2)
puts integer

double = calculator.add(1.23,5.44)
puts double

string = calculator.add('test ' , 'something')
puts string