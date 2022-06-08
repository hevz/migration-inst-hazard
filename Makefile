test : test.c ibar.S
	gcc -O3 -o test test.c ibar.S -pthread

clean :
	rm -f test
