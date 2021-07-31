class IncrementInt
    def initialize(number)
        @number = number
    end

    def increment
        plusOne = false
        i = @number.size() - 1
        while i >= 0 
            if (i == @number.size() - 1 || plusOne)
                @number[i] = @number[i] + 1
                if @number[i] > 9
                    plusOne = true
                    @number[i] = 0
                else
                    plusOne = false
                end
            end
            i = i - 1
        end
        if plusOne
            @number.unshift(1)
        end
        return @number
    end
end