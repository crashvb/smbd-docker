FROM crashvb/supervisord:202103212252
LABEL maintainer "Richard Davis <crashvb@gmail.com>"

# Install packages, download files ...
RUN docker-apt samba

# Configure: samba
ENV SAMBA_CONFIG=/etc/samba SAMBA_GID=500 SAMBA_NAME=samba SAMBA_UID=500
ADD samba-* /usr/local/bin/
RUN groupadd --gid=${SAMBA_GID} --system ${SAMBA_NAME} && \
	useradd --create-home --gid=${SAMBA_GID} --shell=/usr/bin/nologin --system --uid=${SAMBA_UID} ${SAMBA_NAME} && \
	install --directory --group=root --mode=0775 --owner=root ${SAMBA_CONFIG}/conf.d/ /usr/local/share/samba && \
	cp --preserve ${SAMBA_CONFIG}/smb.conf ${SAMBA_CONFIG}/smb.conf.dist && \
	mv ${SAMBA_CONFIG} /usr/local/share/samba/config

# Configure: supervisor
ADD supervisord.samba.conf /etc/supervisor/conf.d/samba.conf

# Configure: entrypoint
ADD entrypoint.samba /etc/entrypoint.d/samba

# Configure: healthcheck
ADD healthcheck.samba /etc/healthcheck.d/samba

EXPOSE 137/udp 138/udp 139/tcp 445/tcp

VOLUME ${SAMBA_CONFIG}
