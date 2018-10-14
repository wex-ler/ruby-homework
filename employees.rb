###base class

class Employee
    attr_accessor :full_name
    attr_accessor :id

    def initialize(full_name, id)
        @full_name = full_name
        @id = id
    end

    def first_name
        @full_name.split(' ', 2).first
    end

    #split the string into two on first occurrence of ' ' and return the last element
    def last_name
        @full_name.split(' ', 2).last
    end

    #overload the equals operator
    def ==(rval)
        @full_name == rval.full_name && @id == rval.id
    end

    #custom to string
    def info
        puts "#{@full_name}, #{@id}"
    end
end

#helper function for parsing sentences
def is_alpha(char)
    if char.length > 1
        raise "Function 'is_alpha' takes a character not a string!"
    end

    (char >= 'a' && char <= 'z') || (char >= 'A' && char <= 'Z')
end

###derived classes

class Programmer < Employee
    #disable any unwanted changes by out of class writing, all changes made through parse_languages
    attr_reader :programming_languages

    def initialize(full_name, id, languages)
        super(full_name, id)
        parse_languages(languages)
    end

    def parse_languages(sentence)
        @programming_languages = Array.new

        i = 0

        while i < sentence.length
            sentence[i] = ' ' if is_alpha(sentence[i]) == false

            i += 1
        end

        #will properly split even on multiple spaces
        sentence.split(' ').each do |language|
            @programming_languages << language
        end
    end

    def info
        puts "#{@full_name}, #{@id} #{programming_languages}"
    end
end

class OfficeManager < Employee
    attr_accessor :department

    def initialize(full_name, id, department)
        super(full_name, id)
        @department = department
    end

    def info
        puts "#{@full_name}, #{@id} (#{department})"
    end
end

###data manipulation

def add_employee(employees)
    puts '[Add an employee]'

    print 'Full name: '
    full_name = gets.chomp

    print 'ID: '
    id = gets.chomp

    print 'Is the person an [e]mployee, [p]rogrammer or an [o]ffice manager? '
    type = get_action
    
    if type != 'e' && type != 'p' && type != 'o'
        puts 'Improper employee type, please try again with proper input'
        return
    end

    employee = nil

    case type
    when 'p'
        print 'Programming languages: '
        employee = Programmer.new(full_name, id, gets.chomp)
    when 'o'
        print 'Office: '
        employee = OfficeManager.new(full_name, id, gets.chomp)
    when 'e'
        employee = Employee.new(full_name, id)
    end

    employees << employee
end

def sorted_employees(employees, sort_criteria)
    employees.sort_by do |employee|
        if sort_criteria == 'l'
            employee.last_name
        else
            employee.first_name
        end
    end
end

def view_employees(employees)
    print 'Sort by [f]irst name of [l]ast name? '
    criteria = get_action

    #check if user input is valid
    if criteria != 'l' && criteria != 'f'
        puts 'Invalid sorting criteria, returning to main program'
        return
    end

    sorted_employees(employees, criteria).each do |employee|
        employee.info
    end
end

def edit_employees(employees)
    puts "[Edit existing employee's info]"

    print 'Full name: '
    sought = Employee.new(gets.chomp, nil)

    print 'ID: '
    sought.id = gets.chomp

    found = false

    employees.each do |employee|
        #see overloaded == operator above
        if sought == employee
            found = true

            print "Current employee info: "
            employee.info

            puts 'Please enter new employee info below'

            print 'Full name: '
            employee.full_name = gets.chomp

            print 'ID: '
            employee.id = gets.chomp

            case employee
            when Programmer
                print 'Programming languages: '
                employee.parse_languages(gets.chomp)
            when OfficeManager
                print 'Office: '
                employee.department = gets.chomp
            end

            break
        end
    end

    if !found
        puts 'Employee is not in the database, please review your input and try again'
    end
end

def quit
    puts 'Exiting...'
    exit
end

def print_help
    puts '[HELP]'
    puts 'Enter one of the following:'
    puts 'a - to add a new employee'
    puts 'v - to view existing employees'
    puts 'e - to edit existing employee'
    puts 'q - to quit the program'
end

def get_action
    gets.downcase[0]
end

###entry

puts 'Employee-o matic 4000'

employees = []

loop do
    print 'What do you want to do? '
    action = get_action

    case action
    when 'a' then add_employee(employees)
    when 'v' then view_employees(employees)
    when 'e' then edit_employees(employees)
    when 'q' then quit
    else
        print_help
    end
end