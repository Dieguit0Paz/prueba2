#!/bin/bash

# Crear archivo de configuración Odoo con variables del entorno
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

# Ejecutar Odoo
exec /opt/odoo/venv/bin/python3 /opt/odoo/odoo-bin -c /opt/odoo/odoo.conf
