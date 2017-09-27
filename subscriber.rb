
#Subsciber Class, holds variables for each subsciber stored in a set array
class Subscriber

    #Allows the subscriber instance variables id and name can be accessed outside of this class
    attr_accessor :id
    attr_accessor :name
    #keeps track of the string thatoriginated the objects for sorting purposes
    attr_accessor :string

    #constructor for new Subscriber objects
    def initialize(id, name, string)

    #initilizes subcriber name, id, and string to the ones read in from the file
    @id = id
    @name = name.to_s.delete "'\n'"
    @string = string

    end
    
    #custom method to print out information about a subscriber object, specifically one inside a set
    def to_s
    print ("(#{@id}, #{@name})")
    
    end
end