extends GutTest

var spell_data = null


func before_each():
	spell_data = SpellData.new()


func test_parse_line():
	# arrange
	var line:PackedStringArray = PackedStringArray(["1", "Magisches Geschoß", "12", "3", "4", "spell_magic_missile.png"])
	var texture = load("res://Assets/graphics/sprites/spells/spell_magic_missile.png")

	# act
	var spell = spell_data._parse_spell(line)

	# assert
	assert_eq(spell.id, 1)
	assert_eq(spell.name, "Magisches Geschoß")
	assert_eq(spell.range, 12)
	assert_eq(spell.damage.number_of_dice, 3)
	assert_eq(spell.damage.die, DiceBox.Die.D4)
	assert_eq(spell.texture, texture)


func test_load_spells():

	# act
	var spells = spell_data._load_spells("res://Test/Resources/test_SpellData.txt")

	# assert
	assert_eq(spells.size(), 1)


func test_create_spell_dictionary():

	# arrange
	var magic_missile = SpellResource.new()
	magic_missile.id = 1
	magic_missile.name = "Magic Missile"
	
	var acid_splash = SpellResource.new()
	acid_splash.id = 2
	acid_splash.name = "Acid Splash"
	
	var spells: Array[SpellResource] = [ magic_missile, acid_splash ]

	# act
	var spell_dictionary = spell_data._create_spell_dictionary(spells)

	# assert
	assert_eq(spell_dictionary[1].name, "Magic Missile")
	assert_eq(spell_dictionary[2].name, "Acid Splash")


func test_get_spell_by_id():
	# arrange
	var magic_missile = SpellResource.new()
	magic_missile.id = 1
	magic_missile.name = "Magic Missile"
	
	var acid_splash = SpellResource.new()
	acid_splash.id = 2
	acid_splash.name = "Acid Splash"

	spell_data._spell_dictionary = { magic_missile.id: magic_missile, acid_splash.id: acid_splash }

	# act
	var spell = spell_data.get_spell(magic_missile.id)

	# assert
	assert_same(spell, magic_missile)
