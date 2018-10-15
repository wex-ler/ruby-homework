###base class for board

class Board
    attr_accessor :data

    def initialize
        @data = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    end

    def status
        @data.each do |row|
            row.each do |cell|
                print "[ #{cell} ] "
            end

            print "\n"
        end
    end
    
    #functions below do not check for out of bounds error!
    def [](index)
        @data[index / 3][index % 3]
    end

    def []=(index, value)
        @data[index / 3][index % 3] = value
    end
end 

###entry

board = Board.new
first = true

while true do
    board.status
    puts "Player #{first ? 'O' : 'X'} move."

    print "Where do you want to put the a#{first ? ' circle' : 'n x'} [0 - 8]? "
    idx = gets.to_i

    if idx < 0 || idx > 8
        puts 'Invalid input, please try again.'
    elsif board[idx] != idx
        puts 'That field is already occupied! Try again.'
    elsif
        board[idx] = first ? 'O' : 'X'

        first = !first
    end

    print "\n"
end