package Template::Plugin::Properties;

use strict;
use vars qw($VERSION);
$VERSION = 0.01;

require Template::Plugin;
use base qw(Template::Plugin);

use Data::Properties;
use FileHandle;

sub croak { require Carp; Carp::croak(@_); }

sub new {
    my($class, $context, $filename, $params) = @_;
    my $handle = FileHandle->new($filename) or croak("$filename: $!");
    my $props  = Data::Properties->new;
    $props->load($handle);
    bless { _props => $props }, $class;
}

sub props { shift->{_props} }

sub get {
    my $self = shift;
    $self->props->get_property(@_);
}

sub names {
    my $self = shift;
    return $self->props->property_names;
}


1;
__END__

=head1 NAME

Template::Plugin::Properties - TT Plugin to read Data::Properties file

=head1 SYNOPSIS

  [% USE props = Properties('/path/to/properties') %]
  [% FOREACH key = props.names %]
    [% key %] is [% props.get(key) %]
  [% END %]

  # get can accept default
  name is [% props.get('name', 'name (defaut)') %]

=head1 DESCRIPTION

Template::Plugin::Properties is a TT plugin which allows you to read
property variables from inside templates using Data::Properties.

=head1 AUTHOR

Tatsuhiko Miyagawa E<lt>miyagawa@bulknews.netE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Data::Properties>, L<Template::Plugin::Datafile>

=cut
