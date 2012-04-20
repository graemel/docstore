use strict;
use warnings;
use Test::More;
use FindBin;


use Test::WWW::Mechanize::Catalyst;

BEGIN { use_ok 'DocStore::Controller::Document' };

my $mech = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'DocStore');


#Document index
{
	$mech->get_ok("/"); # Document Index
	is($mech->ct, "text/html");
  	$mech->title_is("Document Storage Solution", "On the index page");
  	$mech->content_contains("Welcome to the Document Store", "Correct content");
}

#Upload a document
{
	$mech->follow_link_ok({text => 'Upload'}, "Click on Upload");
	$mech->form_number(1);
	$mech->field('name', 'TEST: Pride and Predjudice');
	
	$mech->field('doc', "$FindBin::Bin/assets/1342.txt");
	$mech->submit();
	
	$mech->title_is("Document Storage Solution", "On the index page");
  	$mech->content_contains("TEST: Pride and Predjudice", "Can see uploaded file");
}

#View a document
{
	$mech->follow_link_ok({text => 'TEST: Pride and Predjudice'}, "Click on TEST: Pride and Predjudice");
	$mech->content_contains("insufficient to make his wife understand his character", "Can see random sentence in document.");
}

#Search
{
	$mech->get_ok("/search/insufficient"); # Search results
	$mech->content_contains("insufficient to make his wife understand his character", "Can see searched for sentence in document.");
}


#ok( request('/')->is_success, 'Request should succeed' );
#ok( request('/search')->is_success, 'Search path succeeds');
#ok( request('/search/darcy')->is_success, 'Darcy search succeeds');
#ok( request('/upload')->is_success, 'Upload path succeeds');
done_testing();
