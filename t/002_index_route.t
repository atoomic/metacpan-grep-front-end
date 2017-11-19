use strict;
use warnings;

use grepcpan;
use Test::More;

use Plack::Test;
use HTTP::Request::Common;

my $app = grepcpan->to_app;
is( ref $app, 'CODE', 'Got app' );

my $test = Plack::Test->create($app);

# static pages
my @static_routes = qw{ / /about /faq /api /source-code /search /api/search };

foreach my $route (@static_routes) {
    my $res = $test->request( GET $route );
    ok( $res->is_success, "[GET $route] successful" );
    is $res->code, 200, "200 answer";
    note ref $res;
}

done_testing;
