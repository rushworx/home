echo 'main() {long i;for(i=0;i<1000000000;i++);}' > i.c; gcc -O0 -o i i.c; nice -n -20 /usr/bin/time ./i 2>&1 | grep -oE '[0-9.]+user'

