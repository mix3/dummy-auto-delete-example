use t::Util;

use MyApp::Container qw/con/;

my $dummy_id;
{
    my $dummy = dummy_auto_del('Artist');
    my $got = con('Schema::Artist')->single({
        id => $dummy->id,
    });
    ok $got;
    $dummy_id = $dummy->id;
}

{
    my $got = con('Schema::Artist')->single({
        id => $dummy_id,
    });
    ok !$got;
}

done_testing;
