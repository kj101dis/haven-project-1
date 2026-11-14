extends CanvasLayer

@export var level_number := 1

@onready var hearts_label: Label = $Box/HeartsPanel/Row/HeartsLabel
@onready var level_label: Label = $Box/LevelPanel/LevelLabel


func _ready() -> void:
	level_label.text = "Level %d" % level_number
	get_node("../Player").hearts_changed.connect(_on_hearts_changed)


func _on_hearts_changed(count: int) -> void:
	hearts_label.text = "x %d" % count
