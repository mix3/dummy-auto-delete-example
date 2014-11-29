requires 'DBI';
requires 'DBIx::Class';
requires 'SQL::Translator';
requires 'DBD::mysql';
requires 'Config::PL';
requires 'Object::Container';

on 'test' => sub {
    requires 'Test::More';
    requires 'Test::Deep';
    requires 'Test::Deep::Matcher';
    requires 'Test::mysqld';
    requires 'DBIx::QueryLog';
    requires 'String::Random';
    requires 'String::CamelCase';
    requires 'DBIx::Inspector';
};
