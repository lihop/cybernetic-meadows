extends Sprite

export(Resource) var stats

func _ready():
	if stats:
		print(stats.name)
