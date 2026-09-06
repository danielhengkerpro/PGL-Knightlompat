extends Node2D
@onready var score_label: Label = $HUD/ScorePanel/ScoreLabel
var score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _setup_level() -> void:
	#connectbeer
	var beer = $levelroot.get_node_or_null("beers")
	if beer:
		for beers in beer.get_children():
			beers.collected.connect(increase_score)
			
# score
func increase_score () -> void:
	score += 1
	score_label.text = "SCORE: %s" % score
