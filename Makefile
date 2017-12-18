test:
	ocamlbuild -use-ocamlfind test.byte && ./test.byte

check:
	bash checkenv.sh && bash checktypes.sh

play:
	ocamlbuild -use-ocamlfind main.byte && ./main.byte

zipcheck:
	bash checkzip.sh

clean:
	ocamlbuild -clean
	rm -f checktypes.ml
