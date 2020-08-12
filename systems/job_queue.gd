extends Node
# A data structure containing jobs for crew to perform.


signal job_added(job)
signal job_cancelled(job)

var jobs = []


func add_job(job: Job):
	jobs.append(job)
	emit_signal("job_added", job)


func cancel_job(job):
	var i = jobs.find(job)
	jobs.remove(i)
	emit_signal("job_cancelled", job)


class Job:
	extends Reference
	
	enum JobType {
		FIREFIGHT
		DOCTOR
		FLICK
		WARDEN
		HANDLE
		COOK
		CONSTRUCT
		GROW
		RESEARCH
		PLANT_CUT
		SMITH
		TAILOR
		ART
		CRAFT
		HAUL
		CLEAN
		RESEARCH
	}
	
	var target: Object
	var type: int
