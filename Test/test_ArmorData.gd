extends GutTest

var armor_data: ArmorData = null


func before_each():
	armor_data = ArmorData.new()
	

func test_parse_line():
	# arrange
	var line:PackedStringArray = PackedStringArray(["1", "Kleidung", "10", "armor_001.png"])
	var texture = load("res://Assets/graphics/sprites/items/armor/armor_001.png")

	# act
	var armor = armor_data._parse_armor(line)

	# assert
	assert_eq(armor.id, 1)
	assert_eq(armor.name, "Kleidung")
	assert_eq(armor.armor_class, 10)
	assert_eq(armor.texture, texture)


func test_load_armor():

	# act
	var armor = armor_data._load_armor("res://Test/Resources/test_ArmorData.csv")

	# assert
	assert_eq(armor.size(), 3)


func test_create_armor_dictionary():

	# arrange
	var cloth = ArmorResource.new()
	cloth.id = 1
	cloth.name = "Cloth"
	var leather = ArmorResource.new()
	leather.id = 2
	leather.name = "Leather"
	var armor: Array[ArmorResource] = [ cloth, leather ]

	# act
	var armor_dictionary = armor_data._create_armor_dictionary(armor)

	# assert
	assert_eq(armor_dictionary[1].name, "Cloth")
	assert_eq(armor_dictionary[2].name, "Leather")


func test_get_weapon_by_id():
	# arrange
	var cloth = ArmorResource.new()
	cloth.id = 1
	cloth.name = "Cloth"
	var leather = ArmorResource.new()
	leather.id = 2
	leather.name = "Leather"
	armor_data._armor_dictionary = { cloth.id: cloth, leather.id: leather }

	# act
	var armor = armor_data.get_armor(cloth.id)

	# assert
	assert_same(armor, cloth)
