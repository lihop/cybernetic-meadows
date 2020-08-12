extends Node


var can_work := true
var idle := true

onready var subject = get_parent()


func _ready():
	if can_work:
		JobQueue.connect("job_added", self, "_on_job_added")


func _on_job_added(job: JobQueue.Job):
	if not can_work:
		return
	
	if not idle:
		pass
		# TODO: Decide whether or not to stop doing curent job
		# to do the new job.
	else:
		# TODO: Figure out if we should start the new job.
		match job.type:
			JobQueue.Job.JobType.CONSTRUCT:
				if subject.has_method("construct"):
					subject.construct(job.target)


func find_job():
	for job in JobQueue.jobs:
		if job.type == JobQueue.Job.JobType.CONSTRUCT:
			subject.construct(job.target)
			return
