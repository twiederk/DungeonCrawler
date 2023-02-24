extends GutTest

var inventory: Inventory = null


func before_each():
	inventory = Inventory.new()


func test_can_create_Inventory():
	
	# act
	var myInventory = Inventory.new()
	
	# assert
	assert_not_null(myInventory)


func test_get_set_gold():
	
	# act & assert
	assert_accessors(inventory, "gold", 0, 10)
	

func test_add_gold():
	
	# arrange
	inventory.set_gold(5)
	
	# act
	inventory.add_gold(7)
	
	# assert
	assert_eq(inventory.get_gold(), 12, "Should add 7 gold to the inventory")
	
