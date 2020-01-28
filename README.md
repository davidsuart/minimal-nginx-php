
# minimal-nginx.php

A minimal example of dockerised nginx-php

## About

- Based on nginx:alpine
- All access/error logging (nginx/php) in this container is disabled
- Has a single php page presented on port 8080

## Usage

Build and run it locally (Mapping port 8080 on the host to 80 in the container):
```shell
$ git clone https://github.com/davidsuart/awesome-envvars.git
$ docker build --no-cache --tag awesome-envvars github.com/davidsuart/awesome-envvars
$ docker run --publish 8080:80 awesome-envvars
```

## License

MIT license. See [LICENSE](LICENSE) for full details.
