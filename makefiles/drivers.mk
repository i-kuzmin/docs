# === default sources ===

DEFAULT_EXT := adoc t2t lout plt

drivers__name := $(notdir ${CURDIR})
define drivers__add_default_source =
  ifneq (,$(wildcard ${drivers__name}.$1))
    SOURCE.$1 += ${drivers__name}.$1
  endif
endef

$(foreach ext,${DEFAULT_EXT}, \
	$(eval $(call drivers__add_default_source,${ext})))

# === Asciidoc ===
ifneq (,${SOURCE.adoc})
  ifeq (,$(filter ${BACKEND.adoc},asciidoctor asciidoc))
    $(error Unknown 'adoc' backed: '${BACKEND.adoc}')
  else
    include ${TOOLCHAIN}/makefiles/drivers/$(strip ${BACKEND.adoc}).mk
  endif
endif

# === Txt2Tags ===
ifneq (,${SOURCE.t2t})
  include ${TOOLCHAIN}/makefiles/drivers/t2t.mk
endif

# === Lout ===
ifneq (,${SOURCE.lout})
  include ${TOOLCHAIN}/makefiles/drivers/lout.mk
endif

# === Gnuplot ===
ifneq (,${SOURCE.plt})
  include ${TOOLCHAIN}/makefiles/drivers/gnuplot.mk
endif

drivers_help:
	$(ECHO) "#  Drivers:"
	$(ECHO) "#    implicit soruces: \
		$(filter ${drivers__name}.%,\
			$(foreach ext,${DEFAULT_EXT},${SOURCE.${ext}}))"
	$(ECHO) "#    BACKEND.adoc - backend for aciidoc. (asciidoc[|tor]: '${BACKEND.adoc}')"
	$(ECHO) "#"

help: drivers_help
.PHONY: drivers_help

# ==============================================================================

