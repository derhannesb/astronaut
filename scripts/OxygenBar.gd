extends ProgressBar

func _ready():
	set_process(true)

func _process(delta):
	set_value(GameState.oxygen)
