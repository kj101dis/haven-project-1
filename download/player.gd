extends CharacterBody2D

signal hearts_changed(count)

@export var speed := 250.0
@export var jump_velocity := -450.0
@export var fall_limit := 760.0   # y position where you count as "fell off"

var hearts := 0
var checkpoint := Vector2.ZERO
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready() -> void:
	checkpoint = global_position
	hearts_changed.emit(hearts)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if (Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up")) and is_on_floor():
		velocity.y = jump_velocity

	var dir := Input.get_axis("ui_left", "ui_right")
	velocity.x = dir * speed
	if dir != 0:
		$Sprite2D.flip_h = dir < 0

	move_and_slide()

	if global_position.y > fall_limit:
		die()


func add_heart(pos: Vector2) -> void:
	hearts += 1
	checkpoint = pos
	hearts_changed.emit(hearts)


func die() -> void:
	if hearts > 0:
		hearts -= 1
		hearts_changed.emit(hearts)
		global_position = checkpoint
		velocity = Vector2.ZERO
	else:
		get_tree().reload_current_scene()
