package MyApp::Test::Dummy;

use strict;
use warnings;
use utf8;

use MyApp::Container qw/con/;
use String::Random qw/random_regex/;
use String::CamelCase qw/decamelize/;
use DBIx::Inspector;

my $inspector; sub inspector {
    $inspector ||= DBIx::Inspector->new (
        dbh => con("Schema")->storage->dbh,
    );
}

my $columns = {}; sub columns {
    my ($self, $table) = @_;
    $columns->{$table} ||= do {
        inspector->columns(decamelize($table));
    };
}

my $creator = {
    INT => sub {
        random_regex('[0-9]{4}');
    },
    TEXT => sub {
        random_regex('[A-Za-z0-9]{10}');
    },
};

sub create {
    my ($self, $table, %args) = @_;

    my %data;
    for my $column (@{$columns->{$table}}) {
        next if $column->{MYSQL_IS_AUTO_INCREMENT};
        $data{$column->name} = $creator->{$column->type_name}->($column);
    }

    my $result_class = con("Schema::$table")->result_class;
    {
        no strict qw/refs/;
        *{$result_class."::DESTROY"} = sub {
            my $self = shift;
            if ($self->{_auto_delete}) {
                $self->delete;
            }
        };
    }

    con("Schema::$table")->create({
        %data,
        %args,
    });
}

1;
