package DocStore::Schema::Result::Sentence;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('sentence');
__PACKAGE__->resultset_class('DocStore::Schema::ResultSet::Sentence');


__PACKAGE__->add_columns(qw/ 
				id		content	
				created_at	position
				document_id
		/);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->belongs_to('document' => 'DocStore::Schema::Result::Document', {'foreign.id' => 'self.document_id'});


sub previous {
	my ( $self ) = @_;
	return $self->result_source->resultset->search({ document_id => $self->document_id, position => ($self->position - 1) })->first;	
}

sub next {
	my ( $self ) = @_;
	return $self->result_source->resultset->search({ document_id => $self->document_id, position => ($self->position + 1) })->first;	
}

1;
