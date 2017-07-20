# Docker h5ai

[h5ai](http://larsjung.de/h5ai/) is a modern web server index.
This [docker](https://www.docker.io/) image makes it trivially easy to
spin up a webserver and start sharing your files through the web.

The recommended way to run this container looks like this:
```bash
docker run -d \
  --restart=always \
  --name h5ai \
  -p 80:80 \
  -v $PWD:/var/www \
  kekel87/docker-h5ai
```

You can now point your webbrowser to this URL:
```
http://localhost/
```

You can alsow override h5ai options.json file :
```bash
docker run -d \
  --restart=always \
  --name h5ai \
  -p 80:80 \
  -v $PWD:/var/www \
  -v $PWD/your-options.json:/usr/share/h5ai/_h5ai/private/conf/options.json \
  kekel87/docker-h5ai
```

Fast build & test command :
```bash
docker build -t kekel87/docker-h5ai .  && \
docker stop h5ai && docker rm h5ai && \
docker run -d \
  --restart=always \
  --name h5ai \
  -p 80:80 \
  -v $PWD:/var/www \
  kekel87/docker-h5ai  && \
docker logs h5ai -f
```


Thx :
- [h5ai](http://larsjung.de/h5ai/)
- [flip-bs/docker-h5ai](https://github.com/flip-bs/docker-h5ai)
- [clue/docker-h5ai](https://github.com/clue/docker-h5ai)
- [CoRfr/docker-h5ai](https://github.com/CoRfr/docker-h5ai)