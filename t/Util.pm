package t::Util;

use strict;
use warnings;
use utf8;
use parent 'Exporter';

use Test::More;
use Test::Deep;
use Test::Deep::Matcher;

use MyApp::Schema;
use MyApp::Container;
use MyApp::Test;
use MyApp::Test::Dummy;

use DBIx::QueryLog ();

our @EXPORT = qw/
    dummy
    dummy_auto_del
/;

my $test; sub test { $test }

sub import {
    my ($class, @args) = @_;

    strict->import;
    warnings->import;
    utf8->import;

    $class->export_to_level(1, $class, @args);

    Test::More->export_to_level(1);
    Test::Deep->export_to_level(1);
    Test::Deep::Matcher->export_to_level(1);

    if ($ENV{DEBUG}) {
        DBIx::QueryLog->enable;
    }

    $test = MyApp::Test->new;

    {
        my $initializer = MyApp::Container->instance->registered_classes->{Schema};
        MyApp::Container::register('Schema', sub {
            my $self = shift;
            $test->replace_mysqld($self, $initializer);
        });
    }
}

sub dummy_auto_del {
    my $dummy = MyApp::Test::Dummy->create(@_);
    $dummy->{_auto_delete} = 1;
    $dummy;
}

sub dummy {
    MyApp::Test::Dummy->create(@_);
}

1;
