extends GutTest

var monster_dictionary: MonsterDictionary = null

func before_each():
	monster_dictionary = MonsterDictionary.new()
	

func test_can_create_MonsterDictionary():
	# act
	var my_monster_dictionary = MonsterDictionary.new()
	
	# assert
	assert_not_null(my_monster_dictionary)


func test_size():
	
	# act
	var size = monster_dictionary.size()
	
	# assert
	assert_eq(size, 0, "Should be empty after instanciation")


func test_add_monster():
	# arrange
	var monster = {
		name = "Goblin",
		hit_points = 2,
		armor_class = 10,
		texture_file = "res://World/Goblin_01.png"
	}
	
	# act
	monster_dictionary.add_monster(monster)
	
	# assert
	assert_eq(monster_dictionary.size(), 1, "Should add monster to dictionary")
	assert_not_null(monster_dictionary.get_monster("Goblin"))



func test_get_monster():
	# arrange
	monster_dictionary.add_monster({
		name = "Goblin",
		hit_points = 2,
		armor_class = 10,
		texture_file = "res://World/Goblin_01.png"
	})
	
	# act
	var monster = monster_dictionary.get_monster("Goblin")
	
	# assert
	assert_not_null(monster)
	assert_eq(monster["name"], "Goblin", "Should return dictionary of monster with name Goblin")
	

