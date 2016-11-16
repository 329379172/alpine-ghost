FROM index.alauda.cn/linfeiyang/apline-perl

RUN apk add --no-cache nodejs

MAINTAINER linfeiyang <329379172@qq.com>

#ENV VARIABLES
ENV GHOST_SOURCE /usr/src/app
#ENV GHOST_CONTENT /var/lib/ghost
ENV GHOST_VERSION 0.11.0

#Change WORKDIR to ghost directory
WORKDIR $GHOST_SOURCE

RUN apk --no-cache add tar gcc make python wget unzip ca-certificates \
	&& wget -O ghost.zip "https://ghost.org/archives/ghost-${GHOST_VERSION}.zip" \
	&& unzip ghost.zip \
	&& npm install -g npm@latest \
    && npm install --production \
	&& rm ghost.zip \
	&& apk del gcc make python wget unzip ca-certificates \
	&& npm cache clean \
	&& rm -rf /tmp/npm*

#Copy over our configuration filename
COPY ./config.js $GHOST_SOURCE
COPY ./default.hbs $GHOST_SOURCE/content/themes/casper

COPY ./fonts.css $GHOST_SOURCE/content/themes/casper/assets/css/fonts.css
COPY ./monokai_sublime.min.css $GHOST_SOURCE/content/themes/casper/assets/css/monokai_sublime.min.css
COPY ./highlight.min.js $GHOST_SOURCE/content/themes/casper/assets/js/highlight.min.js
COPY ./jquery.min.js $GHOST_SOURCE/content/themes/casper/assets/js/jquery.min.js

#Copy over, and grant executable permission to the startup script
RUN mkdir -p $HOME

#Run Startup script
CMD ["npm", "start"]
