extends Panel


var thing: Thing = null setget set_thing
var amount := 0 setget set_amount
var icon

var _style = StyleBoxFlat.new()
var _blinking := true


func set_thing(new_thing):
	thing = new_thing
	
	if new_thing != null:
		blink()


func set_amount(new_amount):
	var old_amount = amount
	amount = new_amount
	
	if amount <= 0:
		thing = null
		$AmountLabel.visible = false
	else:
		$AmountLabel.visible = true
		$AmountLabel.text = str(amount)
	
	if new_amount > old_amount:
		blink()
	blink()


func blink():
	add_stylebox_override("panel", _style)
	set_process(true)
	_blinking = true
	yield(get_tree().create_timer(1), "timeout")
	_blinking = false
	set_process(false)


func _process(delta):
	if _blinking:
		var color = Color(0.5*sin(OS.get_ticks_msec()/100.0)+0.5, 0, 0)
		_style.set_bg_color(color)
		update()
