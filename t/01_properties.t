use strict;
use Template::Plugin::Properties;
use Template::Test;

test_expect(\*DATA);

__END__
--test--
[% USE props = Properties('t/props') -%]
[% FOREACH name = props.names.sort -%]
[% name %] = [% props.get(name) %]
[% END -%]
baz = [% props.get('baz', 'default baz') %]
--expect--
bar = baz
foo = bar
baz = default baz
