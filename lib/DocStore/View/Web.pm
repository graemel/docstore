package DocStore::View::Web;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

=head1 NAME

DocStore::View::Web - TT View for DocStore

=head1 DESCRIPTION

TT View for DocStore.

=head1 SEE ALSO

L<DocStore>

=head1 AUTHOR

Graeme

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
