FROM python:3.10-slim

# Evitar prompts interactivos
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias del sistema
RUN apt update && apt upgrade -y && apt install -y \
    git python3-pip build-essential wget python3-dev python3-venv \
    libxslt-dev libzip-dev libldap2-dev libsasl2-dev python3-setuptools \
    node-less libjpeg-dev libpq-dev libxml2-dev libssl-dev libffi-dev \
    libmariadb-dev liblcms2-dev libblas-dev libatlas-base-dev libpng-dev \
    libxrender1 libxext6 xfonts-base xfonts-75dpi libtiff-dev && \
    apt clean
 
RUN rm -rf /var/lib/apt/lists/*

# Crear usuario odoo
RUN useradd --system --create-home --home-dir /opt/odoo --shell /usr/sbin/nologin odoo

# Clonar tu repositorio
WORKDIR /opt/odoo
RUN git clone https://github.com/Dieguit0Paz/prueba2.git .

# Crear entorno virtual e instalar dependencias
RUN python3 -m venv /opt/odoo/venv && \
    /opt/odoo/venv/bin/pip install --upgrade pip && \
    /opt/odoo/venv/bin/pip install -r requirements.txt

# Cambiar dueño del directorio
RUN chown -R odoo:odoo /opt/odoo

# Copiar el script de entrada que genera el config dinámicamente
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Exponer el puerto de Odoo
EXPOSE 8069

USER odoo
CMD ["/entrypoint.sh"]
