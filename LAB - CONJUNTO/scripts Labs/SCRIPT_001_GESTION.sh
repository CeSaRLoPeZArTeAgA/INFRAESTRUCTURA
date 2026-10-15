#Limpiamos la consola
clear

#Listamos la raíz del servidor
ls /

#Listamos la raíz del servidor con mayor detalle
ls -l /

#Listamos la carpeta "/var"
ls -l /var

#Listamos la carpeta "/home"
#En Linux aquí están las carpetas de los usuarios
ls -l /home

#Listamos la carpeta del usuario "main"
#Por ahora está vacía
ls -l /home/main

#Vamos a crear una carpeta "descargas" dentro
mkdir /home/main/descargas

#Verificamos
ls -l /home/main

#Verificamos en qué carpeta estamos actualmente en la consola
pwd

#Vamos a entrar a la carpeta "descargas"
cd /home/main/descargas

#Verificamos en qué carpeta estamos actualmente en la consola
#Estamos dentro de descargas
pwd

#Descargaremos algo de internet
wget https://downloads.apache.org/hadoop/common/hadoop-2.10.1/hadoop-2.10.1.tar.gz

#Verificamos
ls -l /home/main/descargas

#Vamos a instalar algo desde los repos oficiales
#Instalaremos Apache que es un servidor de páginas web
#Primero actualizamos el repo en nuestro server
sudo apt update

#Instalamos Apache
#Si nos pide confirmación, colocamos: Y
sudo apt install apache2

#Vamos a agregar una página web de prueba
#En Apache las páginas web se encuentran en:
ls -l /var/www/html

#Agregamos una página
echo "<h1>HOLA CC 422</h1>" | sudo tee -a /var/www/html/hola.html

#Para acceder al server y ver las páginas web debemos habilitar el puerto 80
#Volvemos el documento del laboratorio