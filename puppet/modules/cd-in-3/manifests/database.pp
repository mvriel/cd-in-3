class cd-in-3::database {
    class { 'mysql': }

    mysql::grant { 'ichikawa':
      mysql_privileges => 'ALL',
      mysql_db         => 'blog',
      mysql_user       => 'ichikawa',
      mysql_password   => 'hogehoge',
      mysql_db_init_query_file => '/vagrant/data/fixture.sql',
    }
}
