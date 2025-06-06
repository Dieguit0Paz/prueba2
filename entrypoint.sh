#!/bin/bash
source venv/bin/activate

exec python odoo-bin \
    -c odoo.conf \
    --db_host=${DB_HOST} \
    --db_port=${DB_PORT} \
    --db_user=${DB_USER} \
    --db_password=${DB_PASSWORD} \
    --admin-password=${ADMIN_PASSWORD} \
    "$@"
