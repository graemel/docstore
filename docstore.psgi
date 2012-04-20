use strict;
use warnings;

use DocStore;

my $app = DocStore->apply_default_middlewares(DocStore->psgi_app);
$app;

