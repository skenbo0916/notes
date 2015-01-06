# access a reversed hash without declare another variable

my $h = {};
my $takeValue = ${ {reverse( %{ $h } )} }{ HASH_KEY };
