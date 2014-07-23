QMAKE_TARGET  = loadDropdownFromSQL
PROJECT_DIR	  := $(dir $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST)))
I18N_DIR	  := $(PROJECT_DIR)/translations

include mk/cs-base.mk

