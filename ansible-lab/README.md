Exit code: 0
Wall time: 0.3 seconds
Output:
# Laboratorio de Ansible con Docker

## Objetivo

Automatizar con Ansible la configuracion basica de dos contenedores Ubuntu: mostrar sus datos, crear una estructura de directorios y generar un archivo de informacion por servidor.

## Requisitos

- Docker Desktop en ejecucion.
- Ansible instalado en el equipo anfitrion.
- La coleccion `community.docker`, que proporciona la conexion `docker`:

  ```bash
  ansible-galaxy collection install community.docker
  ```

## Iniciar los contenedores

Desde la carpeta `ansible-lab`:

```bash
docker compose up -d
docker ps
```

Instalar Python dentro de cada contenedor (necesario para Ansible):

```bash
docker exec -it server1 bash -c "apt update && apt install -y python3"
docker exec -it server2 bash -c "apt update && apt install -y python3"
```

## Comprobar la conexion

```bash
ansible docker -i inventory.ini -m ping
```

## Ejecutar el playbook

```bash
ansible-playbook -i inventory.ini playbook.yml
```

El playbook crea `/tmp/ansible-demo`, el archivo `info.txt` y los directorios `logs`, `backup` y `config` en ambos servidores.

## Captura de ejecucion exitosa

Ejecuta el playbook y agrega aqui una captura que muestre el resumen final sin fallos, por ejemplo:

```text
PLAY RECAP *********************************************************************
server1 : ok=7 changed=5 unreachable=0 failed=0 skipped=0 rescued=0 ignored=0
server2 : ok=7 changed=5 unreachable=0 failed=0 skipped=0 rescued=0 ignored=0
```

> La captura se puede insertar asi: `![Ejecucion exitosa](docs/playbook-success.png)`.

