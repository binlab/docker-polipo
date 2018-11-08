# Polipo — a caching HTTP web proxy in Docker

[Pilipo](https://hub.docker.com/r/binlab/polipo) is a small and fast
caching web proxy (a web cache, an HTTP proxy, a proxy server). While
Polipo was designed to be used by one person or a small group of people,
there is nothing that prevents it from being used by a larger group.

Polipo is originally developed by
[Juliusz Chroboczek](https://www.irif.fr/~jch/software/polipo/)

## Usage cases

Running a `Polipo` in `Docker` brings a lot of benefits, we can run
many services for separate persons of system services. Also, `Docker`
provide full isolation from a host for safe use.

## Usage

### 1. Run Polipo with default settings

#### **_Be careful, in this case, Polipo will be available for all on the Internet without any restriction!_**

Docker example:

```bash
$ docker run \
    --rm \
    --name polipo \
    -p 38123:8123/tcp \
    binlab/polipo
```

Docker-compose example:

```yaml
version: '3.3'

services:

  polipo:
    image: binlab/polipo
    container_name: polipo
    hostname: polipo
    restart: always
    ports:
      - 38123:8123/tcp
    volumes:
      - polipo-cache:/var/cache/polipo:rw
      - polipo-www:/usr/share/polipo/www:ro
    networks:
      - polipo

volumes:
  polipo-cache:
  polipo-www:

networks:
  polipo:
    driver: bridge
```

And then checking a Polipo works:

```bash
$ curl --proxy http://192.168.1.12:38123 https://api.ipify.org/
```

\* _You should change `192.168.1.12` to your `<host_ip>`_

### 2. Run Polipo with more security settings

Docker example:

```bash
$ docker run \
    --rm \
    --name polipo \
    -p 38123:8123/tcp \
    binlab/polipo \
    'proxyName=MyProxy' \
    'displayName=MyProxy' \
    'proxyAddress=0.0.0.0' \
    'proxyPort=8123' \
    'allowedClients=192.168.1.0/24,192.168.5.100' \
    'authCredentials=UserName:MySuperPasswordHere'
```

Docker-compose example:

```yaml
version: '3.3'

services:

  polipo:
    image: binlab/polipo
    container_name: polipo
    hostname: polipo
    restart: always
    command: |
      proxyName="MyProxy"
      displayName="MyProxy"
      proxyAddress="0.0.0.0"
      proxyPort="8123"
      allowedClients="192.168.1.0/24,192.168.5.100"
      authCredentials="UserName:MySuperPasswordHere"
    ports:
      - 38123:8123/tcp
    volumes:
      - polipo-cache:/var/cache/polipo:rw
      - polipo-www:/usr/share/polipo/www:ro
    networks:
      - polipo

volumes:
  polipo-cache:
  polipo-www:

networks:
  polipo:
    driver: bridge
```

And then checking a Polipo works:

```bash
$ curl --proxy http://UserName:MySuperPasswordHere@192.168.1.12:38123 https://api.ipify.org/
```

\* _You should change `192.168.1.12` to your `<host_ip>`_

### 2. Run Polipo with more security settings

Docker example:

```bash
$ docker run \
    --rm \
    --name polipo \
    -p 38123:8123/tcp \
    binlab/polipo \
    'proxyName=MyProxy' \
    'displayName=MyProxy' \
    'proxyAddress=0.0.0.0' \
    'proxyPort=8123' \
    'allowedClients=192.168.1.0/24,192.168.5.100' \
    'authCredentials=UserName:MySuperPasswordHere'
```

Docker-compose example:

```yaml
version: '3.3'

services:

  polipo:
    image: binlab/polipo
    container_name: polipo
    hostname: polipo
    restart: always
    command: |
      proxyName="MyProxy"
      displayName="MyProxy"
      proxyAddress="0.0.0.0"
      proxyPort="8123"
      allowedClients="192.168.1.0/24,192.168.5.100"
      authCredentials="UserName:MySuperPasswordHere"
    ports:
      - 38123:8123/tcp
    volumes:
      - polipo-cache:/var/cache/polipo:rw
      - polipo-www:/usr/share/polipo/www:ro
    networks:
      - polipo

volumes:
  polipo-cache:
  polipo-www:

networks:
  polipo:
    driver: bridge
```

And then checking a Polipo works:

```bash
$ curl --proxy http://UserName:MySuperPasswordHere@192.168.1.12:38123 https://api.ipify.org/
```

\* _You should change `192.168.1.12` to your `<host_ip>`_

### 3. Run Polipo without caching

Docker example:

```bash
$ docker run \
    --rm \
    --name polipo \
    -p 38123:8123/tcp \
    binlab/polipo \
    'proxyName=MyProxy' \
    'displayName=MyProxy' \
    'proxyAddress=0.0.0.0' \
    'proxyPort=8123' \
    'allowedClients=192.168.1.0/24,192.168.5.100' \
    'authCredentials=UserName:MySuperPasswordHere' \
    'diskCacheRoot=' \
    'localDocumentRoot='
```

Docker-compose example:

```yaml
version: '3.3'

services:

  polipo:
    image: binlab/polipo
    container_name: polipo
    hostname: polipo
    restart: always
    command: |
      proxyName="MyProxy"
      displayName="MyProxy"
      proxyAddress="0.0.0.0"
      proxyPort="8123"
      allowedClients="192.168.1.0/24,192.168.5.100"
      authCredentials="UserName:MySuperPasswordHere"
      diskCacheRoot=""
      localDocumentRoot=""
    ports:
      - 38123:8123/tcp
    networks:
      - polipo

networks:
  polipo:
    driver: bridge
```
