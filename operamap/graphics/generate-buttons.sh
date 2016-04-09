#!/bin/sh

#F="http://my.nava.de/graphics/button.phtml"
F="http://nava.chili/test/button.phtml"
S="18"

# normal (deactivated)
wget -Ooperas.png "$F?text=Operas&s=$S&ob=JA"
wget -Ocomposers.png "$F?text=Composers&s=$S"
wget -Olibrettists.png "$F?text=Librettists&s=$S"
wget -Owriters.png "$F?text=Writers&s=$S"
wget -Otheatres.png "$F?text=Theatres&s=$S"
wget -Ocities-and-regions.png "$F?text=Cities%20and%20Regions&s=$S"
wget -Ocountries.png "$F?text=Countries&s=$S&un=JA"

wget -Oabout.png "$F?text=About&s=$S&ob=JA&un=JA"


# activated
wget -Ooperas-Act.png "$F?text=Operas&s=$S&act=1&ob=JA"
wget -Ocomposers-Act.png "$F?text=Composers&s=$S&act=1"
wget -Olibrettists-Act.png "$F?text=Librettists&s=$S&act=1"
wget -Owriters-Act.png "$F?text=Writers&s=$S&act=1"
wget -Otheatres-Act.png "$F?text=Theatres&s=$S&act=1"
wget -Ocities-and-regions-Act.png "$F?text=Cities%20and%20Regions&s=$S&act=1"
wget -Ocountries-Act.png "$F?text=Countries&s=$S&act=1&un=JA"

wget -Oabout-Act.png "$F?text=About&s=$S&act=1&ob=JA&un=JA"


# highlighted (mouseover)
wget -Ooperas-Hi.png "$F?text=Operas&s=$S&hi=1&ob=JA"
wget -Ocomposers-Hi.png "$F?text=Composers&s=$S&hi=1"
wget -Olibrettists-Hi.png "$F?text=Librettists&s=$S&hi=1"
wget -Owriters-Hi.png "$F?text=Writers&s=$S&hi=1"
wget -Otheatres-Hi.png "$F?text=Theatres&s=$S&hi=1"
wget -Ocities-and-regions-Hi.png "$F?text=Cities%20and%20Regions&s=$S&hi=1"
wget -Ocountries-Hi.png "$F?text=Countries&s=$S&hi=1&un=JA"

wget -Oabout-Hi.png "$F?text=About&s=$S&hi=1&ob=JA&un=JA"
