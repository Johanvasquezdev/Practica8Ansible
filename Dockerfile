FROM ubuntu:latest

# Evitar prompts interactivos durante la instalación de paquetes
ENV DEBIAN_FRONTEND=noninteractive

# Actualizar e instalar openssh-server, sudo y python3 (necesario para Ansible)
RUN apt-get update && apt-get install -y openssh-server sudo python3 && rm -rf /var/lib/apt/lists/*

# Crear el usuario ansible con password "ansible"
RUN useradd -rm -d /home/ansible -s /bin/bash -g root -G sudo ansible
RUN echo 'ansible:ansible' | chpasswd

# Otorgar privilegios sudo sin password al usuario ansible
RUN echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Configurar el servidor SSH
RUN mkdir -p /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# Evitar que los usuarios sean desconectados tras el login
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd

# Exponer el puerto 22
EXPOSE 22

# Iniciar el servicio SSH
CMD ["/usr/sbin/sshd", "-D"]
