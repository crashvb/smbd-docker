# smbd-docker

## Overview

This docker image contains [Samba](https://www.samba.org/).

## Entrypoint Scripts

### samba

The embedded entrypoint script is located at `/etc/entrypoint.d/samba` and performs the following actions:

1. A new samba configuration is generated using the following environment variables:

 | Variable | Default Value | Description |
 | -------- | ------------- | ----------- |
 | SAMBA_CONF | | If defined, this value will be written to `<samba_conf>/smb.conf`. |
 | SAMBA_CONFD_* | | The contents of `<samba_conf>/conf.d/*.conf`. For example, `SAMBA_CONFD_FOO` will create `<samba_conf>/conf.d/foo.conf`. The contents of this directory will be used to generate `<samba_config>/smb-confd.conf` and will be included at the bottom of `<samba_conf>/smb.conf`. |
 | SAMBA_GID | 500 | Group ID of the samba user. |
 | SAMBA_NAME | samba | Name of the samba user. |
 | SAMBA_UID | 500 | User ID of the samba user. |

## Healthcheck Scripts

### samba

The embedded healthcheck script is located at `/etc/healthcheck.d/samba` and performs the following actions:

1. Verifies that the smbd process exists.

## Standard Configuration

### Container Layout

```
/
└─ etc/
   ├─ samba/
   ├─ entrypoint.d/
   │  └─ samba
   └─ healthcheck.d/
      └─ samba
```

### Exposed Ports

* `137/udp` - NetBIOS name service.
* `138/udp` - NetBIOS datagram.
* `139/tcp` - NetBIOS session.
* `445/tcp` - SMB over TCP.

### Volumes

* `/etc/samba` - samba configuration directory.

## Development

[Source Control](https://github.com/crashvb/smbd-docker)

