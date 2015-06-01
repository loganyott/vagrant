<?php
/**
 * See our documentation for more details:
 *
 * http://helpdesk.getpantheon.com/
 */

if( file_exists( __DIR__ . '/vendor/autoload.php' )) {
  require_once( __DIR__ . '/vendor/autoload.php' );
}

define('DB_NAME',          'project');
define('DB_USER',          'root');
define('DB_PASSWORD',      'root');
define('DB_HOST',          'localhost');
define('DB_CHARSET',       'utf8');
define('DB_COLLATE',       '');

define('AUTH_KEY',         '6*zAcjjq /CL<%l=|Ont[/-$Lh6j8= nAgDRB5fc>+@2!VN]n/][NYKm ?yz1RJ8');
define('SECURE_AUTH_KEY',  'm_3Y:M3dDQ=<MK.P5o2,>rz/}gVR5Vd.yl68JQj}dt7/NjY.(G>J+L7DSm}Ws63-');
define('LOGGED_IN_KEY',    '$Q*Ro|y|iNT0qssrDqP98b=giCzk;1E#^.?W=iU9 )=5RKCcdjr#|{KDS$dYpR{,');
define('NONCE_KEY',        '+W/F,XsE7HXJzh9+F#[]dD_En2ue2s3pjnmsf$gO?{,i18U}=?@8ocW0o$G[<?GI');
define('AUTH_SALT',        'S8uwRoLdHt-.UbFlNkyB},MCSG$ EOga{jfQ*:IFf;Fy]#ZH/lgxnxg[|v[jF%KT');
define('SECURE_AUTH_SALT', 'nUS;6;Bv3OyyeF8+ypjbM#$ySl8VT7`^kVQnrYj`)vzsv-dE(bkjx|<mwR9`zxRi');
define('LOGGED_IN_SALT',   '[(P+zS-x*8]RsI9J.C$S[F#3y~MD99s,1-M/8CC%SSP|^]+67z+a]IOy-mWh~4%t');
define('NONCE_SALT',       'UF:dPJlU|wrJKZjqFNG|JvVH_l_dQbqIP{qW46FvkiT*Kl2Dw&(bwV%MymuI-5nw');

if (isset($_SERVER['HTTP_HOST'])) {
  define('WP_HOME', 'http://' . $_SERVER['HTTP_HOST']);
  define('WP_SITEURL', 'http://' . $_SERVER['HTTP_HOST']);
}

if ( isset( $_SERVER['HTTP_HOST'] ) ) {
  define( 'WP_HOME', '//' . $_SERVER['HTTP_HOST'] );
  // Technically don't need this now, but leaving in case we get subdirectory install
  define( 'WP_SITEURL', '//'. $_SERVER['HTTP_HOST'] );
  define( 'WP_CONTENT_URL', '//' . $_SERVER['HTTP_HOST'] . '/wp-content' );
  define( 'WP_PLUGIN_URL', '//' . $_SERVER['HTTP_HOST'] . '/wp-content/plugins' );
}
define( 'WP_CONTENT_DIR', dirname( __FILE__ ) . '/wp-content' );
define( 'WP_PLUGIN_DIR', dirname( __FILE__ ) . '/wp-content/plugins' );
define( 'PLUGINDIR', dirname( __FILE__ ) . '/wp-content/plugins' );

define( 'WPLANG', '' );
define( 'WP_CACHE', false );

define( 'WP_DEBUG', true );
define( 'WP_DEBUG_DISPLAY', false );
define( 'WP_DEBUG_LOG', true );

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');

