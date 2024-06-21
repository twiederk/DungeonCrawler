extends GutTest

const sprite_frames_fighter = preload("res://Assets/graphics/sprites/Fighter.tres")
const sprite_frames_mage = preload("res://Assets/graphics/sprites/Mage.tres")
const sprite_frames_skeleton = preload("res://Assets/graphics/sprites/Skeleton.tres")

var battle_init: BattleInit = null


func before_each():
	battle_init = BattleInit.new()


func test_create_battler():

	# arrange
	var scene = load("res://Battle/Character.tscn")
	var linda = get_linda()

	# act
	var battler = battle_init.create_battler(scene, linda, Vector2(2, 2))

	# assert
	assert_eq(battler.position, Vector2(32, 32), "Should have correct position")
	var creature = battler.get_creature()
	assert_eq(creature.name, "Linda", "Should set correct name")
	assert_eq(creature.hit_points, 1, "Should set hit points to one")
	assert_eq(creature.damage, 2, "Should set damage to two")
	assert_eq(creature.armor_class, 3, "Should set armor class to three")
	assert_eq(creature.max_movement, 4, "Should set max movement to four")
	assert_eq(creature.movement, 5, "Should set movement to five")

	# tear down
	battler.free()


func test_create_battlers():
	# arrange
	var character_stats = [ get_linda(), get_leon() ]
	var character_scene = load("res://Battle/Character.tscn")
	var battle = Battle.new()
	add_child(battle)

	# act
	var characters = battle_init.create_battlers(character_scene, battle, character_stats)

	# assert
	assert_eq(characters.size(), 2, "Should create two characters when two textures are given")
	assert_eq(characters[0].position, Vector2(16, 16), "Should place 1st charater at (16, 16)")
	assert_eq(characters[0].get_node("AnimatedSprite2D").sprite_frames, sprite_frames_mage, "Should have given texture")
	assert_eq(characters[0].get_creature_name(), "Linda", "Should name 1st charater with Linda")

	assert_eq(characters[1].position, Vector2(32, 16), "Should place 2nd charater at (32, 16)")
	assert_eq(characters[1].get_node("AnimatedSprite2D").sprite_frames, sprite_frames_fighter, "Should have given texture")
	assert_eq(characters[1].get_creature_name(), "Leon", "Should name 2nd charater with Leon")

	# tear down
	for character in characters:
		character.free()
	battle.free()


func test_create_items():
	# arrange
	var battle = Battle.new()

	# act
	var items = battle_init.create_items(battle, [
		{ frame_coords = Vector2(2, 30), position = Vector2(9, 4) },
		{ frame_coords = Vector2(2, 30), position = Vector2(10, 11) },
	])

	# assert
	assert_eq(items.size(), 2, "Should create two items")
	assert_eq(items[0].position, Vector2(144, 64), "Should place first item at (144, 64)")
	assert_eq(items[1].position, Vector2(160, 176), "Should place second item at (160, 176)")

	# tear down
	for item in items:
		item.free()
	battle.free()


func test_create_item():
	# arrange
	var frame_coords = Vector2(2, 30)
	var position = Vector2(9, 4)

	# act
	var item = battle_init.create_item(frame_coords, position)

	# assert
	assert_eq(item.position, Vector2(144, 64), "Should set proper position")

	# tear down
	item.free()


func get_linda() -> CreatureStats:
	var linda = CreatureStats.new()
	linda.name = "Linda"
	linda.hit_points = 1
	linda.damage = 2
	linda.armor_class = 3
	linda.max_movement = 4
	linda.movement = 5
	linda.texture = sprite_frames_mage
	return linda


func get_leon() -> CreatureStats:
	var leon = CreatureStats.new()
	leon.name = "Leon"
	leon.hit_points = 16
	leon.damage = 2
	leon.armor_class = 15
	leon.texture = sprite_frames_fighter
	leon.max_movement = 3
	leon.movement = 3
	return leon
