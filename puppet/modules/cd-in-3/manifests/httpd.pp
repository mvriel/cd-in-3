class cd-in-3::httpd {
    include apache

    php::module { "xdebug" : }
    php::module { "mysql" : }

    php::pear::module { 'PHPUnit':
      repository  => 'pear.phpunit.de',
      use_package => 'no',
    }
    php::pear::module { 'phing':
      repository  => 'pear.phing.info',
      use_package => 'no',
    }

    apache::module { "rewrite" : }

    # disable default vhost
    apache::vhost { 'default':
      docroot     => '/var/www',
      server_name => false,
      priority    => '',
      enable      => false
    }

    apache::vhost { 'dev.my.blog.com':
        docroot       => '/vagrant/app/web',
        server_name   => 'dev.my.blog.com'
    }
}
