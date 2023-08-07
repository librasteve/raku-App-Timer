unit class Timer:ver<0.0.1>:auth<Steve Roe (librasteve@furnival.net)>;

has Bool $!running;

has Int $!hundredths is default(0);
has Int $!seconds    is default(0);
has Int $!minutes    is default(0);

method tick {
    sleep 1 / 10000;  # hundredths, sped up x100

    $!hundredths += 1;
    $!seconds    += $!hundredths div 100;
    $!minutes    += $!seconds    div  60;
    
    $!hundredths mod= 100;
    $!seconds    mod=  60;
    
    self.show;
}   

method show {
    sub d2($x) { $x.fmt('%02d'); }
    
    print "--> " ~ d2($!minutes) 
           ~ ":" ~ d2($!seconds) 
           ~ "." ~ d2($!hundredths) ~ "\b" x 12;
}   

method start {
    $!running = True;
    start { 
        self.tick while $!running;
        }   
    }   
    
method stop {
    $!running = False;
    self.show;
}   

method reset {
    ($!hundredths, $!seconds, $!minutes) = Nil xx 3;
}   

