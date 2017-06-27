FROM centos:7

RUN yum install epel-release -y 

RUN yum install nodejs  -y

RUN npm -v

MAINTAINER linfeiyang <329379172@qq.com>

#ENV VARIABLES
ENV GHOST_SOURCE /usr/src/app
#ENV GHOST_CONTENT /var/lib/ghost
ENV GHOST_VERSION 0.11.10

#Change WORKDIR to ghost directory
WORKDIR $GHOST_SOURCE

RUN yum install gcc make python wget unzip -y && wget -O ghost.zip "https://github.com/TryGhost/Ghost/releases/download/${GHOST_VERSION}/Ghost-${GHOST_VERSION}.zip"

RUN unzip ghost.zip 
RUN npm install --production && rm ghost.zip 

RUN yum remove gcc make pythong wget unzip -y


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
