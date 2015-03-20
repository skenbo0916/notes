my $prizeProbabilityTable = {
    prize_1 => 10,
    prize_2 => 20,
    prize_3 => 30,
    prize_4 => 40,
};

my $prizePool = [ map{ ($_) x $prizeProbabilityTable->{$_} } keys $prizeProbabilityTable ];

$prizePool->[ int rand($#$prizePool + 1) ];
