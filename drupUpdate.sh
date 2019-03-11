#!/bin/bash
function isinstalled {
	if yum -q list installed $pack &>/dev/null; then
		#echo "Si existe $pack"
		true
	else
    		#echo "No existe"
		false
  	fi
}

function isinstalled2 {
	$pack --version > /dev/null 2>&1
	DRUSH=$?
	if [[ $DRUSH -ne 0 ]]; then 
		true
	else
		false
	fi
}

#clear
echo "Se revisa si existen las siguientes dependencias..."
if isinstalled git; then
	echo `git --version`
else
	echo "No se encuentra instalado git. Instalando"
	yum install git
fi
if isinstalled composer; then
	echo `composer --version`
	cgr drush/drush
else
	echo "No se encuentra instalado composer. Instalando"
	sudo yum install php-cli php-zip wget unzip
	#Obteniendo composer
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	#Obteniendo hash de composer
	HASH="$(wget -q -O - https://composer.github.io/installer.sig)"
	#Verificando, si es real manda el mensaje "Instaler verified" y se puede continuar...
	php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
	#Si se verifico el hash, se instala el composer
	sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
fi
if isinstalled2 drush; then
	echo `drush --version`
else
	echo "No se encuentra instalado git. Instalando"
	#Instalando cgr
	composer global require consolidation/cgr
	#Agregando la direccion de cgr al path
	PATH="$(composer config -g home)/vendor/bin:$PATH"
	#Instalando drush
	cgr drush/drush
fi

echo "Se procede a realizar el backup de /var/www. Esto puede tardar unos minutos".

