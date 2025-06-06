# Imagen base de Python
FROM python:3.10-slim

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    git \
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

# Crear carpeta para Odoo
WORKDIR /opt/odoo

# Clonar tu repositorio en una carpeta interna
RUN git clone https://github.com/Dieguit0Paz/prueba2.git app

# Cambiar al directorio de tu proyecto
WORKDIR /opt/odoo/app

# Crear entorno virtual e instalar dependencias
RUN python -m venv venv && \
    . venv/bin/activate && \
    pip install --upgrade pip && \
    pip install -r requirements.txt

# Copiar el script de arranque
COPY entrypoint.sh /opt/odoo/app/entrypoint.sh
RUN chmod +x /opt/odoo/app/entrypoint.sh

# Exponer el puerto por defecto de Odoo
EXPOSE 8069

# Comando de inicio
ENTRYPOINT ["/opt/odoo/app/entrypoint.sh"]
