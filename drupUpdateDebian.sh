#!/bin/bash
function isinstalled {
	if apt -q list installed $pack &>/dev/null; then
		true
	else
		false
  	fi
}

function isinstalled2 {
	$pack --version > /dev/null 2>&1
	DRUSH=$?
	if [[ $DRUSH -ne 0 ]]; then 
		false
	else
		true
	fi
}

#clear
echo "Se revisa si existen las siguientes dependencias..."
if isinstalled git; then
	echo `git --version`
else
	echo "No se encuentra instalado git. Instalando"
	apt install git
fi
if isinstalled composer; then
	echo `composer --version`
else
	echo "No se encuentra instalado composer. Instalando"
	sudo apt install curl
	#Obteniendo composer
	curl -sS https://getcomposer.org/installer | php
	sudo mv composer.phar /usr/local/bin/composer
	composer --version
fi
if isinstalled2 drush; then
	echo `drush --version`
else
	echo "No se encuentra instalado git. Instalando"
	wget https://github.com/drush-ops/drush/releases/download/8.0.1/drush.phar
	php drush.phar core-status
	chmod +x drush.phar
	sudo mv drush.phar /usr/local/bin/drush
	echo $PATH
	drush init
fi

echo "Se procede a realizar el backup de /var/www. Esto puede tardar unos minutos".
FILE="/home/backup.$NOW.tar.gz"
sudo tar -czvf $FILE /var/www

#Para actualización drupal
drush up --yes

