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
else
	echo "No se encuentra instalado composer. Instalando"
	
fi
#d=isinstalled drupal
#c=isinstalled composer
 
echo "Se procede a realizar el backup de /var/www. Esto puede tardar unos minutos".

