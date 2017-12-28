# === default sources ===

DEFAULT_EXT := adoc t2t lout plt

drivers__name := $(notdir ${CURDIR})
define drivers__add_default_source =
  ifneq (,$(wildcard ${drivers__name}.$1))
    SOURCES.$1 += ${drivers__name}.$1
  endif
endef

$(foreach ext,${DEFAULT_EXT}, \
	$(eval $(call drivers__add_default_source,${ext})))

# === Asciidoc ===
ifneq (,${SOURCES.adoc})
  ifeq (,$(filter ${BACKEND.adoc},asciidoctor asciidoc))
    $(error Unknown 'adoc' backed: '${BACKEND.adoc}')
  else
    include ${TOOLCHAIN}/makefiles/drivers/$(strip ${BACKEND.adoc}).mk
  endif
endif

# === Txt2Tags ===
ifneq (,${SOURCES.t2t})
  include ${TOOLCHAIN}/makefiles/drivers/t2t.mk
endif

# === Lout ===
ifneq (,${SOURCES.lout})
  include ${TOOLCHAIN}/makefiles/drivers/lout.mk
endif

# === Gnuplot ===
ifneq (,${SOURCES.plt})
  include ${TOOLCHAIN}/makefiles/drivers/gnuplot.mk
endif

drivers_help:
	$(ECHO) "#  Drivers:"
	$(ECHO) "#    implicit soruces: \
		$(filter ${drivers__name}.%,\
			$(foreach ext,${DEFAULT_EXT},${SOURCES.${ext}}))"
	$(ECHO) "#    BACKEND.adoc - backend for aciidoc. (asciidoc[|tor]: '${BACKEND.adoc}')"
	$(ECHO) "#"

help: drivers_help
.PHONY: drivers_help

# ==============================================================================

