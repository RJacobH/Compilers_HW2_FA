all: oh-one-one balanced end-oh-one-one even-ab evens braces

oh-one-one: oh-one-one.ll FALexer.hh
	flex -o oh-one-one.cc oh-one-one.ll
	g++ -std=c++17 -g -o oh-one-one oh-one-one.cc

balanced: balanced.ll balanced.hh
	flex -o balanced.cc balanced.ll
	g++ -std=c++17 -g -o balanced balanced.cc

end-oh-one-one: end-oh-one-one.ll FALexer.hh
	flex -o end-oh-one-one.cc end-oh-one-one.ll
	g++ -std=c++17 -g -o end-oh-one-one end-oh-one-one.cc

even-ab: even-ab.ll FALexer.hh
	flex -o even-ab.cc even-ab.ll
	g++ -std=c++17 -g -o even-ab even-ab.cc

evens: evens.ll FALexer.hh
	flex -o evens.cc evens.ll
	g++ -std=c++17 -g -o evens evens.cc

braces: braces.ll braces.hh
	flex -o braces.cc braces.ll
	g++ -std=c++17 -g -o braces braces.cc

clean:
	touch oh-one-one balanced end-oh-one-one even-ab evens braces foo~
	rm *~ oh-one-one balanced end-oh-one-one even-ab evens braces 
	touch oh-one-one.cc balanced.cc end-oh-one-one.cc even-ab.cc evens.cc braces.cc 
	rm oh-one-one.cc balanced.cc end-oh-one-one.cc even-ab.cc evens.cc braces.cc 
