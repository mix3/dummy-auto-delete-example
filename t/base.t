use t::Util;

use MyApp::Container qw/con/;

{
    my $row = con('Schema::Artist')->create({
        id   => 1,
        name => "hoge",
    });
    my $got = con('Schema::Artist')->single({
        id => $row->id,
    });
    ok $got;
    is $got->id, 1;
    is $got->name, "hoge";
    cmp_deeply $got->to_hashref, {
        id   => is_integer,
        name => is_string,
    };
}

done_testing;
