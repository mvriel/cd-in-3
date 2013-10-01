class cd-in-3::httpd {
    include apache

    php::module { "xdebug" : }
    php::module { "mysql" : }

    php::pear::module { 'PHPUnit':
      repository  => 'pear.phpunit.de',
      use_package => 'no',
    }
    php::pear::module { 'phploc':
      repository  => 'pear.phpunit.de',
      use_package => 'no',
    }
    php::pear::module { 'PHP_CodeSniffer':
      use_package => 'no',
    }
    php::pear::module { 'phpcpd':
      repository  => 'pear.phpunit.de',
      use_package => 'no',
    }
    php::pear::module { 'PHP_Depend':
      repository  => 'pear.pdepend.org',
      use_package => 'no',
    }
    php::pear::module { 'PHP_PMD':
      repository  => 'pear.phpmd.org',
      use_package => 'no',
    }
    php::pear::module { 'phing':
      repository  => 'pear.phing.info',
      use_package => 'no',
    }
    php::pear::module { 'phpdocumentor':
      repository  => 'pear.phpdoc.org',
      use_package => 'no',
    }
    php::pear::module { 'behat':
      repository  => 'pear.behat.org',
      use_package => 'no',
    }
    php::pear::module { 'mink':
      repository  => 'pear.behat.org',
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
        docroot       => '/var/www/blog',
        server_name   => 'dev.my.blog.com'
    }
    file { '/var/www/blog' :
        ensure => 'link',
        target => '/vagrant/app/web'
    }
}
