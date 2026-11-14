extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if body.has_method("add_heart"):
		body.add_heart(global_position)
		queue_free()
