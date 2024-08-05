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
