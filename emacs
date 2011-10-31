#!/usr/bin/perl

# Emacs starter
# Based on Aquamacs version (C) 2007, 2008, 2009 Aquamacs Emacs Project

# Revisions
# 1.0 - first version to be included with Emacs [2007-03-17 David Reitter] 
# 1.1 - delayed deletion of new files [2008-11-12 David Reitter]
# 1.2 - remove hard-coding of application path; consequently, remove sudo functionality
#     - shorter delay before deleting file
# 1.3 - changed application name (Emacs 2.0)

# to-do: re-implement in C (or as a shell script)

# $app_path = '/Applications/Emacs.app';
# $app_path = '<AQUAMACS-PATH>';
# $pid = qx"ps auxc | awk '/^$ENV{'USER'} .* Emacs\$/ {print \$2}'";

my $args = "";
my $tmpfiles = "";

for my $f (@ARGV) {
  $args .= '"'.$f.'" ';
  $tmpfiles .= '"'.$f.'" ' if (! -e $f);
}

system("touch $args") if ($tmpfiles);
 
 # there is still an issue:
 # if the sudo emacs is still open, it will 
 # call 'open' and open the files in the wrong
 # emacs process.
 
# if ($ENV{'USER'} ne "root")  # hack: not sudo
#  {
    # we can only call "open" with existing files.
    # that's why we create them just for the "open" call.

    system("open -a Emacs.app $args");
     
#  } else {
#    system("$app_path/Contents/MacOS/Emacs $args 2>/dev/null &");
#  }

# delay deletion because AE drag&drop doesn't work with non-existing documents
system("(sleep 3; rm $tmpfiles) &") if ($tmpfiles);
 
exit;


