extends GutTest

const BattleScene = preload("res://Battle/Battle.tscn")

const sprite_frames_fighter = preload("res://Battle/Character/FighterSpriteFrames.tres")
const sprite_frames_mage = preload("res://Battle/Character/MageSpriteFrames.tres")
const sprite_frames_skeleton = preload("res://Battle/Monster/Skeleton_Sword_SpriteFrames.tres")

var battle_init: BattleInit = null


func before_each():
	battle_init = BattleInit.new()


func test_create_battler():

	# arrange
	var scene = load("res://Battle/CharacterBattler.tscn")
	var linda = get_linda()
	var battlefield = Battlefield.new()

	# act
	var battler = battle_init.create_battler(scene, linda, battlefield)

	# assert
	var creature = battler.get_creature()
	assert_eq(creature.name, "Linda", "Should set correct name")
	assert_eq(creature.hit_points, 1, "Should set hit points to one")
	assert_eq(creature.damage, 2, "Should set damage to two")
	assert_eq(creature.armor.armor_class, 10, "Should set armor class to ten")
	assert_eq(creature.max_movement, 4, "Should set max movement to four")
	assert_eq(creature.movement, 5, "Should set movement to five")

	# tear down
	battler.free()
	battlefield.free()


func test_create_battlers():
	# arrange
	PlayerStats.load_characters()
	var character_stats = [ get_linda(), get_leon() ]
	var character_scene = load("res://Battle/CharacterBattler.tscn")
	var battle = BattleScene.instantiate()
	add_child(battle)

	# act
	var characters = battle_init.create_battlers(character_scene, battle, battle.party_screen, character_stats)

	# assert
	assert_eq(characters.size(), 2, "Should create two characters when two textures are given")
	assert_eq(characters[0].get_node("AnimatedSprite2D").sprite_frames, sprite_frames_mage, "Should have given texture")
	assert_eq(characters[0].get_creature_name(), "Linda", "Should name 1st charater with Linda")

	assert_eq(characters[1].get_node("AnimatedSprite2D").sprite_frames, sprite_frames_fighter, "Should have given texture")
	assert_eq(characters[1].get_creature_name(), "Leon", "Should name 2nd charater with Leon")

	# tear down
	for character in characters:
		character.free()
	battle.free()


func get_linda() -> CreatureStats:
	var cloth = ArmorResource.new()
	cloth.armor_class = 10
	
	var linda = CreatureStats.new()
	linda.name = "Linda"
	linda.hit_points = 1
	linda.damage = 2
	linda.armor = cloth
	linda.max_movement = 4
	linda.movement = 5
	linda.sprite_frames = sprite_frames_mage
	return linda


func get_leon() -> CreatureStats:
	var chain_mail = ArmorResource.new()
	chain_mail.armor_class = 16

	var leon = CreatureStats.new()
	leon.name = "Leon"
	leon.hit_points = 16
	leon.damage = 2
	leon.armor = chain_mail
	leon.sprite_frames = sprite_frames_fighter
	leon.max_movement = 3
	leon.movement = 3
	return leon
