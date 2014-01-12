# Follow these steps to complete this challenge.
# You may alter any code except for (1) the arguments being passed to the
# initialize methods of the four classes, (2) the Animal initialize method, and
# (3) the driver code.
#
#  1. Create a PetStore named pet_store with no animals
#
#  2. Add a Cat to the pet store's animals:
#     "Kitty" costs 35 dollars and has not been declawed.
#
#  3. Add four Dogs to the pet store's animals:
#     "Fido" costs 200 dollars and knows some tricks: "rollover" and "beg".
#     "Rover" costs 250 dollars and knows "beg", "sit", and "fetch".
#     "Bear" costs 350 dollars and knows "beg" and "sit".
#     "Baxter" costs 100 dollars and knows no tricks.
#
#  4. Write an instance method (count_dogs) to return the number of dogs in the pet store.
#
#  5. Update "Kitty" to show that it's been declawed.
#
#  6. Update "Baxter" to show that he's learned a trick: "spin".
#
#  7. Write an instance method (dog_tricks) that returns
#     an array of the names of all tricks known collectively by the dogs in the pet_store.
#
#  8. Write an instance method (most_expensive) that returns
#     the name of the most expensive animal in the pet store.
 
 
class Animal
 
  # Do not edit the initialize method
  def initialize(name, price)
    @name = name
    @price = price
    @furry = true
  end
end
 
class PetStore
 
  def initialize(animals = []) # Do not edit the arguments
  end
end
 
class Dog
 
  def initialize(name, price, tricks = []) # Do not edit the arguments
  end
end
 
class Cat
 
  def initialize(name, price, declawed = false) # Do not edit the arguments
  end
end
 
 
 
 
# __________________________________________
# Do Not alter code below this line
#
# Driver code
# When your code works properly, each line prints true in the console.
 
puts pet_store.class == PetStore
puts pet_store.animals[0].class == Cat
puts pet_store.animals[0].name == "Kitty"
puts pet_store.animals[0].price == 35
puts pet_store.animals[0].furry == true
puts pet_store.animals[1].class == Dog
puts pet_store.count_dogs == 4
puts pet_store.animals[0].declawed == true
puts pet_store.animals[4].tricks == ["spin"]
puts pet_store.dog_tricks == ["rollover", "beg", "sit", "fetch", "spin"]
puts pet_store.most_expensive == "Bear"