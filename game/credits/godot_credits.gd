extends Node2D

const section_time := 2.0
const line_time := 0.3
const base_speed := 100
const speed_up_multiplier := 10.0
const title_color := Color.blueviolet

var music = [
	preload("res://credits/assets/Loneload-Free_Software_Song.ogg"),
	preload("res://credits/assets/markushaist-free-software-song.ogg")
]
var curr_track := 0

var scroll_speed := base_speed
var speed_up := false

onready var line := $CreditsContainer/Line
var started := false
var finished := false

var section
var section_next := true
var section_timer := 0.0
var line_timer := 0.0
var curr_line := 0
var lines := []

var credits = [
	[
		"A game by Leroy Hopson"
	]
]


func list_names(people: Array) -> String:
	var names := PoolStringArray()
	
	for person in people:
		if person is PersonCredit:
			if person.name and person.nickname:
				name = "%s (%s)" % [person.name, person.nickname]
			else:
				name = person.name if person.name else person.nickname
		names.append(name)
	
	return names.join(", ")


func list_licenses(licenses: Array, list_free_only: bool = true) -> String:
	var license_names := PoolStringArray()
	
	for license in licenses:
		if license is License:
			if list_free_only and not license.free:
				continue
			else:
				license_names.append("%s (%s)" % [license.full_name,
						license.id])
	
	return license_names.join(",\n")


func has_free_license(licenses: Array) -> bool:
	for license in licenses:
		if license.free:
			return true
	return false


func _ready():
	if not music.empty():
		$AudioStreamPlayer.stream = music[curr_track]
		$AudioStreamPlayer.play()
	
	credits.append(['Art'])
	
	for art_work in $CreditsGenerator.get_art_works():
		var art: ArtCredit = art_work
		var credit := []
		credit.append(art.title if art.title else "[Untitled]")
		if not art.authors.empty():
			credit.append("By %s" % list_names(art.authors))
		if not art.other_contributors.empty():
			credit.append("Contributions by %s" % list_names(art.other_contributors))
		if not art.commissioners.empty():
			credit.append("Commissioned by %s" % list_names(art.commissioners))
		if not art.licenses.empty() and has_free_license(art.licenses):
			var first := true
			for license in list_licenses(art.licenses).split("\n"):
				if first:
					credit.append("Licensed under %s" % license)
					first = false
				else:
					credit.append(license)
		if not art.sources.empty():
			credit.append("Taken from %s" % art.sources[0])
		if not credit.empty():
			credits.append(credit)
	
	credits.append(['Music'])
	
	for musical_work in $CreditsGenerator.get_musical_works():
		var music: MusicCredit = musical_work
		var credit := []
		credit.append(music.title if music.title else "[Untitled]")
		if not music.writers.empty():
			credit.append("Written by %s" % list_names(music.writers))
		if not music.composers.empty():
			credit.append("Composed by %s" % list_names(music.composers))
		if not music.lyricists.empty():
			credit.append("Lyrics by %s" % list_names(music.lyricists))
		if not music.performers.empty():
			credit.append("Performed by %s" % list_names(music.performers))
		if not music.licenses.empty() and has_free_license(music.licenses):
			credit.append("Licensed under %s" % list_licenses(music.licenses))
		if not music.sources.empty():
			credit.append("Taken from %s" % music.sources[0])
		if not credit.empty():
			credits.append(credit)
	
	credits.append(['Sound Effects'])
	
	for sfx_work in $CreditsGenerator.get_sfx_works():
		var sfx: SFXCredit = sfx_work
		var credit := []
		credit.append(sfx.title if sfx.title else "[Untitled]")
		if not sfx.authors.empty():
			credit.append("By %s" % list_names(sfx.authors))
		if not sfx.licenses.empty() and has_free_license(sfx.licenses):
			credit.append("Licensed under %s" % list_licenses(sfx.licenses))
		if not sfx.sources.empty():
			credits.append("Taken from %s" % sfx.sources[0])
		if not credit.empty():
			credits.append(credit)
	
	credits.append(['END'])


func _process(delta):
	var scroll_speed = base_speed * delta
	
	if section_next:
		section_timer += delta * speed_up_multiplier if speed_up else delta
		if section_timer >= section_time:
			section_timer -= section_time
			
			if credits.size() > 0:
				started = true
				section = credits.pop_front()
				curr_line = 0
				add_line()
	
	else:
		line_timer += delta * speed_up_multiplier if speed_up else delta
		if line_timer >= line_time:
			line_timer -= line_time
			add_line()
	
	if speed_up:
		scroll_speed *= speed_up_multiplier
	
	if lines.size() > 0:
		for l in lines:
			l.rect_position.y -= scroll_speed
			if l.rect_position.y < -l.get_line_height():
				lines.erase(l)
				l.queue_free()
	elif started:
		finish()


func finish():
	if not finished:
		finished = true
		# NOTE: This is called when the credits finish
		# - Hook up your code to return to the relevant scene here, eg...
		#get_tree().change_scene("res://scenes/MainMenu.tscn")


func add_line():
	var new_line = line.duplicate()
	new_line.text = section.pop_front()
	lines.append(new_line)
	if curr_line == 0:
		new_line.add_color_override("font_color", title_color)
	$CreditsContainer.add_child(new_line)
	
	if section.size() > 0:
		curr_line += 1
		section_next = false
	else:
		section_next = true


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		finish()
	if event.is_action_pressed("ui_down") and !event.is_echo():
		speed_up = true
	if event.is_action_released("ui_down") and !event.is_echo():
		speed_up = false


func _on_AudioStreamPlayer_finished():
	curr_track += 1
	if curr_track < music.size():
		$AudioStreamPlayer.stream = music[curr_track]
		$AudioStreamPlayer.play()
