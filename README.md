Ref & Optim Web
================


Install
--------

   git clone git@github.com:Theosakamg/RefOptimWeb.git
   composer.phar update
   sudo setfacl -R -m u:www-data:rwX -m u:`whoami`:rwX app/cache app/logs
   sudo setfacl -dR -m u:www-data:rwx -m u:`whoami`:rwx app/cache app/logs
   app/console sylius:install   
