extends Node2D

var level: int = 1
var score: int = 0
var current_level_root: Node = null
var score_label: Label = null
var level_label: Label = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Setup the level
	current_level_root = get_node("levelroot")
	_load_level(level)

#levelmanage

func _load_level(level_number: int) -> void:
	if level_number > 3:
		level_number = 1
		level = 1
		print("Semua level selesai! Kembali ke level 1.")
	if current_level_root:
		current_level_root.queue_free()

	#change level
	var level_path = "res://scenes/level%s.tscn" % level_number
	current_level_root = load(level_path).instantiate()
	add_child(current_level_root)
	current_level_root.name = "levelroot"
	_setup_level(current_level_root)
	_setup_hud(current_level_root)

func _setup_hud(level_root: Node) -> void:
	score_label = level_root.get_node_or_null("HUD/ScorePanel/ScoreLabel")
	level_label = level_root.get_node_or_null("HUD/LevelPanel/LevelLabel")
	_update_hud()

func _update_hud() -> void:
	if score_label:
		score_label.text = "%s" % score
	if level_label:
		level_label.text = "LEVEL %s" % level

func _setup_level(level_root: Node) -> void:
	#connectexit
	var exit = level_root.get_node_or_null("Exit")
	if exit:
		exit.body_entered.connect(_on_exit_body_entered)
	#connectbeer
	var beer = level_root.get_node_or_null("beers")
	if beer:
		for beers in beer.get_children():
			beers.collected.connect(increase_score)

# score
func increase_score () -> void:
	score += 1
	_update_hud()


#signal
func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		level += 1
		body.can_move = false
		call_deferred("_load_level",level)
