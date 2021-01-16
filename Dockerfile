FROM vistakom/guestbook-gke-tutorial:1.0

COPY src /var/www/html

RUN apt-get dist-upgrade -y
# RUN  apt-get update 
# RUN  apt upgrade -y
# RUN  apt-get install -y iputils-ping 

WORKDIR /var/www/html

