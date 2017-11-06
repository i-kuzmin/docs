# === Asciidoc ===
__default_src := $(notdir ${CURDIR}).adoc
ifneq (,$(wildcard ${__default_src}))
  SOURCE.adoc += ${__default_src}
endif

ifneq (,${SOURCE.adoc})
  ifeq (,$(filter ${BACKEND.adoc},asciidoctor asciidoc))
    $(error Unknown 'adoc' backed: '${BACKEND.adoc}')
  else
    include ${TOOLCHAIN}/makefiles/drivers/$(strip ${BACKEND.adoc}).mk
  endif
endif

# === Txt2Tags ===

__default_src := $(notdir ${CURDIR}).t2t
ifneq (,$(wildcard ${__default_src}))
  SOURCE.t2t += ${__default_src}
endif

ifneq (,${SOURCE.t2t})
  include ${TOOLCHAIN}/makefiles/drivers/t2t.mk
endif

# === Lout ===
ifneq (,${SOURCE.lout})
  include ${TOOLCHAIN}/makefiles/drivers/lout.mk
endif

# ==============================================================================

