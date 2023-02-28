extends GutTest

const texture1 = preload("res://Assets/graphics/sprites/Fighter.png")
const texture2 = preload("res://Assets/graphics/sprites/Skeleton.png")

var combat_init: CombatInit = null

func before_each():
	combat_init = CombatInit.new()


func test_can_create_CombatInit():
	# act
	var my_combat_init = CombatInit.new()

	# assert
	assert_not_null(my_combat_init)


func test_create_character():

	# arrange
	var character_dictionary = {
		name = "myName",
		texture_file = "res://Assets/graphics/sprites/Fighter.png"
	}

	# act
	var character = combat_init.create_character(character_dictionary, Vector2(2, 2))

	# assert
	assert_eq(character.get_node("Sprite2D").texture, texture1, "Should have given texture")
	assert_eq(character.position, Vector2(64, 64), "Should have correct position")
	var creature = character.get_creature()
	assert_eq(creature.get_name(), "myName", "Should set correct name")
	assert_eq(creature.get_damage(), 1, "Should set damage to one")

	# tear down
	character.free()


#func test_create_characters():
#	# arrange
#	var combat = double(Combat).new()
#
#	# act
#	var characters = combat_init.create_characters(combat, [
#			{ name = "Character 0", texture_file = "res://Assets/graphics/sprites/Fighter.png" },
#			{ name = "Character 1", texture_file = "res://Assets/graphics/sprites/Mage.png" },
#		])
#
#	# assert
#	assert_eq(characters.size(), 2, "Should create two characters when two textures are given")
#	assert_eq(characters[0].position, Vector2(32, 32), "Should place 1st charater at (32, 32)")
#	assert_eq(characters[0].get_creature().get_name(), "Character 0", "Should name 1st charater with Character 0")
#
#	assert_eq(characters[1].position, Vector2(64, 32), "Should place 2nd charater at (64, 32)")
#	assert_eq(characters[1].get_creature().get_name(), "Character 1", "Should name 2nd charater with Character 1")
#
#	# tear down
#	for character in characters:
#		character.free()
#	combat.free()



func test_create_monster():
	# arrange
	combat_init.create_monster_manual()

	# act
	var monster = combat_init.create_monster("Skeleton", Vector2(3, 3))

	# assert
	assert_eq(monster.get_node("Sprite2D").texture, texture2, "Should have given texture")
	assert_eq(monster.position, Vector2(96, 96), "Should place monster at (96, 96)")
	var creature = monster.get_creature()
	assert_eq(creature.get_name(), "Skeleton", "Should set name to Skeleton")
	assert_eq(creature.get_hit_points(), 2, "Should set hit points to 2")
	assert_eq(creature.get_armor_class(), 10, "Should set armor class to 10")

	# tear down
	monster.free()


#func test_create_monsters():
#	# arrange
#	var combat = double(Combat).new()
#	combat_init.create_monster_manual()
#
#	# act
#	var monsters = combat_init.create_monsters(combat, [
#		{ monster = "Skeleton", position = Vector2(3, 3) },
#		{ monster = "Skeleton Chief", position = Vector2(4, 3) },
#	])
#
#	# assert
#	assert_eq(monsters.size(), 2, "Should create one monster for each given texture")
#	assert_eq(monsters[0].position, Vector2(96, 96), "Should place 1st monster at (96, 96)")
#	assert_eq(monsters[1].position, Vector2(128, 96), "Should place 2nd monster at (128, 96)")
#
#	# tear down
#	for monster in monsters:
#		monster.free()


func test_create_monster_manual():

	# act
	combat_init.create_monster_manual()

	# assert
	assert_eq(combat_init._monster_manual.size(), 2, "Should fill monster manual with two monsters")


#func test_create_items():
#	# arrange
#	var combat = double(Combat).new()
#
#	# act
#	var items = combat_init.create_items(combat, [
#		{ frame_coords = Vector2(2, 30), position = Vector2(9, 4) },
#		{ frame_coords = Vector2(2, 30), position = Vector2(10, 11) },
#	])
#
#	# assert
#	assert_eq(items.size(), 2, "Should create two items")
#	assert_eq(items[0].position, Vector2(288, 128), "Should place first item at (288, 128)")
#	assert_eq(items[0].get_frame_coords(), Vector2(2, 30), "Should use frame_coords (2, 30) for first item")
#	assert_eq(items[1].position, Vector2(320, 352), "Should place second item at (320, 352)")
#	assert_eq(items[1].get_frame_coords(), Vector2(2, 30), "Should use frame_coords (2, 30) for second item")
#
#	# tear down
#	for item in items:
#		item.free()


#func test_create_item():
#	# arrange
#	var frame_coords = Vector2(2, 30)
#	var position = Vector2(9, 4)
#
#	# act
#	var item = combat_init.create_item(frame_coords, position)
#
#	# assert
#	assert_eq(item.get_node("Sprite2D").frame_coords, Vector2(2, 30), "Should set proper frame coords")
#	assert_eq(item.position, Vector2(288, 128), "Should set proper position")
#
#	# tear down
#	item.free()

