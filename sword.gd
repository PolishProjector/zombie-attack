

extends Area2D
@onready var col = $CollisionShape2D

func _ready():
	col.disabled = true
	monitoring = false

func do_attack():
	col.disabled = false
	monitoring = true
	print("MIECZ WŁĄCZONY")
	await get_tree().create_timer(0.15).timeout
	col.disabled = true
	monitoring = false
	print("MIECZ WYŁĄCZONY")

func _on_body_entered(body):
	if body.is_in_group("zombie"):
		print("TRAFIONY PO KLIKU!")
		body.queue_free()
