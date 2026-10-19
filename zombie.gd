

extends CharacterBody2D

@export var speed = 150.0
@export var stop_distance = 20.0
@export var attack_damage = 10
@export var attack_range = 30.0
@export var attack_cooldown = 1.0

var player = null
var can_attack = true

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta):
	if not player:
		return
	
	var to_player = player.global_position - global_position
	var distance = to_player.length()
	
	if distance <= attack_range:
		velocity = Vector2.ZERO
		if can_attack:
			attack()
	else:
		if distance > stop_distance:
			velocity = to_player.normalized() * speed
		else:
			velocity = Vector2.ZERO
	
	move_and_slide()

func attack():
	can_attack = false
	print("Zombie bije! ", attack_damage)
	
	# zadaj dmg playerowi - musi mieć funkcję take_damage
	if player.has_method("take_damage"):
		player.take_damage(attack_damage)
	
	await get_tree().create_timer(attack_cooldown).timeout
	can_attack = true

func died():
	queue_free()
