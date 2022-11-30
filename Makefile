
PROJECT_DIR=dataplatform
PROFILES_DIR=.dbt
TARGET=dev 
SELECTOR=dataplatform

.PHONY: all
all: install configure compile run test

.PHONY: install
install:
	pip install --upgrade pip setuptools wheel
	pip install --requirement $(PROJECT_DIR)/requirements.txt

.PHONY: configure
configure:
	dbt debug --project-dir $(PROJECT_DIR) --profiles-dir $(PROFILES_DIR) --target $(TARGET)


.PHONY: compile
compile:
	dbt compile --project-dir $(PROJECT_DIR) --profiles-dir $(PROFILES_DIR) --target $(TARGET)


.PHONY: docs
docs:
	dbt docs generate --project-dir $(PROJECT_DIR) --profiles-dir $(PROFILES_DIR) --target $(TARGET)
	dbt docs serve --project-dir $(PROJECT_DIR) --profiles-dir $(PROFILES_DIR) --target $(TARGET)


.PHONY: run
run: 
	dbt run --project-dir $(PROJECT_DIR) --profiles-dir $(PROFILES_DIR) --select $(SELECTOR) --target $(TARGET) 

.PHONY: test
test:
	dbt test --project-dir $(PROJECT_DIR) --profiles-dir $(PROFILES_DIR) --select $(SELECTOR) --target $(TARGET)

.PHONY: clean
clean:
	dbt clean --project-dir $(PROJECT_DIR) --profiles-dir $(PROFILES_DIR) --target $(TARGET)

.PHONY: deps
deps:
	dbt deps --project-dir $(PROJECT_DIR) --profiles-dir $(PROFILES_DIR) --target $(TARGET)
