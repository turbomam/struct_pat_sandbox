.PHONY: all clean person_validation

all: clean struct_pat_sandbox_linkml.json

clean:
	rm -rf struct_pat_sandbox_linkml.json

struct_pat_sandbox_linkml.json: struct_pat_sandbox.yaml
	poetry run gen-linkml --output $@ $<

person_validation:
	poetry run linkml-validate --help