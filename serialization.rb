require 'csv'

class Person
  attr_reader :all_persons
  def initialize(args)
   @id = args[:id]
   @first_name = args[:first_name]
   @last_name = args[:last_name]
   @email = args[:email]
   @phone = args[:created_at]
  end
end

all_persons = []

CSV.foreach('people.csv', headers: true) do | row |
  row = Person.new(row)
end

p all_persons

# class PersonParser
#   attr_reader :file

#   def initialize(file)
#     @file = file
#     @people = nil
#   end

#   def people
#     # If we've already parsed the CSV file, don't parse it again.
#     # Remember: @people is +nil+ by default.
#     return @people if @people

#     # We've never called people before, now parse the CSV file
#     # and return an Array of Person objects here.  Save the
#     # Array in the @people instance variable.
#   end
# end

# parser = PersonParser.new('people.csv')

# puts "There are #{parser.people.size} people in the file '#{parser.file}'."



# output = CSV.read('people.csv', headers: true)

# output.each do |x|
#   p x
# end












