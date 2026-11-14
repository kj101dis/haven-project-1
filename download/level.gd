extends Node2D
# Automatically finds your PNGs in the project folder by name:
#   background -> starts with "pixilart-drawing"
#   heart      -> starts with "Screenshot" and has "removebg" in the name
#   player     -> any other PNG with "removebg" in the name

const PLAYER_HEIGHT := 64.0
const HEART_SIZE := 36.0


func _ready() -> void:
	var bg_path := ""
	var player_path := ""
	var heart_path := ""
	for f in DirAccess.get_files_at("res://"):
		var fname: String = f.trim_suffix(".import")
		var lower := fname.to_lower()
		if not lower.ends_with(".png"):
			continue
		if lower.begins_with("screenshot") and "removebg" in lower:
			heart_path = "res://" + fname
		elif "removebg" in lower:
			player_path = "res://" + fname
		elif lower.begins_with("pixilart-drawing"):
			bg_path = "res://" + fname

	if bg_path != "":
		$Background/TextureRect.texture = load(bg_path)
	else:
		push_warning("Background PNG (pixilart-drawing...) not found in res://")

	if player_path != "":
		var t: Texture2D = load(player_path)
		var sprite: Sprite2D = $Player/Sprite2D
		sprite.texture = t
		var s := PLAYER_HEIGHT / float(t.get_height())
		sprite.scale = Vector2(s, s)
		var shape := $Player/CollisionShape2D.shape as RectangleShape2D
		shape.size = Vector2(t.get_width() * s * 0.7, PLAYER_HEIGHT - 4.0)
	else:
		push_warning("Player PNG (removebg) not found in res://")

	if heart_path != "":
		var h: Texture2D = load(heart_path)
		var s2 := HEART_SIZE / float(max(h.get_width(), h.get_height()))
		for heart in $Hearts.get_children():
			var spr: Sprite2D = heart.get_node("Sprite2D")
			spr.texture = h
			spr.scale = Vector2(s2, s2)
		$HUD/Box/HeartsPanel/Row/TextureRect.texture = h
	else:
		push_warning("Heart PNG (Screenshot...removebg) not found in res://")
