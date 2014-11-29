package MyApp::Schema::Result::Artist;

use strict;
use warnings;
use utf8;

use parent 'MyApp::Schema::Result';

use MyApp::Schema::Types;

__PACKAGE__->table('artist');

__PACKAGE__->add_columns(
    id   => INTEGER,
    name => TEXT,
);

__PACKAGE__->set_primary_key(qw/id/);

sub to_hashref {
    my $self = shift;

    +{
        id   => $self->id,
        name => $self->name,
    };
}

1;
