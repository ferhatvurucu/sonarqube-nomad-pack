// allow nomad-pack to set the job name

[[- define "job_name" -]]
[[- if eq .mongo_backup.job_name "" -]]
[[- .nomad_pack.pack.name | quote -]]
[[- else -]]
[[- .mongo_backup.job_name | quote -]]
[[- end -]]
[[- end -]]

// only deploys to a region if specified

[[- define "region" -]]
[[- if not (eq .mongo_backup.region "") -]]
region = [[ .mongo_backup.region | quote]]
[[- end -]]
[[- end -]]