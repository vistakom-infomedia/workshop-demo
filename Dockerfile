FROM vistakom/guestbook-gke-tutorial:1.0

# RUN  apt-get update 
 LABEL maintener="Vistakom Infomedia"
 #RUN  apt-get update -y
 #RUN  apt-get install -y iputils-ping 
 #RUN  apt upgrade -y

COPY src /var/www/html

RUN useradd -ms /bin/bash admin
USER admin

WORKDIR /var/www/html
