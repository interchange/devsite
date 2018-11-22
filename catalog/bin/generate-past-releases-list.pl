#!/usr/bin/perl

use strict;
use warnings;
use DateTime;

my $base_path = '/home/ftp/public_html';
my @files = `find $base_path/interchange/ -name "ANNOUNCEMENT-*" | tac`;
chomp for @files;
@files = sort { (stat $b)[9] <=> (stat $a)[9] } @files;

my $series;

for (@files) {
	my $file = $_;
	my $mtime = (stat $file)[9];
	my $timestamp = DateTime->from_epoch(epoch => $mtime)->ymd;

	( my $ftp_ann = $_ ) =~ s{$base_path}{https://ftp.interchangecommerce.org};
	( my $ftp_dir = $ftp_ann ) =~ s#ANNOUNC.*##;

	$_ = $file;
	s/.*ANNOUNCEMENT-(\d+\.\d+.+)\.txt// and $series = $1;

	print <<END;
<tr>
	<td>Interchange $series</td>
	<td>$timestamp</td>
	<td><a href="$ftp_ann">Announcement</a></td>
	<td><a href="$ftp_dir">Download</a></td>
</tr>
END
}
