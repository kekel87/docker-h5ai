# <img src="https://www.docker.com/sites/default/files/Whale%20Logo332_5.png" width="40" height="30"/> Docker h5ai

[h5ai](http://larsjung.de/h5ai/) is a modern web server index.
This [docker](https://www.docker.io/) image makes it trivially easy to
spin up a webserver and start sharing your files through the web.

<img src="https://cloud.githubusercontent.com/assets/776829/3098666/440f3ca6-e5ef-11e3-8979-36d2ac1a36a0.png" />

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

You can alsow put a `_h5ai.header.html/_h5ai.footers.html` file in your mounted folder to display personal header and footers.

Fast build & test command :

```bash
docker build -t kekel87/docker-h5ai . && \
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
