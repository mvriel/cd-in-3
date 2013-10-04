class cd-in-3 {
    Exec { path => '/usr/bin:/bin:/usr/sbin:/sbin' }

    exec { 'download-apt-dotdeb-pubkey':
        command => "apt-key add ${params::filepath}/cd-in-3/files/dotdeb.gpg",
    }

    file { 'dotdeb.list':
        path => "/etc/apt/sources.list.d/dotdeb.list",
        source => "${params::filepath}/cd-in-3/files/dotdeb.list",
        replace => "yes",
        require => Exec["download-apt-dotdeb-pubkey"]
    }

    package {
        [ 'git', 'make', 'vim', 'wget', 'curl', 'augeas-tools', 'libaugeas-dev', 'libaugeas-ruby', 'bash-completion', 'jenkins' ]:
        ensure => present,
        require => File["dotdeb.list"]
    }
    exec{'download-jenkins-cli' :
        command => "wget -N http://localhost:8080/jnlpJars/jenkins-cli.jar",
        require => Package["jenkins"],
        creates => "/home/vagrant/jenkins-cli.jar"
    }
    exec{'jenkins-plugins-install' :
        command => "java -jar jenkins-cli.jar -s http://localhost:8080 install-plugin checkstyle cloverphp dry htmlpublisher jdepend plot pmd violations xunit git clone-workspace-scm build-pipeline-plugin",
        require => Exec['download-jenkins-cli'],
    }
    exec{'jenkins-restart' :
        command => "java -jar jenkins-cli.jar -s http://localhost:8080 safe-restart",
        require => Exec['jenkins-plugins-install']
    }

    class { 'php':
        augeas => true
    }
    include httpd
    include database

    file { "/var/log/cd-in-3" :
        ensure => 'directory',
        owner  => "root",
        group  => "users",
        mode  => 0664
    }
}
