package DocStore::Controller::Document;
use Moose;
use namespace::autoclean;

BEGIN {extends 'Catalyst::Controller'; }

=head1 NAME

DocStore::Controller::Document - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index
List documents
=cut

sub index :Path('/') :Args(0) {
    my ( $self, $c ) = @_;
	
	my @docs = $c->model('DB::Document')->all();
	$c->stash({'docs' => \@docs});
}


=head2 upload
Upload a new document form
=cut
sub upload :Path('/upload') :Args(0) {
	my ( $self, $c ) = @_;
	

	
	if($c->req->method eq 'POST') {
		if ( my $upload = $c->req->upload('doc') ) { 
			my $content;
			
			#Detect character encoding and deal with
			if($upload->slurp =~ /encoding\:\s?(.*?)\s/) {
				my $encoding = $1;
				$c->log->debug("ENCODING: $encoding");
				open my $handle, "<:encoding($encoding)", $upload->tempname 
					or $content = $upload->slurp;

				#$content is already defined if encoding read in failed				
				if(!$content) {
					while(<$handle>) {
						$content .= $_;
					}
					close($handle);
				}
			} else {
				$content = $upload->slurp;
			}

    		my $filename = $upload->filename;
		
			my $doc = $c->model('DB::Document')->create({ 
				name => $c->req->param('name'),
				original_text => $content,
			});
		} else {
			$c->log->debug('No File uploaded');
		}
		
		$c->res->redirect('/');
		$c->detach();
	}
	
}

=head2 view
View a document
=cut
sub view :Path('/view') :Args(1) {
	my ( $self, $c, $id ) = @_;
	
	$c->stash({doc => $c->model("DB::Document")->find($id)});
}

=head2 search
Basic text search for sentences.. 
=cut
sub search :Path('/search') :Args(1) {
	my ( $self, $c, $q ) = @_;
	
	my $results = $c->model('DB::Sentence')->text_search($q);
	$c->stash({results => $results});
	$c->stash({search_term => $q});
}

=head1 AUTHOR

Graeme

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
