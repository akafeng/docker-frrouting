<h1 align="center">FRRouting</h1>

<p align="center">Internet routing protocol suite for Linux and Unix platforms.</p>

<p align="center">
    <a href="https://ghcr.io/akafeng/frrouting">Container Registry</a> ·
    <a href="https://github.com/FRRouting/frr">Project Source</a>
</p>

<p align="center">
    <img src="https://img.shields.io/github/actions/workflow/status/akafeng/docker-frrouting/push.yml?branch=main" />
    <img src="https://img.shields.io/github/last-commit/akafeng/docker-frrouting" />
    <img src="https://img.shields.io/github/v/release/akafeng/docker-frrouting" />
    <img src="https://img.shields.io/github/release-date/akafeng/docker-frrouting" />
</p>

---

### Pull The Image

```bash
$ docker pull ghcr.io/akafeng/frrouting
```

### Start Container

```bash
$ docker run -d \
  --volume=/etc/frr/:/etc/frr/ \
  --cap-add=NET_ADMIN \
  --cap-add=SYS_ADMIN \
  --network=host \
  --restart=unless-stopped \
  --name=frrouting \
  ghcr.io/akafeng/frrouting
```
