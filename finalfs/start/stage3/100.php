# Set in stage2:
# ---------------------------------------------------------
# set -ef +am
# isFirstRun
# VAR_*
# All functions in /start/functions

if [ "$isFirstRun" == "true" ]
then
   if [ ! -s "/etc/php7/php-fpm.d/www.conf" ]
   then
      createWwwConf
   fi
   if [ ! -s "/etc/php7/conf.d/50-setting.ini" ]
   then
      setPhpIni
   fi
fi
