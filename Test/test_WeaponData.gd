extends GutTest

var weapon_data = null


func before_each():
	weapon_data = WeaponData.new()


func test_parse_line():
	# arrange
	var line:PackedStringArray = PackedStringArray(["1", "Schwert", "1", "8", "MELEE_WEAPON", "5", "weapon_sword_01.png"])
	var texture = load("res://World/Items/Weapons/weapon_sword_01.png")

	# act
	var weapon = weapon_data._parse_weapon(line)

	# assert
	assert_eq(weapon.id, 1)
	assert_eq(weapon.name, "Schwert")
	assert_eq(weapon.damage.number_of_dice, 1)
	assert_eq(weapon.damage.die, DiceBox.Die.D8)
	assert_eq(weapon.weapon_type, WeaponResource.WeaponType.MELEE_WEAPON)
	assert_eq(weapon.range, 5)
	assert_eq(weapon.texture, texture)


func test_load_weapons():

	# act
	var weapons = weapon_data._load_weapons("res://Test/Resources/test_WeaponData.txt")

	# assert
	assert_eq(weapons.size(), 3)


func test_create_weapon_dictionary():

	# arrange
	var sword = WeaponResource.new()
	sword.id = 1
	sword.name = "Sword"
	var axe = WeaponResource.new()
	axe.id = 2
	axe.name = "Axe"
	var weapons: Array[WeaponResource] = [ sword, axe ]

	# act
	var weapon_dictionary = weapon_data._create_weapon_dictionary(weapons)

	# assert
	assert_eq(weapon_dictionary[1].name, "Sword")
	assert_eq(weapon_dictionary[2].name, "Axe")


func test_get_weapon_by_id():
	# arrange
	var sword = WeaponResource.new()
	sword.id = 1
	sword.name = "Sword"
	var axe = WeaponResource.new()
	axe.id = 2
	axe.name = "Axe"
	weapon_data._weapon_dictionary = { sword.id: sword, axe.id: axe }

	# act
	var weapon = weapon_data.get_weapon(sword.id)

	# assert
	assert_same(weapon, sword)
