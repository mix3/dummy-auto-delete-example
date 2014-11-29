package MyApp::Schema::Types;

use strict;
use warnings;
use utf8;

use parent 'Exporter';

our @EXPORT = qw/
    INTEGER
    TEXT
/;

sub INTEGER {
    +{
        data_type     => 'INTEGER',
        is_nullable   => 0,
        default_value => 0,
        extra => {
            unsigned => 1,
        },
        @_,
    };
}

sub TEXT {
    +{
        data_type   => 'TEXT',
        is_nullable => 1,
        @_,
    };
}

1;
