.PHONY: build test typecheck clean examples

build:
	poetry install

test:
	python -c "import sd_client"
	pytest -s -vv tests/test_requestqueue.py

test-integration:
	pytest -v tests/test_client.py

test-examples:
	cd examples; pytest -v *.py
	cd examples; yes | python3 load_dataframe.py
	cd examples; python3 working_hours.py

typecheck:
	poetry run mypy

PYFILES=sd_client/*.py examples/*.py

lint:
	ruff check .

lint-fix:
	pyupgrade --py38-plus ${PYFILES} --exit-zero-even-if-changed
	ruff check --fix .

format:
	black .

clean:
	rm -rf build dist
	rm -rf sd_client/__pycache__
