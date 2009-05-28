UserTag action Order type text targets
UserTag action AddAttr
UserTag action HasEndTag
UserTag action Routine <<EOR
sub {
	my ($type, $text, $targets, $opt, $body) = @_;

	# compose form parameters
	my @form;

	push @form, 'mv_todo=go',
				"mv_components=$targets";

	if ($opt->{page}) {
		push (@form, "mv_nextpage=$opt->{page}");
	} else {
		push (@form, "mv_nextpage=$Config->{Special}->{target}");
	}

	# compose link
	if ($type eq 'link') {
		my $url = $Tag->area({href => 'process', form => join("\n", @form)});
		return qq{<a href="$url">$text</a>};

	} elsif ($type eq 'button') {
		return $Tag->button({text => $text, body => join("\n", @form)});

	# bounce page
	} elsif ($type eq 'bounce') {
		my $url = $Tag->area({href => 'process', form => join("\n", @form)});
		my $body = "Status: 302 moved\nLocation: $url";
		return  $Tag->tag({ op => 'header', body => $body });
	} else {
		::logError("Type $type is not supported by action tag.");
	}
}
EOR
