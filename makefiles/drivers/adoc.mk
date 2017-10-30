ASCIIDOCTOR.mk :=${TOOLCHAIN}/makefiles/drivers/asciidoctor.mk
ASCIIDOC.mk    :=${TOOLCHAIN}/makefiles/drivers/asciidoc.mk

adoc_backend := ${BUILD}/.adoc.backend
CLEAN += ${adoc_backend}

ifeq (asciidoc,${BACKEND.adoc})
  include ${ASCIIDOC.mk}

else ifeq (asciidoctor,${BACKEND.adoc})
  include ${ASCIIDOCTOR.mk}

else
  TYPE := type &>/dev/null
  ${adoc_backend}: |${BUILD}
		(if ${TYPE} asciidoctor; then \
		echo "#  use 'asciidoctor' backend"  >/dev/stderr; \
		echo "include ${ASCIIDOCTOR.mk}"; \
	 elif ${TYPE} asciidoc; then \
		echo "#  use 'asciidoc' backend"  >/dev/stderr; \
		echo "include ${ASCIIDOC.mk}"; \
	 else \
		echo "$$(error asciidoc backend wasn\'t found."\
		     " Install 'asciidoctor' or 'asciidoc')"; \
	 fi) > $@
  include ${adoc_backend}
endif
