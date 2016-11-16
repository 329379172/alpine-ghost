FROM alpine:3.4 

MAINTAINER linfeiyang <329379172@qq.com>

ENV GHOST_SOURCE /usr/src/app

ENV GHOST_VERSION 0.11.3

#Change WORKDIR to ghost directory
WORKDIR $GHOST_SOURCE

RUN apk --no-cache add nodejs

RUN apk --no-cache add tar gcc make python wget unzip ca-certificates \
	&& wget -O ghost.zip "https://ghost.org/archives/ghost-${GHOST_VERSION}.zip" \
	&& unzip ghost.zip
RUN wget -O node.tar.gz "https://nodejs.org/dist/v6.9.0/node-v6.9.0-linux-x64.tar.gz" \
	&& tar zxvf node.tar.gz && mv node-v6.9.0-linux-x64/* /usr/local/ && rm -rf node
RUN	npm install --production \
	&& rm ghost.zip \
	&& apk del gcc make python wget unzip ca-certificates bash\
	&& npm cache clean \
	&& rm -rf /tmp/npm*

#Copy over our configuration filename
COPY ./config.js $GHOST_SOURCE
COPY ./default.hbs $GHOST_SOURCE/content/themes/casper

COPY ./fonts.css $GHOST_SOURCE/content/themes/casper/assets/css/fonts.css
COPY ./monokai_sublime.min.css $GHOST_SOURCE/content/themes/casper/assets/css/monokai_sublime.min.css
COPY ./highlight.min.js $GHOST_SOURCE/content/themes/casper/assets/js/highlight.min.js
COPY ./jquery.min.js $GHOST_SOURCE/content/themes/casper/assets/js/jquery.min.js

#RUN mkdir -p $HOME

#Run Startup script
CMD ["/usr/local/bin/node", "index.js"]
