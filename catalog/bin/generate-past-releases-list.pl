#!/usr/bin/perl

use warnings;
use strict;

my @files = `find /var/ftp/pub/interchange/ -name "ANNOUNCEMENT-*" | tac`;
chomp for @files;

my $series;

for (@files) {

	my $file = $_;
	my $mtime = (stat $file)[9];

	( my $ftp_ann = $_ ) =~ s#/var/ftp#ftp://ftp.icdevgroup.org#;
	( my $ftp_dir = $ftp_ann ) =~ s#ANNOUNC.*##;

	$_ = $file;
	s/.*ANNOUNCEMENT-(\d+\.\d+.+)\.txt// and $series = $1;

	print
		'<tr><td>Interchange ' . $series . '</td>'.
		'<td align="right">' . scalar localtime($mtime) . '</td>' .
		"<td><a href='$ftp_ann'>Announcement</a></td>" .
		"<td><a href='$ftp_dir'>FTP release directory</a></td></tr>" .
		"\n";

}

