FROM crashvb/supervisord:202201080446@sha256:8fe6a411bea68df4b4c6c611db63c22f32c4a455254fa322f381d72340ea7226
ARG org_opencontainers_image_created=undefined
ARG org_opencontainers_image_revision=undefined
LABEL \
	org.opencontainers.image.authors="Richard Davis <crashvb@gmail.com>" \
	org.opencontainers.image.base.digest="sha256:8fe6a411bea68df4b4c6c611db63c22f32c4a455254fa322f381d72340ea7226" \
	org.opencontainers.image.base.name="crashvb/supervisord:202201080446" \
	org.opencontainers.image.created="${org_opencontainers_image_created}" \
	org.opencontainers.image.description="Image containing smbd." \
	org.opencontainers.image.licenses="Apache-2.0" \
	org.opencontainers.image.source="https://github.com/crashvb/smbd-docker" \
	org.opencontainers.image.revision="${org_opencontainers_image_revision}" \
	org.opencontainers.image.title="crashvb/smbd" \
	org.opencontainers.image.url="https://github.com/crashvb/smbd-docker"

# Install packages, download files ...
RUN docker-apt samba

# Configure: samba
ENV SAMBA_CONFIG=/etc/samba SAMBA_DATA=/var/lib/samba SAMBA_GID=500 SAMBA_NAME=samba SAMBA_UID=500
COPY samba-* /usr/local/bin/
RUN groupadd --gid=${SAMBA_GID} --system ${SAMBA_NAME} && \
	useradd --create-home --gid=${SAMBA_GID} --shell=/usr/bin/nologin --system --uid=${SAMBA_UID} ${SAMBA_NAME} && \
	install --directory --group=root --mode=0775 --owner=root ${SAMBA_CONFIG}/conf.d/ /usr/local/share/samba && \
	cp --preserve ${SAMBA_CONFIG}/smb.conf ${SAMBA_CONFIG}/smb.conf.dist && \
	mv ${SAMBA_CONFIG} /usr/local/share/samba/config && \
	mv ${SAMBA_DATA} /usr/local/share/samba/data

# Configure: supervisor
COPY supervisord.samba.conf /etc/supervisor/conf.d/samba.conf

# Configure: entrypoint
COPY entrypoint.samba /etc/entrypoint.d/samba

# Configure: healthcheck
COPY healthcheck.samba /etc/healthcheck.d/samba

EXPOSE 137/udp 138/udp 139/tcp 445/tcp

VOLUME ${SAMBA_CONFIG} ${SAMBA_DATA}
