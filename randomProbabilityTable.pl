use List::Util qw/shuffle/;

my $prizeProbabilityTable = {
    prize_1 => 10,
    prize_2 => 20,
    prize_3 => 30,
    prize_4 => 40,
};
my @prizePool = shuffle( map{ ( ${{reverse( %$prizeProbabilityTable )}}{$_} ) x $_ } values $prizeProbabilityTable );
my $prize = $prizePool[ int rand $#prizePool ]; # you can just pop an element, or rnad() again here
