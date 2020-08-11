# sam-php
Secure and Minimal php-fpm Docker-image. Only fastcgi, no web server. Share unix socket (VAR_SOCKET_FILE) with a fcgi-capable web server container (f ex. huggla/sam-lighttpd2).

## Environment variables
### Runtime variables with default value
* VAR_LINUX_USER="php" (User running VAR_FINAL_COMMAND)
* VAR_FINAL_COMMAND="php-fpm7 --nodaemonize --force-stderr" (Command run by VAR_LINUX_USER)
* VAR_SOCKET_FILE="/run/php7-fpm/socket"
* VAR_LOG_FILE="/var/log/php7/error.log"
* VAR_wwwconf_listen='$VAR_SOCKET_FILE'
* VAR_wwwconf_pm="dynamic"
* VAR_wwwconf_pm__max_children="5"
* VAR_wwwconf_pm__min_spare_servers="1"
* VAR_wwwconf_pm__max_spare_servers="4"

## Capabilities
Can drop all but SETPCAP, SETGID and SETUID.

## Tips
### To use with huggla/sam-lighttpd2
* Run huggla/sam-qgisserver and huggla/sam-lighttpd2 on the same host.
* Mount a directory from the host and make sure VAR_SOCKET_FILE in sam-php and VAR_FASTCGI_SOCKET_FILE in sam-lighttpd2 points to the same file inside this directory.
* Set VAR_OPERATION_MODE="fcgi" and VAR_setup1_module_load="[ 'mod_fastcgi' ]" in sam-lighttpd2.
* (Optional) Adjust VAR_setup3_workers, VAR_setup4_io__timeout and VAR_setup5_stat_cache__ttl in sam-lighttpd2.
* Put Qgis project files in VAR_PROJECT_STORAGE_DIR.
* Try to load http://<hostaddress>/?map=myproject.qgs&service=WMS&request=GetCapabilities
