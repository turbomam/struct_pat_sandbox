.PHONY: all clean person_validation

all: clean struct_pat_sandbox_linkml.json person_data.json

clean:
	rm -rf struct_pat_sandbox_linkml.json
	rm -rf person_data.json

struct_pat_sandbox_linkml.json: struct_pat_sandbox.yaml
	poetry run gen-linkml --output $@ $<

person_data.json: struct_pat_sandbox.yaml person_data.yaml
	poetry run linkml-convert --target-class Person --output $@ --schema $^
