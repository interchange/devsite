#!/usr/local/bin/perl
#
# provide a URL on the commandline (ie check_ic.pl http://check.domain.com/)
# and script will test, based on cookies, if the site is IC or not
# 
# test is done on /  as well as on /admin/index
# using MV_SESSION_ID as the cookie value (not case sensitive)

my $cmd_for_curl = '/usr/bin/curl -s -I -L -A " Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; GTB6; .NET CLR 1.1.4322; .NET CLR 2.0.50727)" --connect-timeout 10';
my $verbose = $ARGV[1] || 0;
my (@urls, $is_ic);

if (-f "HF") {
  open(HF,"HF");
  @urls = <HF>;
  close(HF);
}

push (@urls, $ARGV[0]);

foreach my $url (@urls) {

  chomp($url);
  $is_ic = 0;

  print "Testing: $url\n";

  # 1. Test if homepage returns a cookie with mv_session_id
  open(HEAD,"$cmd_for_curl $url |") || print "cannot open $url";
  while (<HEAD>) {
  print;
    if (/MV_SESSION_ID/i) {
      print "$url appears to be Interchange (first pass)\n" if $verbose;
      $is_ic = 1;
      last;
    }
  }
  close(HEAD);
  
  # Found what we are looking for then go to next url
  next if $is_ic;

  # 2. Test if admin returns a cookie with mv_session_id
  open(HEAD,"$cmd_for_curl $url/admin/index |") || print "cannot open $url";
  while (<HEAD>) {
    if (/MV_SESSION_ID/i) {
      print "$url appears to be Interchange (second pass)\n" if $verbose;
      $is_ic = 1;
      last;
    }
  }
  close(HEAD);
  
  # Found what we are looking for then go to next url 
  next if $is_ic;
  
  print "$url appears to NOT be Interchange\n";
} 

exit;





#
#
#
#
use lib "../lib";
print "V:" . $HTTP::Cookies::VERSION . " \n";

my $cookie_jar = HTTP::Cookies->new || die('cannot create a cookie jar');

my $url = $ARGV[0];

my $ua = LWP::UserAgent->new;
$ua->cookie_jar($cookie_jar);
$ua->agent('Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)');
$ua->timeout(30);

my $response = $ua->get($url);

if ($response->is_success) {
  print "Response OK: checking cookie\n";
  $cookie_jar->extract_cookies($response) | die "cannot extract cookie: $!\n";
  if ($cookie_jar->as_string !~ /MV_SESSION_ID/i) {
    #2nd attempt: try /admin ...
    my $response2 = $ua->get($url . "/admin");
    if ($response2->is_success) {
      $cookie_jar->extract_cookies($response2);
      if ($cookie_jar->as_string !~ /MV_SESSION_ID/i) {
        print $url . " likely not (anymore) Interchange\n";
      }
      else {
        print $url . " appears to be Interchange (second pass)\n";
      }
    }
  }
  else {
    print $url . " appears to be Interchange (first pass) \n";
  }
}
else {
  die $response->status_line . "\n";
}

