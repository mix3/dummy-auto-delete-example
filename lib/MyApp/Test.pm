package MyApp::Test;

use strict;
use warnings;
use utf8;

use Test::mysqld;

sub new { bless {}, shift }

sub replace_mysqld {
    my $self = shift;
    my ($container, $initializer) = @_;

    my $mysqld = Test::mysqld->new(
        my_cnf => { 'skip-networking' => '' },
    );

    $self->{mysqld} = $mysqld;
    $container->get('conf')->{database}[0] = $mysqld->dsn;
    $container->get('conf')->{database}[2] = '';

    my $tmp = $container->get('conf')->{database}[-1];
    $container->get('conf')->{database}[-1] = {
        ignore_version => 1,
        %$tmp
    };

    my $schema = $initializer->($container);
    $schema->deploy;
    $schema;
}

1;
