package DocStore::Schema::ResultSet::Sentence;
use strict;
use warnings;

use base 'DBIx::Class::ResultSet';


sub text_search {
	my ( $self, $term, $page ) = @_;
	$page ||= 1;
	
	my $rs = $self->search( 
		{},
		{order_by => ['document_id', 'position'], page => $page, rows => 100}
	)->search_literal('MATCH (content) AGAINST( ? )', $term);

	my @results = $rs->all;
	return \@results;
}

1;