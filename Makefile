mytool: mytool.l mytool.y
	    bison -d mytool.y
		flex -omytool.yy.c mytool.l
		gcc -o $@ mytool.tab.c mytool.yy.c mytool.tab.h -lfl
clean:
	   rm mytool mytool.tab.* mytool.yy.c