# spider configuration file for XMLDOCS indexing

sub filter_url {
	my ($uri) = @_;

	$path = $uri->path;

	if ($path =~ m%^/(.*?)//%) {
		$uri->path($path);
		warn "Path with double-slashes found: $path\n";
		return;
	}

	return 1;
}

sub filter {
	my ($uri) = @_;
	my ($path, @frags);
	
	$path = $uri->path;

	if ($path =~ m%/index\.html$%) {
		return;
	}

	if ($path !~ m%[^/]+\.html$%) {
		return;
	}

	if ($path =~ m%/cgi-bin/offline/%) {
		return;
	}

	# accept only paths with at least two directories
	@frags = split(/\//, $path);

	if (@frags <= 2) {
		warn "Ignoring document $path (", scalar(@frags), ")\n";
		return;
	}
	
	return 1;
}

@servers = (
	{
		base_url => 'https://docs.interchangecommerce.org/cgi-bin/online/index.html',
		email => 'jon@endpointdev.com',
		test_url => \&filter_url,
		filter_content => \&filter,
	}
);
