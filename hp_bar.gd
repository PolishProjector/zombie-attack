extends CanvasLayer

@onready var bar : ProgressBar = $bar


func _ready():
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.hp_changed.connect(_on_hp_changed)
		bar.max_value = player.max_hp

func _on_hp_changed(new_hp):
	bar.value = new_hp
