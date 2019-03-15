#!/bin/bash

#Se debe de copiar el programa a /var/www al ejecutarlo lo debe hacer un usuario normal con acceso a sudo, funciona para debian 8

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
echo "Bienvenido, se muestran los directorios: "
c=0
#Se listan los directorios que estan en /var/www
for d in */; do
        eval "var$c=$d";
        echo $c $d
        c=$((c+1));
done

echo "Seleccione uno: "
read val

FILE="/home/usuario/Documents/respaldo"
if [ $val -eq 0 ];
then
        cd /var/www/$var0
        echo "Se procede a realizar el backup de `pwd`. Esto puede tardar unos minutos".
        drupa={var0::-1}
        echo "El respaldo se se guardara en $FILE.$drupa.tar.gz"
        sudo tar -czvf $FILE.$drupa.tar.gz ../$var0
elif [ $val -eq 1 ];
then
        cd /var/www/$var1
        echo "Se procede a realizar el backup de `pwd`. Esto puede tardar unos minutos".
        drupa={var1::-1}
        echo "El respaldo se se guardara en $FILE.$drupa.tar.gz"
        sudo tar -czvf $FILE.$drupa.tar.gz ../$var1
elif [[ $val -eq 2 ]]
then
        cd /var/www/$var2
        echo "Se procede a realizar el backup de `pwd`. Esto puede tardar unos minutos".
        drupa={var2::-1}
        echo "El respaldo se se guardara en $FILE.$drupa.tar.gz"
        sudo tar -czvf $FILE.$drupa.tar.gz ../$var2
elif [[ $val -eq 3 ]]
then
        cd /var/www/$var3
        echo "Se procede a realizar el backup de `pwd`. Esto puede tardar unos minutos".
        drupa={var3::-1}
        echo "El respaldo se se guardara en $FILE.$drupa.tar.gz"
        sudo tar -czvf $FILE.$drupa.tar.gz ../$var3
fi

echo "Se revisa si existen las siguientes dependencias..."
if isinstalled git; then
	echo `git --version`
else
	echo "No se encuentra instalado git. Instalando"
	sudo apt install git
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
if isinstalled drush; then
	echo `drush --version`
else
	echo "No se encuentra instalado drush. Instalando"
	sudo wget https://github.com/drush-ops/drush/releases/download/8.0.1/drush.phar
	sudo php drush.phar core-status
	sudo chmod +x drush.phar
	sudo sudo mv drush.phar /usr/local/bin/drush
	echo $PATH
	drush init
fi
#NOW=`date +%D-%H%M`
#echo "Se procede a realizar el backup de /var/www. Esto puede tardar unos minutos".
#FILE="/home/backup.$NOW.tar.gz"
#sudo tar -czvf $FILE /var/www
#cd /var/www/sitio1.com/drupal
#Para actualización drupal
sudo drush up --yes
#cd -
#cd /var/www/sitio2.com/drupal
#Para actualización drupal
#drush up --yes
echo "Revise la instalacion de drupal en su navegador y compruebe su funcionalidad, escoja una de las siguientes opciones: "
echo "1.- Si funciona"
echo "2.- No funciona, quiero regresar a la version anterior"
read respuesta

if [ $respuesta -eq 1 ];
then
        "Actualizado por el team dinamita"
elif [ $respuesta -eq 2  ];
then
        echo "Regresando a la version anterior espere un momento"
        echo $FILE.$drupa.tar.gz
        cd ..
        sudo tar -xzvf $FILE.$drupa.tar.gz
else
        echo "Opcion no valida"
fi

