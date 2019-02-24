@names = <*.GenePop>;
foreach $name (sort @names) {
        $count='';
        open(IN,"$name");
        open(OUT,">$name.tmp");
                while(<IN>){
                        chomp;
                        if(/^(gt\s+,)/){
                                s/$1//;
                                $count++;
                                $hash{$count} .= $_;
                                print OUT "$_\n";}
                }
}
@names = <*.tmp>;
foreach $name (sort @names) {
        open(IN,"$name");
        @tmp = <IN>;
        $count = split(/\s+/,$tmp[0])-1;
        $length{$name} = $count;
}
open(POS,">pos.txt");
open(COM,">pool_GenePop.txt");
foreach $name (@names) {
        $length = $length{$name};
        $start = $end+1;
        $end += $length;
        print POS "$name\t$start\-$end\n";
}
for ($i=1;$i<=keys %hash;$i++) {
     print COM "$hash{$i}"."\n";
}

