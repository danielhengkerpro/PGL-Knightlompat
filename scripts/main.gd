extends Node2D
@onready var score_label: Label = $HUD/ScorePanel/ScoreLabel

var level: int = 1
var score: int = 0
var current_level_root: Node = null	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Setup the level
	current_level_root = get_node("levelroot")
	_load_level(level)

#levelmanage

func _load_level(level_number: int) -> void:
	if current_level_root:
		current_level_root.queue_free()
		
		#change level
		var level_path = "res://scenes/level%s.tscn" % level_number
		current_level_root = load(level_path).instantiate()
		add_child(current_level_root)
		current_level_root.name = "levelroot"
		_setup_level(current_level_root)

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
	score_label.text = "SCORE: %s" % score


#signal
func _on_exit_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		level += 1
		body.can_move = false
		call_deferred("_load_level",level)
