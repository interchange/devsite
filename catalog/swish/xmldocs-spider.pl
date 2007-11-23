# spider configuration file for XMLDOCS indexing

sub filter {
	my ($uri) = @_;

	if ($uri->path =~ m%/index\.html$%) {
		warn "Skipping " . $uri->as_string . "\n";
		return;
	}

	return 1;
}

@servers = (
			{
			 base_url => 'http://docs.icdevgroup.org/cgi-bin/online/index.html',
			 email => 'racke@icdevgroup.org',
			 filter_content => \&filter,
			}
			);
