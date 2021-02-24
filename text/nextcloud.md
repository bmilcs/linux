# nextcloud | ubuntu 20.04.1

## preparations and installation of the nginx web server

	sudo -s
	apt install curl gnupg2 git lsb-release ssl-cert ca-certificates apt-transport-https tree locate software-properties-common dirmngr screen htop net-tools zip unzip bzip2 ffmpeg ghostscript libfile-fcntllock-perl -y

	echo "deb http://nginx.org/packages/mainline/ubuntu $(lsb_release -cs) nginx" | tee nginx.list
	echo "deb http://ppa.launchpad.net/ondrej/php/ubuntu $(lsb_release -cs) main" | tee php.list
	echo "deb http://ftp.hosteurope.de/mirror/mariadb.org/repo/10.5/ubuntu $(lsb_release -cs) main" | tee mariadb.list
	apt-key adv --recv-keys --keyserver hkps://keyserver.ubuntu.com:443 4F4EA0AAE5267A6C
	curl -fsSL https://nginx.org/keys/nginx_signing.key | apt-key add -
	apt-key adv --recv-keys --keyserver hkps://keyserver.ubuntu.com:443 0xF1656F24C74CD1D8

	apt update && apt upgrade -y
	make-ssl-cert generate-default-snakeoil -y
	apt remove nginx nginx-extras nginx-common nginx-full -y --allow-change-held-packages
	systemctl stop apache2.service && systemctl disable apache2.service
	apt install nginx -y
	systemctl enable nginx.service
	mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak && touch /etc/nginx/nginx.conf
	nano /etc/nginx/nginx.conf

		user www-data;
		worker_processes auto;
		pid /var/run/nginx.pid;

		events {
			worker_connections 1024;
			multi_accept on; use epoll;
			}

		http {
			server_names_hash_bucket_size 64;
			access_log /var/log/nginx/access.log;
			error_log /var/log/nginx/error.log warn;
			set_real_ip_from 127.0.0.1;
			#optional, Sie können das eigene Subnetz ergänzen, bspw.:
			# set_real_ip_from 192.168.2.0/24;
			real_ip_header X-Forwarded-For;
			real_ip_recursive on;
			include /etc/nginx/mime.types;
			default_type application/octet-stream;
			sendfile on;
			send_timeout 3600;
			tcp_nopush on;
			tcp_nodelay on;
			open_file_cache max=500 inactive=10m;
			open_file_cache_errors on;
			keepalive_timeout 65;
			reset_timedout_connection on;
			server_tokens off;
			resolver 127.0.0.53 valid=30s;
			resolver_timeout 5s;
			include /etc/nginx/conf.d/*.conf;
			}

	service nginx restart
	mkdir -p /var/nc_data /var/www/letsencrypt/.well-known/acme-challenge /etc/letsencrypt/rsa-certs /etc/letsencrypt/ecc-certs
	chown -R www-data:www-data /var/nc_data /var/www

## installation and configuration of php 7.4 (fpm)

	apt update && apt install php7.4-fpm php7.4-gd php7.4-mysql php7.4-curl php7.4-xml php7.4-zip php7.4-intl php7.4-mbstring php7.4-json php7.4-bz2 php7.4-ldap php-apcu php7.4-bcmath php7.4-gmp imagemagick php-imagick php-smbclient ldap-utils -y

	timedatectl set-timezone America/New_York

	cp /etc/php/7.4/fpm/pool.d/www.conf /etc/php/7.4/fpm/pool.d/www.conf.bak
	cp /etc/php/7.4/cli/php.ini /etc/php/7.4/cli/php.ini.bak
	cp /etc/php/7.4/fpm/php.ini /etc/php/7.4/fpm/php.ini.bak
	cp /etc/php/7.4/fpm/php-fpm.conf /etc/php/7.4/fpm/php-fpm.conf.bak
	cp /etc/ImageMagick-6/policy.xml /etc/ImageMagick-6/policy.xml.bak

	sed -i "s/;env\[HOSTNAME\] = /env[HOSTNAME] = /" /etc/php/7.4/fpm/pool.d/www.conf
	sed -i "s/;env\[TMP\] = /env[TMP] = /" /etc/php/7.4/fpm/pool.d/www.conf
	sed -i "s/;env\[TMPDIR\] = /env[TMPDIR] = /" /etc/php/7.4/fpm/pool.d/www.conf
	sed -i "s/;env\[TEMP\] = /env[TEMP] = /" /etc/php/7.4/fpm/pool.d/www.conf
	sed -i "s/;env\[PATH\] = /env[PATH] = /" /etc/php/7.4/fpm/pool.d/www.conf
	sed -i "s/pm.max_children =.*/pm.max_children = 120/" /etc/php/7.4/fpm/pool.d/www.conf
	sed -i "s/pm.start_servers =.*/pm.start_servers = 12/" /etc/php/7.4/fpm/pool.d/www.conf
	sed -i "s/pm.min_spare_servers =.*/pm.min_spare_servers = 6/" /etc/php/7.4/fpm/pool.d/www.conf
	sed -i "s/pm.max_spare_servers =.*/pm.max_spare_servers = 18/" /etc/php/7.4/fpm/pool.d/www.conf
	sed -i "s/;pm.max_requests =.*/pm.max_requests = 1000/" /etc/php/7.4/fpm/pool.d/www.conf

	sed -i "s/output_buffering =.*/output_buffering = 'Off'/" /etc/php/7.4/cli/php.ini
	sed -i "s/max_execution_time =.*/max_execution_time = 3600/" /etc/php/7.4/cli/php.ini
	sed -i "s/max_input_time =.*/max_input_time = 3600/" /etc/php/7.4/cli/php.ini
	sed -i "s/post_max_size =.*/post_max_size = 10240M/" /etc/php/7.4/cli/php.ini
	sed -i "s/upload_max_filesize =.*/upload_max_filesize = 10240M/" /etc/php/7.4/cli/php.ini
	sed -i "s/;date.timezone.*/date.timezone = Europe\/\Berlin/" /etc/php/7.4/cli/php.ini

	sed -i "s/memory_limit = 128M/memory_limit = 1024M/" /etc/php/7.4/fpm/php.ini
	sed -i "s/output_buffering =.*/output_buffering = 'Off'/" /etc/php/7.4/fpm/php.ini
	sed -i "s/max_execution_time =.*/max_execution_time = 3600/" /etc/php/7.4/fpm/php.ini
	sed -i "s/max_input_time =.*/max_input_time = 3600/" /etc/php/7.4/fpm/php.ini
	sed -i "s/post_max_size =.*/post_max_size = 10240M/" /etc/php/7.4/fpm/php.ini
	sed -i "s/upload_max_filesize =.*/upload_max_filesize = 10240M/" /etc/php/7.4/fpm/php.ini
	sed -i "s/;date.timezone.*/date.timezone = Europe\/\Berlin/" /etc/php/7.4/fpm/php.ini
	sed -i "s/;session.cookie_secure.*/session.cookie_secure = True/" /etc/php/7.4/fpm/php.ini
	sed -i "s/;opcache.enable=.*/opcache.enable=1/" /etc/php/7.4/fpm/php.ini
	sed -i "s/;opcache.enable_cli=.*/opcache.enable_cli=1/" /etc/php/7.4/fpm/php.ini
	sed -i "s/;opcache.memory_consumption=.*/opcache.memory_consumption=128/" /etc/php/7.4/fpm/php.ini
	sed -i "s/;opcache.interned_strings_buffer=.*/opcache.interned_strings_buffer=8/" /etc/php/7.4/fpm/php.ini
	sed -i "s/;opcache.max_accelerated_files=.*/opcache.max_accelerated_files=10000/" /etc/php/7.4/fpm/php.ini
	sed -i "s/;opcache.revalidate_freq=.*/opcache.revalidate_freq=1/" /etc/php/7.4/fpm/php.ini
	sed -i "s/;opcache.save_comments=.*/opcache.save_comments=1/" /etc/php/7.4/fpm/php.ini
	sed -i '$aapc.enable_cli=1' /etc/php/7.4/mods-available/apcu.ini
	sed -i "s/rights=\"none\" pattern=\"PS\"/rights=\"read|write\" pattern=\"PS\"/" /etc/ImageMagick-6/policy.xml
	sed -i "s/rights=\"none\" pattern=\"EPS\"/rights=\"read|write\" pattern=\"EPS\"/" /etc/ImageMagick-6/policy.xml
	sed -i "s/rights=\"none\" pattern=\"PDF\"/rights=\"read|write\" pattern=\"PDF\"/" /etc/ImageMagick-6/policy.xml
	sed -i "s/rights=\"none\" pattern=\"XPS\"/rights=\"read|write\" pattern=\"XPS\"/" /etc/ImageMagick-6/policy.xml
	service php7.4-fpm restart
	service nginx restart

## Installation and configuration of MariaDB 10.5

	apt update && apt install mariadb-server -y

	mysql_secure_installation

	Enter current password for root (enter for none): <ENTER> if new

	Switch to unix_socket authentication [Y / n] 	N

	Set root password? [Y / n] 		Y

		> set password

	Remove anonymous users? [Y / n] 	Y

	Disallow root login remotely? [Y / n] 	Y

	Remove test database and access to it? [Y / n] 	Y

	Reload privilege tables now? [Y / n] 	Y

	service mysql stop
	mv /etc/mysql/my.cnf /etc/mysql/my.cnf.bak
	nano /etc/mysql/my.cnf

	#---------------------------------------------
	[client]
	default-character-set = utf8mb4
	port = 3306
	socket = /var/run/mysqld/mysqld.sock
	[mysqld_safe]
	log_error=/var/log/mysql/mysql_error.log
	nice = 0
	socket = /var/run/mysqld/mysqld.sock
	[mysqld]
	basedir = /usr
	bind-address = 127.0.0.1
	binlog_format = ROW
	bulk_insert_buffer_size = 16M
	character-set-server = utf8mb4
	collation-server = utf8mb4_general_ci
	concurrent_insert = 2
	connect_timeout = 5
	datadir = /var/lib/mysql
	default_storage_engine = InnoDB
	expire_logs_days = 2
	general_log_file = /var/log/mysql/mysql.log
	general_log = 0
	innodb_buffer_pool_size = 1024M
	innodb_buffer_pool_instances = 1
	innodb_flush_log_at_trx_commit = 2
	innodb_log_buffer_size = 32M
	innodb_max_dirty_pages_pct = 90
	innodb_file_per_table = 1
	innodb_open_files = 400
	innodb_io_capacity = 4000
	innodb_flush_method = O_DIRECT
	key_buffer_size = 128M
	lc_messages_dir = /usr/share/mysql
	lc_messages = en_US
	log_bin = /var/log/mysql/mariadb-bin
	log_bin_index = /var/log/mysql/mariadb-bin.index
	log_error = /var/log/mysql/mysql_error.log
	log_slow_verbosity = query_plan
	log_warnings = 2
	long_query_time = 1
	max_allowed_packet = 16M
	max_binlog_size = 100M
	max_connections = 200
	max_heap_table_size = 64M
	myisam_recover_options = BACKUP
	myisam_sort_buffer_size = 512M
	port = 3306
	pid-file = /var/run/mysqld/mysqld.pid
	query_cache_limit = 2M
	query_cache_size = 64M
	query_cache_type = 1
	query_cache_min_res_unit = 2k
	read_buffer_size = 2M
	read_rnd_buffer_size = 1M
	skip-external-locking
	skip-name-resolve
	slow_query_log_file = /var/log/mysql/mariadb-slow.log
	slow-query-log = 1
	socket = /var/run/mysqld/mysqld.sock
	sort_buffer_size = 4M
	table_open_cache = 400
	thread_cache_size = 128
	tmp_table_size = 64M
	tmpdir = /tmp
	transaction_isolation = READ-COMMITTED
	unix_socket=OFF
	user = mysql
	wait_timeout = 600
	[mysqldump]
	max_allowed_packet = 16M
	quick
	quote-names
	[isamchk]
	key_buffer = 16M
#---------------------------------------------

	service mysql restart
	mysql -uroot -p

	CREATE DATABASE nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci; CREATE USER nextcloud@localhost identified by 'nextcloud'; GRANT ALL PRIVILEGES on nextcloud.* to nextcloud@localhost; FLUSH privileges; quit;

	mysql -h localhost -uroot -p -e "SELECT @@TX_ISOLATION; SELECT SCHEMA_NAME 'database', default_character_set_name 'charset', DEFAULT_COLLATION_NAME 'collation' FROM information_schema.SCHEMATA WHERE SCHEMA_NAME='nextcloud'"

## installation and configuration of redis

	apt update && apt install redis-server php-redis -y

	cp /etc/redis/redis.conf /etc/redis/redis.conf.bak
	sed -i "s/port 6379/port 0/" /etc/redis/redis.conf
	sed -i s/\#\ unixsocket/\unixsocket/g /etc/redis/redis.conf
	sed -i "s/unixsocketperm 700/unixsocketperm 770/" /etc/redis/redis.conf
	sed -i "s/# maxclients 10000/maxclients 512/" /etc/redis/redis.conf
	usermod -aG redis www-data

	cp /etc/sysctl.conf /etc/sysctl.conf.bak
	sed -i '$avm.overcommit_memory = 1' /etc/sysctl.conf

## installation and optimization of the nextcloud (including ssl)

	sudo -s
	[ -f /etc/nginx/conf.d/default.conf ] && mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak
	touch /etc/nginx/conf.d/default.conf
	touch /etc/nginx/conf.d/http.conf
	touch /etc/nginx/conf.d/nextcloud.conf
	nano /etc/nginx/conf.d/http.conf

	upstream php handler {
	server unix: /run/php/php7.4-fpm.sock;
	}
	server {
	listen 80 default_server;
	listen [::]: 80 default_server;
	server_name cloud.bmilcs.com ;
	root / var / www;
	location ^ ~ /.well-known/acme-challenge {
	default_type text / plain;
	root / var / www / letsencrypt;
	}
	location / {
	return 301 https: // $ host $ request_uri;
	}
	}

	nano /etc/nginx/conf.d/nextcloud.conf

	server {
	listen 443 ssl http2 default_server;
	listen [::]:443 ssl http2 default_server;
	server_name cloud.bmilcs.com;
	ssl_certificate /etc/ssl/certs/ssl-cert-snakeoil.pem;
	ssl_certificate_key /etc/ssl/private/ssl-cert-snakeoil.key;
	ssl_trusted_certificate /etc/ssl/certs/ssl-cert-snakeoil.pem;
	#ssl_certificate /etc/letsencrypt/rsa-certs/fullchain.pem;
	#ssl_certificate_key /etc/letsencrypt/rsa-certs/privkey.pem;
	#ssl_certificate /etc/letsencrypt/ecc-certs/fullchain.pem;
	#ssl_certificate_key /etc/letsencrypt/ecc-certs/privkey.pem;
	#ssl_trusted_certificate /etc/letsencrypt/ecc-certs/chain.pem;
	ssl_dhparam /etc/ssl/certs/dhparam.pem;
	ssl_session_timeout 1d;
	ssl_session_cache shared:SSL:50m;
	ssl_session_tickets off;
	ssl_protocols TLSv1.3 TLSv1.2;
	ssl_ciphers 'TLS-CHACHA20-POLY1305-SHA256:TLS-AES-256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA512:DHE-RSA-AES256-GCM-SHA512:ECDHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-GCM-SHA384';
	ssl_ecdh_curve X448:secp521r1:secp384r1; 
	ssl_prefer_server_ciphers on;
	ssl_stapling on;
	ssl_stapling_verify on;
	add_header Strict-Transport-Security "max-age=15768000; includeSubDomains; preload;" always;
	add_header Referrer-Policy "no-referrer" always;
	add_header X-Content-Type-Options "nosniff" always;
	add_header X-Download-Options "noopen" always;
	add_header X-Frame-Options "SAMEORIGIN" always;
	add_header X-Permitted-Cross-Domain-Policies "none" always;
	add_header X-Robots-Tag "none" always;
	add_header X-XSS-Protection "1; mode=block" always;
	fastcgi_hide_header X-Powered-By;
	fastcgi_read_timeout 3600;
	fastcgi_send_timeout 3600;
	fastcgi_connect_timeout 3600;
	root /var/www/nextcloud;
	location = /robots.txt {
	allow all;
	log_not_found off;
	access_log off;
	}
	location = /.well-known/carddav {
	return 301 $scheme://$host:$server_port/remote.php/dav;
	}
	location = /.well-known/caldav {
	return 301 $scheme://$host:$server_port/remote.php/dav;
	}
	client_max_body_size 10240M;
	fastcgi_buffers 64 4K;
	gzip on;
	gzip_vary on;
	gzip_comp_level 4;
	gzip_min_length 256;
	gzip_proxied expired no-cache no-store private no_last_modified no_etag auth;
	gzip_types application/atom+xml application/javascript application/json application/ld+json application/manifest+json application/rss+xml application/vnd.geo+json application/vnd.ms-fontobject application/x-font-ttf application/x-web-app-manifest+json application/xhtml+xml application/xml font/opentype image/bmp image/svg+xml image/x-icon text/cache-manifest text/css text/plain text/vcard text/vnd.rim.location.xloc text/vtt text/x-component text/x-cross-domain-policy;
	location / {
	rewrite ^ /index.php;
	}
	location ~ ^\/(?:build|tests|config|lib|3rdparty|templates|data)\/ {
	deny all;
	}
	location ~ ^\/(?:\.|autotest|occ|issue|indie|db_|console) {
	deny all;
	}
	location ^~ /apps/rainloop/app/data {
	deny all;
	}
	location ~ ^\/(?:index|remote|public|cron|core\/ajax\/update|status|ocs\/v[12]|updater\/.+|oc[ms]-provider\/.+|.+\/richdocumentscode\/proxy)\.php(?:$|\/) {
	fastcgi_split_path_info ^(.+?\.php)(\/.*|)$;
	set $path_info $fastcgi_path_info;
	try_files $fastcgi_script_name =404;
	include fastcgi_params;
	fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
	fastcgi_param PATH_INFO $path_info;
	fastcgi_param HTTPS on;
	fastcgi_param modHeadersAvailable true;
	fastcgi_param front_controller_active true;
	fastcgi_pass php-handler;
	fastcgi_intercept_errors on;
	fastcgi_request_buffering off;
	}
	location ~ ^\/(?:updater|oc[ms]-provider)(?:$|\/) {
	try_files $uri/ =404;
	index index.php;
	}
	location ~ \.(?:css|js|woff2?|svg|gif|map)$ {
	try_files $uri /index.php$request_uri;
	add_header Cache-Control "public, max-age=15778463";
	add_header Strict-Transport-Security "max-age=15768000; includeSubDomains; preload;" always;
	add_header Referrer-Policy "no-referrer" always;
	add_header X-Content-Type-Options "nosniff" always;
	add_header X-Download-Options "noopen" always;
	add_header X-Frame-Options "SAMEORIGIN" always;
	add_header X-Permitted-Cross-Domain-Policies "none" always;
	add_header X-Robots-Tag "none" always;
	add_header X-XSS-Protection "1; mode=block" always;
	access_log off;
	}
	location ~ \.(?:png|html|ttf|ico|jpg|jpeg|bcmap|mp4|webm)$ {
	try_files $uri /index.php$request_uri;
	access_log off;
	}
	}

	openssl dhparam -out /etc/ssl/certs/dhparam.pem 4096
	service nginx restart
	cd /usr/local/src
	wget https://download.nextcloud.com/server/releases/latest.tar.bz2
	tar -xjf latest.tar.bz2 -C /var/www && chown -R www-data:www-data /var/www/ && rm -f latest.tar.bz2
	