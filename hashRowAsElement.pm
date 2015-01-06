package hashRowAsElement;

use strict;
use warnings;

=item $arrayRefOfHashRef = hashRowAsElement( $csvStringSplitByCamma, $startCellContent );
      e.g. [ {row1}, {row2}, ... ], row = each line in .csv
=cut

sub hashRowAsElement {
    my( $termMap, $res, $startTag ) = ( {}, [], 0 );

    for my $line ( split /\n/, $_[0] ) {

	$line =~ s/(?:\s)$//; # chomp
	$line =~ s/(?:\xEF\xBB\xBF)//g; # remove BOM

	my @allTerms = split /,/, $line ;

	if( $startTag ) {
	    my $temp = {};

	    while( my( $index, $term ) = each %{ $termMap } ) {
		$temp->{ $term } = $allTerms[ $index ];
	    }

	    push @{$res}, $temp;

	} elsif( $allTerms[0] eq $_[1] ) {

	    $termMap->{ $_ } = $allTerms[ $_ ] for( 0..$#allTerms );

	    $startTag = 1;
	}
    }

    $res // {};
}
