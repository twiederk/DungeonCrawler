class_name SpellData
extends RefCounted

var _spell_dictionary = {}


func _parse_spell(line: PackedStringArray) -> SpellResource:
	var spell = SpellResource.new()
	spell.id = line[0].to_int()
	spell.name = line[1]
	spell.range = line[2].to_int()
	
	var damage = Damage.new()
	damage.number_of_dice = line[3]
	damage.die = line[4]
	spell.damage = damage
	
	spell.texture = load("res://Assets/graphics/sprites/spells/" + line[5])

	return spell


func _load_spells(file_name: String) -> Array[SpellResource]:
	var spells: Array[SpellResource] = []
	var file: FileAccess = FileAccess.open(file_name, FileAccess.READ)
	file.get_csv_line()
	var line: PackedStringArray = file.get_csv_line()
	while line.size() > 1:
		spells.append(_parse_spell(line))
		line = file.get_csv_line()
	return spells


func _create_spell_dictionary(spells: Array[SpellResource]) -> Dictionary:
	var spell_dictionary = {}
	for spell in spells:
		spell_dictionary[spell.id] = spell
	return spell_dictionary


func init():
	var spells = _load_spells("res://World/Spells/SpellData.txt")
	_spell_dictionary = _create_spell_dictionary(spells)


func get_spell(id: int) -> SpellResource:
	return _spell_dictionary[id]
