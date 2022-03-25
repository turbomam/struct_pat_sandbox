.PHONY: all clean person_validation

all: clean struct_pat_sandbox_linkml.json person_data.json

clean:
	rm -rf struct_pat_sandbox_linkml.json
	rm -rf person_data.json

struct_pat_sandbox_linkml.json: struct_pat_sandbox.yaml
	poetry run gen-linkml --output $@ $<

person_data.json: struct_pat_sandbox.yaml person_data.yaml
	poetry run linkml-convert --target-class Person --output $@ --schema $^

# linkml-convert [OPTIONS] INPUT
#
#  Converts instance data to and from different LinkML Runtime serialization
#  formats.
#
#  The instance data must conform to a LinkML model, and there must be python
#  dataclasses generated from that model. The converter works by first using a
#  linkml-runtime loader to instantiate in-memory model objects, then dumpers
#  are used to serialize. When converting to or from RDF, a JSON-LD context
#  must also be passed
#
#Options:
#  -m, --module TEXT               Path to python datamodel module
#  -o, --output TEXT               Path to output file
#  -f, --input-format [yaml|json|rdf|ttl|json-ld|csv|tsv]
#                                  Input format. Inferred from input suffix if
#                                  not specified
#  -t, --output-format [yaml|json|rdf|ttl|json-ld|csv|tsv]
#                                  Output format. Inferred from output suffix
#                                  if not specified
#  -C, --target-class TEXT         name of class in datamodel that the root
#                                  node instantiates
#  -S, --index-slot TEXT           top level slot. Required for CSV
#                                  dumping/loading
#  -s, --schema TEXT               Path to schema specified as LinkML yaml
#  --validate / --no-validate      Validate against the schema  [default:
#                                  validate]
#  -c, --context TEXT              path to JSON-LD context file. Required for
#                                  RDF input/output
#  --help                          Show this message and exit.
