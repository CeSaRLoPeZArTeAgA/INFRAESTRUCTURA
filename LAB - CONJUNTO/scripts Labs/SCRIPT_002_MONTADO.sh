#Vamos a la raíz del servidor
cd /

#Listamos los discos duros QUE YA ESTÁN MONTANDO en el servidor
#
#De todos los discos duros, el del sistema operativo es:
# /dev/root
#
#Que está montado en la ruta:
# / (Raíz del servidor)
df -h

#Generalmente en Linux la ruta "/home", es decir el directorio
#de usuarios tiene su propio disco duro, de esta manera si
#alguien por "accidente" sube un archivo muy pesado y llena
#el disco duro, sólo se llenará el disco duro del "/home", no
#del sistema operativo

#Listamos los discos duros que NO están aún montados en el servidor
lsblk -o NAME,HCTL,SIZE,MOUNTPOINT

#En Linux los discos se listan con letras:
# El disco duro del Sistema Operativo es "xvda"
# AWS monta un disco duro especial "xvdb"
# Cualquier disco que montemos comenzará con "xvdb", "xvdc", "xvdd", etc.

#Tenemos disponible el disco "xvdb" que no está montado en ninguna ruta
#Montaremos "xvdb" sobre "/home"

#Para montar un disco duro en Linux, primero hay que particionarlo
#Vamos a crear sólo una partición con el sistema de archivos XFS

#Configuramos el formato del disco duro: XFS
sudo parted /dev/xvdb --script mklabel gpt mkpart xfspart xfs 0% 100%

#Creamos la partición
sudo mkfs.xfs /dev/xvdb1

#Confirmamos la partición
sudo partprobe /dev/xvdb1

#Crearemos una carpeta temporal en donde colocaremos los archivos que tenga la carpeta "/home"
sudo mkdir /home_tmp

#Copiamos el contenido de "/home" a "/home_tmp"
sudo cp -rp /home/* /home_tmp

#Verificamos
ls -l /home_tmp

#Borramos el contenido de la carpeta "/home"
sudo rm -r /home/*

#Verificamos
ls -l /home

#Montaremos el disco en la ruta "/home"
sudo mount /dev/xvdb1 /home

#Verificamos el montado
#Vemos que el disco "/dev/xvdb1" está montado en "/home"
df -h

#Volvemos a copiar el contenido original
sudo cp -rp /home_tmp/* /home

#Verificamos
ls -l /home

#Uno de los problemas del montado es que si
#reiniciamos el server, el disco duro no se
#monta automáticamente

#Para hacer el montado automático hay que 
#averiguar cuál es el ID del disco montado
sudo blkid

#En el output obtenido debemos de buscar la
#línea del disco que nos interesa:
#/dev/sdc1: UUID="xxx" TYPE="xfs" PARTLABEL="xfspart" PARTUUID="xxxx"

#De todo el contenido, copiaremos el UUID
#en algún editor en nuestra computadora y 
#escribimos la siguiente línea
#UUID=xxx   /home   xfs   defaults,nofail   1   2

#Esta línea la agregaremos al archivo "/etc/fstab" en el server
#Dentro de este archivo están los montados automáticos
#Veamos el contenido del archjivo
cat /etc/fstab

#Al final del archivo agregaremos la línea:
#UUID=xxx   /home   xfs   defaults,nofail   1   2
echo "UUID=xxx   /home   xfs   defaults,nofail   1   2" | sudo tee -a /etc/fstab

#Verificamos
cat /etc/fstab

#Vamos a reiniciar el servidor
sudo shutdown -r now

#Esperamos 1 minuto

#Verificamos si el montado permanece
df -h

#Regresamos al documento