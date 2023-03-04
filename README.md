# smbd-docker

[![version)](https://img.shields.io/docker/v/crashvb/smbd/latest)](https://hub.docker.com/repository/docker/crashvb/smbd)
[![image size](https://img.shields.io/docker/image-size/crashvb/smbd/latest)](https://hub.docker.com/repository/docker/crashvb/smbd)
[![linting](https://img.shields.io/badge/linting-hadolint-yellow)](https://github.com/hadolint/hadolint)
[![license](https://img.shields.io/github/license/crashvb/smbd-docker.svg)](https://github.com/crashvb/smbd-docker/blob/master/LICENSE.md)

## Overview

This docker image contains [Samba](https://www.samba.org/).

## Entrypoint Scripts

### samba

The embedded entrypoint script is located at `/etc/entrypoint.d/samba` and performs the following actions:

1. A new samba configuration is generated using the following environment variables:

 | Variable | Default Value | Description |
 | -------- | ------------- | ----------- |
 | SAMBA\_CONF | | If defined, this value will be written to `<samba_conf>/smb.conf`. |
 | SAMBA\_CONFD\_* | | The contents of `<samba_conf>/conf.d/*.conf`. For example, `SAMBA_CONFD_FOO` will create `<samba_conf>/conf.d/foo.conf`. The contents of this directory will be used to generate `<samba_config>/smb-confd.conf` and will be included at the bottom of `<samba_conf>/smb.conf`. |
 | SAMBA_GID | 500 | Group ID of the samba user. |
 | SAMBA_NAME | samba | Name of the samba user. |
 | SAMBA_UID | 500 | User ID of the samba user. |

## Standard Configuration

### Container Layout

```
/
├─ etc/
│  ├─ samba/
│  │  └─ conf.d/
│  ├─ entrypoint.d/
│  │  └─ samba
│  ├─ healthcheck.d/
│  │  └─ samba
│  └─ supervisor/
│     └─ config.d/
│        └─ samba.conf
└─ var/
   └─ lib/
      └─ samba/
```

### Exposed Ports

* `137/udp` - NetBIOS name service.
* `138/udp` - NetBIOS datagram.
* `139/tcp` - NetBIOS session.
* `445/tcp` - SMB over TCP.

### Volumes

* `/etc/samba` - samba configuration directory.
* `/var/lib/samba` - samba data directory.

## Development

[Source Control](https://github.com/crashvb/smbd-docker)

