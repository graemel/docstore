package DocStore::Schema::ResultSet::Document;
use strict;
use warnings;

use Lingua::EN::Sentence qw( get_sentences add_acronyms );
use base 'DBIx::Class::ResultSet';

=head2 create
We override create so that we can automatically create the sentences when a document is created.
=cut
sub create {
	my ( $self, @args ) = @_;
	my $new = $self->next::method(@args);
	
	my @sentences = $self->_split_sentences($new);
	
	foreach my $sentence (@sentences) {
		$new->sentences->create($sentence);
	}
	
	return $new;
}


sub _split_sentences {
	my ( $self, $new ) = @_;

	my @sentences;	
	my $strings = my $sentences=get_sentences($new->original_text);
	
	my $position = 0;
	foreach my $str (@$strings) {
		push @sentences, {'content' => $str, 'position' => $position++ }; 
	}
	
	return @sentences;
}
1;