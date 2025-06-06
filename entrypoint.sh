#!/bin/bash

# Activar entorno virtual
source /opt/odoo/venv/bin/activate

# Generar archivo de configuración si no existe
if [ ! -f /opt/odoo/odoo.conf ]; then
  cat > /opt/odoo/odoo.conf <<EOF
[options]
addons_path = addons
admin_passwd = ${ADMIN_PASSWORD}
db_host = ${DB_HOST}
db_port = ${DB_PORT}
db_user = ${DB_USER}
db_password = ${DB_PASSWORD}
log_level = info
logfile = /opt/odoo/odoo.log
EOF
fi

# Ejecutar Odoo usando el archivo de configuración
exec python /opt/odoo/odoo-bin -c /opt/odoo/odoo.conf
