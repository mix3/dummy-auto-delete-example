package MyApp::Schema::Result;

use strict;
use warnings;
use utf8;

use parent 'DBIx::Class::Core';

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;

    $sqlt_table->extra(
        mysql_table_type => 'InnoDB',
        mysql_charset    => 'utf8mb4',
    );
}

1;
