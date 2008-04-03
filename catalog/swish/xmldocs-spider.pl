# spider configuration file for XMLDOCS indexing

sub filter_url {
	my ($uri) = @_;

	$path = $uri->path;
	if ($path =~ m%http://(.*?)/+%) {
		$uri->path($path);
		warn "Path with double-slashes found: $path\n";
		return;
	}

	return 1;
}

sub filter {
	my ($uri) = @_;

	if ($uri->path =~ m%/index\.html$%) {
		return;
	}

	return 1;
}

@servers = (
			{
			 base_url => 'http://docs.icdevgroup.org/cgi-bin/online/index.html',
			 email => 'racke@icdevgroup.org',
			 test_url => \&filter_url,
			 filter_content => \&filter,
			}
			);
