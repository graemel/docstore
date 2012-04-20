package DocStore::Schema::Result::Document;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('document');
__PACKAGE__->resultset_class('DocStore::Schema::ResultSet::Document');

__PACKAGE__->add_columns(qw/ 
				id		name	created_at	original_text
		/);

__PACKAGE__->set_primary_key('id');

__PACKAGE__->has_many('sentences' => 'DocStore::Schema::Result::Sentence', {'foreign.document_id' => 'self.id'});

1;
