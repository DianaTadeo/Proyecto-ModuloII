# Proyecto-ModuloII
Actualización automática de aplicativos web en CSM Drupal 7

- Si se está utilizando Deiab 8 o Debian 9, se debe ejecutar el script drushUpdateDebian.sh
- Si se está tilizando CentOS 7 se debe ejecutar el script drushUpdateCentOS.sh

## Para ejecutar 
1. Antes de ejecutar el script, se recomienda ejecutar con un usuario de sudo con todos los prrmisos.
2. En caso de que exista algun error durante la ejecución de los comandos del script, se realizó un respaldo al inicio del script
    dentro del directorio **/tmp** con el prefijo *drupal*. Así se puede recuperar manualmente.
3. Es necesario tener la raíz del sitio de drupal dentro del directorio **/var/www/** con sitios de la forma --/var/www/sitioejemplo--
4. Al ejecutar, recordar asegurarse de los permisos del script
5. MUY IMPORTANTE: Colocar el script fuera del directorio **/var/www/** para que el backup funcione correctamente

Desde la linea de comandos
```
./drushUpdateCentOS.sh
```
o
```
./drushUpdateDebian.sh
```
