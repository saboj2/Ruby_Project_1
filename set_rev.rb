#makes sure it can access the subscriber class
require_relative 'subscriber'

class Set
    #setarray and setname of each set is accessible outside this class
    attr_accessor :setarray, :setname

    #constructor for new set objects
    def initialize(arr,name)
        #setname is set equal to the one given by the user
        @setname = name
        #initialize empty setarray
        @setarray = []
        #sorts the array of lines read in from file (each is a string of both id and name)
        #must be sorted for search algorithm to work
        arr.sort!

        #for loop to fill setarray with new subscriber objects
        i=0
        for i in 0..arr.length-1
        
        #splits the string "ID NAME" into two separate variables stored in array s
        s = arr[i].split(" ",2)
        #remove the newline character from the name of the new subscriber
        nonl = s[1]
        nonl = nonl.delete "'\n'"

        #create new subscriber object "person"
        person = Subscriber.new(s[0],nonl, arr[i])
            #if there is nothing in the setarray yet, just add the new subscriber in
            #search algorithm might have trouble with an empty set
            if i==0
               
                @setarray.push(person)
            #when there are subs in the setarray, it must check to make sure it doesn't already exist
            else
                #uses contains? function to check if the subscriber is already in the setarray
                unless contains?(person,0,@setarray.length-1)
                #if it's not, add it to the array
                @setarray.push(person)
                end
            end
        end
        

    end

    #method for printing out the contents of a set
    def info
        #start with a bracket
        print "{"
        #for loop through each subscriber object in the setarray
        for i in 0..(@setarray.length-1)
        #set the current subscriber object to a temporary variable, and print out its information
        tempperson = @setarray[i]
        tempperson.to_s
        #adds a new line character at the end of every subscriber object EXCEPT the last one
        if i!=(@setarray.length-1)
        print ",\n"
        end
        end
        #close with bracket
        print "}"
    end
    
    #binary search algorithm to check if an object is in the setarray via its string
    #since the array is sorted via each string of each subscriber object, the binary search works
    def contains?(idd,l,r)
        #make sure the highest element number is bigger than the lowest element number
        unless l > r
            #create a middle point of the array
            mid = (l + r)/2
            #if the object is located at the middle point, it definitely exists, return true
            if @setarray[mid].string == idd.string
                return true
            #if the object's string value is greater than the middle one, check the right side of the array
            elsif @setarray[mid].string < idd.string
                return contains?(idd, mid+1, r)
            #if the object's string value is greater than the middle one, check the left side of the array
            else
                return contains?(idd, l, mid-1)
            end
        end
        #if it can't be found, return false
        return false
    end

    #method for adding a new subscriber to the array
    def add_sub (person)
        #uses contains? to check if it exists or not, adds the subscriber if it doesn't exist 
        unless contains?(person,0,@setarray.length-1)
            @setarray.push(person)
            #re-sorts the array
            @setarray.sort_by!(&:id)
        else
            #prints that the subscriber already exists if it finds that it does exist
            puts "That Subscriber already exists in that set!"
            return 0
        end
          
    end

    #method for creating the union of two sets (one who called the method and an external one)
    def union(otherset, name)

        #Creates new set to hold the union of the two sets, initialize it with empty set
        setinit =[]
        unionset = Set.new(setinit, name)

        #two for loops to cycle through both sets
        i=0
        j=0
        #first loop is for setarray of set that called the method
        for i in 0..@setarray.length-1
            #checks to see if current subscriber is in in union set (assumed it isn't for first set since it's empty)
            unless unionset.contains?(@setarray[i],0,unionset.setarray.length-1)
                #adds to union set if it's not already in there
                unionset.setarray.push(@setarray[i])
            end
        end

        #second loop is for the other set passed as a parameter
        for j in 0..otherset.setarray.length-1
            #checks to see if the current element from the other set is in union set
            unless unionset.contains?(otherset.setarray[j],0,unionset.setarray.length-1)
                #if it's not, it adds it
                unionset.setarray.push(otherset.setarray[j])
            end
        end
        #sorts the array so that it can be manipulated further
        unionset.setarray.sort_by!(&:id)
        #returns the newly created set
        return unionset
    end

    #method for creating intersection of two sets.
    def intersection(otherset,name)
        #intitializes empty set, and creates new set object to hold intersection set
        setinit =[]
        interset = Set.new(setinit, name)

        #two for loops to cycle through each element of both sets and compare them
        i=0
        j=0
        #first loop cycles through the setarray 
        for i in 0..@setarray.length-1
            tempid1=@setarray[i].id
            tempname1=@setarray[i].name
            #nested for loop cycles through the other set's setarray
            for j in 0..otherset.setarray.length-1
                tempid2=otherset.setarray[j].id
                tempname2=otherset.setarray[j].name
               
                #compares the current subscriber of setarray with the current subscriber of the other set's setarray
                if (tempid1 == tempid2) && (tempname1 == tempname2)
                    #as long as the subscriber isn't already inside the new intersection set, it adds
                    unless interset.contains?(@setarray[i],0,interset.length-1)
                        interset.setarray.push(otherset.setarray[j])
                    end
                end

            end
        end
        #sorts the array so it can be manipulated further
        interset.setarray.sort_by!(&:id)
        #returns the new intersection set
        return interset
    end

    #method for creating cartesian set
    def cartesian(otherset,name)
        #initialize new empty set to create new set object to hold the cartesian product
        setinit =[]
        cartset = Set.new(setinit,name)
        #two for loops to concatenate each subscriber of setarray with each subscriber of the other set's setarray
        i=0
        j=0
        #first loop gets the subscriber info at the ith element of setarray
        for i in 0..@setarray.length-1
            tempid1=@setarray[i].id
            tempname1=@setarray[i].name
            #nested loop gets the subscriber info at the ith element of the other set's setarray
            for j in 0..otherset.setarray.length-1
                tempid2=otherset.setarray[j].id
                tempname2=otherset.setarray[j].name
                #combines the info of the subscriber from setarray into one string
                #this will be used as the "id" of the new subscriber
                firstsub = "(#{tempid1}, #{tempname1})"
                #combines the info of the subscriber from other set's setarray into one string
                #this will be used as the "name" of the new subscriber
                secondsub = "(#{tempid2}, #{tempname2})"
                #creates new subscriber, where the id is the info from the first subscriber, and the name is the info of the second subscriber
                cartperson = Subscriber.new(firstsub, secondsub, "#{firstsub}, #{secondsub}")
                #adds it to the new cartesian set
                cartset.setarray.push(cartperson)
            end
        end
        #returns cartesian set
        return cartset
    end

end
