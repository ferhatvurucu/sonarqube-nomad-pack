# sonarqube-nomad-pack

This pack contains a service job that runs Sonarqube in Nomad. It currently supports being run by the [Docker](https://www.nomadproject.io/docs/drivers/docker) driver.

## Requirements

Clients that expect to run this job require:
- [Docker volumes](https://www.nomadproject.io/docs/drivers/docker "Docker volumes") to be enabled within their Docker plugin stanza, due to the usage of Nomad's host volume:
```hcl
plugin "docker" {
  config {
    volumes {
      enabled = true
    }
  }
}
```

- [Host volume](https://www.nomadproject.io/docs/configuration/client#host_volume-stanza "Host volume") to be enabled in the client configuration (the host volume directory - /opt/sonarqube/data - must be created in advance):
```hcl
client {
  host_volume "sonarqube" {
    path      = "/opt/sonarqube/data"
    read_only = false
  }
}
```

## Variables

- `job_name` (string) - The name to use as the job name which overrides using the pack name.
- `region` (string) - The region where the job should be placed.
- `datacenters` (list of strings) - A list of datacenters in the region which are eligible for task placement.
- `namespace` (string) - The namespace where the job should be placed.
- `constraints` (list of objects) - Constraints to apply to the entire job.
- `image_name` (string) - The docker image name.
- `image_tag` (string) - The docker image tag.
- `task_resources` (object, number number) - Resources used by sonarqube task.
- `register_consul_service` (bool) - If you want to register a consul service for the job.
- `consul_service_name` (string) - The consul service name for the application.
- `consul_service_tags` (list of strings) - The consul service name for the application.
- `volume_name` (string) - The name of the volume you want Sonarqube to use.
- `volume_type` (string) - The type of the volume you want Sonarqube to use.
- `sonarqube_env_vars` (map of strings) - Environment variables to pass to Docker container.

## Environment variables

The embedded H2 database is used by default. It is recommended for tests but not for production use. Additional environment variables can be passed to nomad-pack for production use.

```
sonarqube_env_vars = [
  {
    key = "SONAR_JDBC_URL"
    value = "database connection URL"
  },
  {
    key = "SONAR_JDBC_USERNAME"
    value = "sonar"
  },
  {
    key = "SONAR_JDBC_PASSWORD"
    value = "sonar"
  }
]
```

## Deploy

```
# add custom registry to your local Nomad Pack
nomad-pack registry add my_packs https://github.com/ferhatvurucu/sonarqube-nomad-pack

# deploy your custom pack
nomad-pack run sonarqube --registry=my_packs
```

## References

- [Nomad Pack](https://learn.hashicorp.com/collections/nomad/nomad-pack)
