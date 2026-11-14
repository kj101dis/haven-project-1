extends Area2D

# Set Next Level in the Inspector (e.g. res://level2.tscn).
# If left empty, touching the flag just restarts this level.
@export_file("*.tscn") var next_level: String


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if not body.is_in_group("player"):
		return
	if next_level != "":
		get_tree().change_scene_to_file.call_deferred(next_level)
	else:
		get_tree().reload_current_scene.call_deferred()
