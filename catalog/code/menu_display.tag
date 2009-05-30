UserTag menu_display Order name
UserTag menu_display AddAttr
UserTag menu_display Routine <<EOR
sub {
	my ($name, $opt) = @_;
	my ($set, $uri, @entries, $name_qtd, @fields, $fstr);

	$Tag->perl({tables => 'menus'});

	$name_qtd = $Db{menus}->quote($name);

	@fields = qw/code name url parent permission/;
		
	$fstr = join(',', @fields);

	$set = $Db{menus}->query({sql => qq{select $fstr from menus where menu_name = $name_qtd order by parent asc, weight desc, code}, hashref => 1});

	for (@$set) {
		next unless $Tag->acl('check', $_->{permission});

		$uri = $Tag->area($_->{url});

		push(@entries, qq{<li><a href="$uri">$_->{name}</a></li>});
	}

	return q{<ul>} . join('', @entries) . q{</ul>};
}
EOR