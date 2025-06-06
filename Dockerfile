# Imagen base de Python
FROM python:3.10-slim

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    git \
    wkhtmltopdf \
    gcc \
    g++ \
    libxml2-dev \
    libxslt-dev \
    libjpeg-dev \
    libpq-dev \
    libldap2-dev \
    libsasl2-dev \
    libssl-dev \
    python3-dev \
    libffi-dev \
    libbz2-dev \
    wget \
    curl \
    unzip \
    && apt-get clean

# Crear carpeta base para Odoo y el usuario
RUN mkdir -p /opt/odoo/custom_addons /var/lib/odoo && \
    useradd -m -d /opt/odoo -U -r -s /bin/bash odoo && \
    chown -R odoo:odoo /opt/odoo /var/lib/odoo

# Copiar el script de arranque y dar permisos de ejecución
COPY entrypoint.sh /opt/odoo/app/entrypoint.sh
RUN chmod +x /opt/odoo/app/entrypoint.sh

# Cambiar a usuario odoo
USER odoo

# Directorio de trabajo del proyecto
WORKDIR /opt/odoo

# Clonar tu repositorio en carpeta interna
RUN git clone https://github.com/Dieguit0Paz/prueba2.git app

# Crear entorno virtual e instalar dependencias
WORKDIR /opt/odoo/app
RUN python -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# Exponer el puerto por defecto de Odoo
EXPOSE 8069

# Declarar volúmenes persistentes
VOLUME ["/var/lib/odoo", "/opt/odoo/custom_addons"]

# Comando de inicio
ENTRYPOINT ["/opt/odoo/app/entrypoint.sh"]
