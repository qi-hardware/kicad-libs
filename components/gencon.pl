#!/usr/bin/perl
#
# gencon.pl - Generate generic connectors
#
# Copyright 2012, 2016 by Werner Almesberger
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#


sub intro
{
	local ($name, $h, $s) = @_;
	my $b = $s ? $h + 150 : $h;

	$name .= "_S$s" if $s;

	print "#\n# $name\n#\n";
	print "DEF $name CON 0 40 Y N 1 F N\n";
	print "F0 \"CON\" 0 " . ($h + 50) . " 60 H V C CNN\n";
	print "F1 \"$name\" 0 " . (-$b - 50) . " 60 H V C CNN\n";
}


sub box
{
	local ($h, $s) = @_;
	my $b = $s ? $h + 150 : $h;

	print "S -100 -$b 100 $h 0 1 0 N\n";
	for (my $i = 0; $i != $s; $i++) {
		my $n = sprintf("S%d", $i+1);

		print "X $n $n " . (400 * ($i - 0.5) * 2) . " " .
		    (-$h - 100) . " 300 " .
		    ("R", "L")[$i] . " 50 50 1 1 P\n";
	}
}


# Single and dual row, with the same number of pins in each row

sub even
{
	local ($x, $s) = @_;

	for (my $y = 1; $y <= 2; $y++) {
		my $name = "CONN_$x";
		my $h = $x / 2 * 100;

		$name .= "X$y" if $y > 1;
		&intro($name, $h, $s);

		print "DRAW\n";
		&box($h, $s);

		my $n = 1;

		for (my $px = 1; $px <= $x; $px++) {
			for (my $py = 1; $py <= $y; $py++) {
				print "X $n $n " . (400 * ($py - 1.5) * 2) .
				    " " . ($h - $px * 100 + 50) . " 300 " .
				    ("?", "R", "L")[$py] . " 50 50 1 1 P\n";
				$n++;
			}
		}
		print "ENDDRAW\n";
		print "ENDDEF\n";
	}
}


# Dual row, with rows differing by one pin (D-Sub and similar)

sub odd
{
	local ($x, $s) = @_;
	my $h = $x / 2 * 100;

	&intro("CONN_$x" . "_" . ($x - 1), $h, $s);
	print "DRAW\n";
	&box($h, $s);
	for (my $px = 1; $px <= $x; $px++) {
		print "X $px $px -400 " .
		    ($h - $px * 100 + 50) . " 300 R 50 50 1 1 P\n";
		next if $px == $x;
		$n = $px + $x;
		print "X $n $n 400 " .
		    ($h - $px * 100) . " 300 L 50 50 1 1 P\n";
	}
	print "ENDDRAW\n";
	print "ENDDEF\n";
}


print "EESchema-LIBRARY Version 2.3  Date: `date`\n";
print "#encoding utf-8\n";
for ($x = 1; $x <= 40; $x++) {
	for ($s = 0; $s <= 2; $s++) {
		&even($x, $s);
		&odd($x, $s) if $x > 1;
	}
}
print "#\n#End Library\n";
