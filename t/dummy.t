use t::Util;

use MyApp::Container qw/con/;

{
    my $gurad = dummy_auto_del('Artist', id => 1);
    dummy('Artist', id => 2);
    {
        my $got = con('Schema::Artist')->single({
            id => 1,
        });
        ok $got;
    }
    {
        my $got = con('Schema::Artist')->single({
            id => 2,
        });
        ok $got;
    }
}

{
    {
        my $got = con('Schema::Artist')->single({
            id => 1,
        });
        ok !$got;
    }
    {
        my $got = con('Schema::Artist')->single({
            id => 2,
        });
        ok $got;
    }
}

done_testing;
