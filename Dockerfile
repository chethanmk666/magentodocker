FROM ubuntu
ENV DEBIAN_FRONTEND=nonintercative
ARG USER=docker
ARG UID=1000
ARG GID=1000
RUN apt-get update && apt-get install -y software-properties-common curl
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update && apt-get install php8.1 -y
RUN apt-get update && apt-get install -y php-mysql php-xml php-intl php-curl php-bcmath php-gd php-mbstring php-soap php-zip composer
RUN apt-get update && apt-get install -y php-xdebug
RUN echo "xdebug.remote_enable=on" >> /etc/php/8.1/mods-available/xdebug.ini
RUN echo "xdebug.remote_autostart=on" >> /etc/php/8.1/mods-available/xdebug.ini
RUN apt-get update && apt-get install -y mysql-client
RUN groupadd --gid $GID $USER && useradd -s /bin/bash --uid $UID --gid $GID -m $USER && apt-get install -y sudo && echo "$USER ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USER \
&& chmod 0440 /etc/sudoers.d/$USER
USER ${UID}:${GID}
WORKDIR /workspaces/magento-demo
CMD ["sleep", "infinity"]
