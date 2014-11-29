package MyApp::Container;

use strict;
use warnings;
use utf8;

use Object::Container '-base';

use FindBin;
use Path::Class;
use Config::PL;
use File::Basename;

register home => sub {
    dir(dirname(__FILE__), '..', '..');
};

register conf => sub {
    my $self = shift;
    config_do $self->get('home')->file('config.pl');
};

register Schema => sub {
    my ($self) = @_;

    my $conf = $self->get('conf')->{database}
        or die 'require database config';

    $self->ensure_class_loaded('MyApp::Schema');
    MyApp::Schema->connect(@{ $conf });
};

autoloader qr/^Schema::/ => sub {
    my ($self, $name) = @_;

    my $schema = $self->get('Schema');
    for my $t ($schema->sources) {
        register "Schema::$t" => sub { $schema->resultset($t) };
    }
};

1;
