# php
https://github.com/Kristianstad/php/pkgs/container/php

Secure and Minimal php-fpm Docker image. Based on https://github.com/Kristianstad/nginx/pkgs/container/nginx (check for webserver settings).

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
Can drop all but CHOWN, SETPCAP, SETGID and SETUID.
