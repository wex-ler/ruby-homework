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
    def to_s
        "#{@full_name}, #{@id}"
    end
end

###derived classes

class Programmer < Employee
    def initialize(full_name, id, languages)
        super(full_name, id)
        parse_languages(languages)
    end

    def parse_languages(sentence)
        @programming_languages = []

        sentence.split(/[\s,]+/).each do |language|
            @programming_languages << language
        end
    end

    def to_s
        super() + " #{programming_languages}"
    end

    #disable meddling with programming languages, as they need to be parsed neatly
    protected
        attr_reader :programming_languages
end

class OfficeManager < Employee
    attr_accessor :department

    def initialize(full_name, id, department)
        super(full_name, id)
        @department = department
    end

    def to_s
        super() + " (#{department})"
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

    while !("poe".include? type)
        if type == 'q'
            return
        end
        
        #small help section
        puts 'Improper employee type, please try again with proper input demonstrated below'
        puts '[e]mployee: consists only of information you have already entered'
        puts '[p]rogrammer: enter programming languages'
        puts '[o]ffice manager: enter office department'
        print 'Type [q]uit to cancel adding the employee, enter any of the above options to continue: '

        type = get_action
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
        puts employee
    end
end

def edit_employees(employees)
    puts "[Edit existing employee's info]"

    print 'Full name: '
    sought = Employee.new(gets.chomp, nil)

    print 'ID: '
    sought.id = gets.chomp

    sought_index = employees.find_index(sought)

    if sought_index
        employee = employees[sought_index]

        puts "Current employee info: #{employee}"
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
    else
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