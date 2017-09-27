#Jeffrey Sabo Assignment1
#makes sure this file has access to the subscriber and set_rev classes
require_relative 'subscriber'
require_relative 'set_rev'

#global array to hold all sets created by the user
$current_sets = []

#methods used for interface
############################################################################################

#method for adding a new set to $current_sets
def make_new_set
    #prompts the user for the name of the file to create a set from
    puts "Enter File name to create a new set. (Make sure the file is in the same directory as this program): "
    #gets takes what the user types into the terminal
    filename = gets
    #checks if the file exists
    if File.exist?(filename.chomp)
        #if it does, read in every line of the file and store them in an array
        arr = IO.readlines(filename.chomp);
    else
        #if it does not, state this and exit the method
        puts "File Does not exist!"
        return 0;
    end

    #asks for a name for new set
    puts "Name the set: "
    #receives name entered by user and creates a new set based on the array of lines and the name entered
    setname = gets

    #for loop iterates through all existing sets in $current_sets
    i=0
    for i in 0..($current_sets.length-1)
        if $current_sets[i].setname == setname.chomp
            # if any set has the same name as the specified set name, it ends the method
            puts "There is already a set with that name!"
            return 0
            
        end
    end

    newset=Set.new(arr, setname.chomp)
    #adds new set to $current_sets so it can be accessed later
    $current_sets.push(newset)
    puts "Set created!"
end

#used to list every available set
def list_sets
    puts "Available sets:"
    #loops through $current_sets and displays the name of each set
    i=0
    for i in 0..$current_sets.length-1
        puts $current_sets[i].setname
    end
end

#method to display the contents of a given set
def display
    #prompts for the name of the desired set
    puts "Enter name of set you want displayed:"
    name = gets
    #uses find_set function to receive the desired set
    tempset = find_set(name.chomp)
    #as long as the function returns a set, it prints out it's contents using the info set method
    unless tempset == nil
        puts "#{name.chomp}:"
        tempset.info
    end
end

#method to locate a desired set
def find_set(set_name)
    #for loop loops through each element of $current_sets
    i=0
    for i in 0..($current_sets.length-1)
        #checks if the name of the set at i is the same as the desired set
        if $current_sets[i].setname == set_name
            #returns the set if it is found
            return $current_sets[i]
        end
    end
    #otherwise puts that the set is not found
        puts "Set not found!"
        return nil

end

#method to create a union set
def make_union
    #prompts for name of first set
    puts "Enter name of first set:"
    set1name = gets
    #locates first set
    set1 = find_set(set1name.chomp)
    if set1 == nil
        #if it is not found, it ends the method
        return 0
    end
    #prompts for the name of the second set
    puts "Enter name of second set:"
    set2name = gets
    #locates the second set
    set2 = find_set(set2name.chomp)
    if set2 == nil
        #if it is not found, it ends the method
        return 0
    end

    #asks the user to name the new set
    puts "Enter name for union set:"
    newsetname = gets
    #for loop iterates through all existing sets in $current_sets
    i=0
    for i in 0..($current_sets.length-1)
        if $current_sets[i].setname == newsetname.chomp
            # if any set has the same name as the specified set name, it ends the method
            puts "There is already a set with that name!"
            return 0
            
        end
    end
    #calls unionset from the first set entered, and passes the second set entered as a parameter
    unionset = set1.union(set2, newsetname.chomp)
    #adds the new set to the list of current sets
    $current_sets.push(unionset)
    puts "Union set created!"
end

#method to create the intersection of two sets
def make_intersection
    #asks for the name of first set
    puts "Enter name of first set:"
    set1name = gets
    #locates the desired set
    set1 = find_set(set1name.chomp)
    if set1 == nil
        #if not found, ends the method
        return 0
    end
    #asks for the name of the second set
    puts "Enter name of second set:"
    set2name = gets
    #locates the desired set
    set2 = find_set(set2name.chomp)
    if set2 == nil
        #if not found, ends the method
        return 0
    end
    #asks for the name of the new set
    puts "Enter name for intersection set:"
    newsetname = gets
    #for loop to iterate through list of current sets
    i=0
    for i in 0..($current_sets.length-1)
        #if a set with the same name is found, it ends the method
        if $current_sets[i].setname == newsetname.chomp
            puts "There is already a set with that name!"
            return 0
            
        end
    end

    #calls the intersection method from the first set and passes the second set as a parameter
    interset = set1.intersection(set2, newsetname.chomp)
    #adds new intersection set to list of current sets
    $current_sets.push(interset)
    puts "Intersection set created!"
end

#method for making cartesian product
def make_cartesian
    #asks for name of the first set
    puts "Enter name of first set:"
    set1name = gets
    #locates the desired set
    set1 = find_set(set1name.chomp)
    if set1 == nil
        #if not found, ends the method
        return 0
    end
    #asks for name of second set
    puts "Enter name of second set:"
    set2name = gets
    #locates desired set
    set2 = find_set(set2name.chomp)
    if set2 == nil
        #if not ends the method
        return 0
    end

    #asks the user to name the new set
    puts "Enter name for cartesian set:"
    newsetname = gets
    #for loop iterates through current sets 
    i=0
    for i in 0..($current_sets.length-1)
        if $current_sets[i].setname == newsetname.chomp
            #if a set already has that name it ends the method
            puts "There is already a set with that name!"
            return 0
            
        end
    end

    #creates new set by instantiating the cartesian method from the first set, and passing the other set as a parameter
    cartset = set1.cartesian(set2, newsetname.chomp)
    #adds new set to the list of current sets
    $current_sets.push(cartset)
    puts "Cartesian Product set created!"
end

#method for adding a subscriber to an already existing set
def add_newsub
    #asks for name of desired set
    puts "Enter name of set to add Subscriber to:"
    set1name = gets
    #locates desired set
    set1 = find_set(set1name.chomp)
    if set1 == nil
        #if not found, ends the method
        return 0
    end
    #asks for and obtains the ID and name of the new subscriber
    puts "Enter new Subscriber ID:"
    newid = gets
    puts "Enter new Subscriber Name:"
    newname = gets
    #creates new subscriber object
    newsub= Subscriber.new(newid.chomp,newname.chomp, "#{newid} #{newname}")
    #tries to add the new object to the specified set
    check = set1.add_sub(newsub)
    if check == 0
        #if the object already exists, it ends the method
        return 0
    end
    puts "Subscriber Added!"
end
############################################################################################

#infinite loop while x=1, x only equals 0 if the user selects to quit
x=1
while x==1
    #displays options for the user to select
    puts "\nPick an operation: \n 1:Create a new set \n 2:List available sets \n 3:Display Contents of a Set \n 4:Create the Union of two sets"
    puts " 5:Create the Intersection of two sets \n 6:Create the Cartesian Product of two sets \n 7:Add a new subsciber to an already existing set \n 0:Quit"
    #obtains user input
    operation = gets
    operation = operation.chomp
    #if they enter 0, quits the program
    if operation == "0"
        puts "Quitting..."
        x=0
    #if they enter 1, prompts them to create a new set
    elsif operation == "1" 
        make_new_set
    #if they enter 2, lists all availablle
    elsif operation == "2"
        list_sets
    #if they enter 3, allows them to pick a set to display
    elsif operation == "3"
        display
    #if they select 4, prompts to make a union of two sets
    elsif operation == "4"
        make_union
    #if they select 5, prompts them to make an intersection of two sets
    elsif operation == "5"
        make_intersection
    #if they select 6, prompts them to make a cartesian product of two sets
    elsif operation == "6"
        make_cartesian
    #if they select 7, prompts them to add a subscriber to an already existing set
    elsif operation == "7"
        add_newsub
    #if they enter something else, prints invalid and starts
    else
        puts "INVALID!"
    end


end