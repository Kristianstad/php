# ghcr.io/kristianstad/php
Secure and Minimal php-fpm Docker image. Only fastcgi, no web server. Share unix socket (VAR_SOCKET_FILE) with a fcgi-capable web server container (f ex. ghcr.io/kristianstad/lighttpd2).

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
* VAR_wwwconf_pm__max_spare_servers="3"

### Format of runtime configuration variables
* VAR_wwwconf_&lt;param name&gt;: Parameter in <span>ww</span>w.conf.
* VAR_phpini_&lt;param name&gt;: Parameter in /etc/php7/conf.d/50-setting.ini (overrides defaults set in php.ini).
* Dot (.) is representated as double underscore (\_\_) in variable names.
* VAR_ldapconf_&lt;param name&gt;: Parameter in /etc/ldap/ldap.conf.

## Capabilities
Can drop all but SETPCAP, SETGID and SETUID.

## Tips
### To use with ghcr.io/kristianstad/lighttpd2
* Run php and lighttpd2 on the same host.
* Mount a directory from the host and make sure VAR_SOCKET_FILE in php and VAR_FASTCGI_SOCKET_FILE in lighttpd2 points to the same file inside this directory.
* Set VAR_OPERATION_MODE="fcgi" and VAR_setup1_module_load="\[ 'mod_fastcgi' \]" in lighttpd2.
* Make sure VAR_WWW_DIR in lighttpd2 is set to the path of the php-files in php.
* (Optional) Adjust VAR_setup3_workers, VAR_setup4_io__timeout and VAR_setup5_stat_cache__ttl in lighttpd2.
