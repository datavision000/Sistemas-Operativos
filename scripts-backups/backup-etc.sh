#!/bin/bash
fechaHora=$(date +%d-%m-%Y,%H:%M)

rsync -zaq --log-file=/home/admin/backups/copias-etc/informe-copia-etc$fechaHora /etc/ /home/admin/backups/copias-etc/copia-etc$fechaHora
