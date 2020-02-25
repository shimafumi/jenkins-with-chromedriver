FROM jenkins/jenkins

USER root

RUN apt-get update && \
        apt-get install -y unzip xvfb libxi6 libgconf-2-4

RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add && \
        echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
        apt-get -y update && \
        apt-get -y install google-chrome-stable

RUN CHROMEDRIVER_VERSION=`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`

RUN wget https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip && \
        unzip chromedriver_linux64.zip && \
        mv chromedriver /usr/bin/chromedriver && \
        chown root:root /usr/bin/chromedriver && \
        chmod +x /usr/bin/chromedriver

RUN wget https://oscdl.ipa.go.jp/IPAexfont/IPAexfont00301.zip
RUN unzip IPAexfont00301.zip -d /usr/share/fonts/
RUN fc-cache -fv

USER jenkins
