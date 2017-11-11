ifdef DEBUG
    $(info #  Load asciidoc driver)
endif

ASCIIDOC := asciidoc
A2X 	 := a2x

ifneq (,$(wildcard imags))
	A2X_FLAGS += -r imgs
endif

A2X_FLAGS.html += ${A2X_FLAGS} -D ${BUILD.html} -f xhtml
A2X_FLAGS.pdf  += ${A2X_FLAGS} -D ${BUILD.pdf} -f pdf --dblatex-opts " -P doc.layout=\"coverpage mainmatter\" -P doc.publisher.show=0"

ifeq "${DEBUG}" "YES"
	A2X_FLAGS += --verbose
endif

asciidoc__make_pdf=$(call asciidoc___make_pdf,$1,$(basename $1).pdf)
define asciidoc___make_pdf =
$2: $1 |${BUILD.pdf}
	${ECHO} "#  compile [pdf] $$<"
	${A2X} ${A2X_FLAGS.pdf} $$<
	${MV} ${BUILD.pdf}/$$@ $$@
	${ECHO} "#  done $$@"
CLEAN_PDF += $2
ALL_PDF += $2
endef

asciidoc__make_html=$(call asciidoc__make_html_impl,$1,$(basename $1).html)

ASCIIDOC_FLAGS := -a toolchain=${TOOLCHAIN} \
   				  -f ${TOOLCHAIN}/etc/asciidoc/asciidoc.conf
define asciidoc__make_html_impl =
${BUILD.html}/$2: $1 |${BUILD.html}
	${ECHO} "#  compile [asciidoc:html] $$<"
	${ASCIIDOC} ${ASCIIDOC_FLAGS} -o $$@ -b html5 $$<
CLEAN_HTML += ${BUILD.html}/$2
ALL_HTML += ${BUILD.html}/$2
endef

asciidoc__to_pdf=$(eval $(call asciidoc__make_pdf,$1))
asciidoc__to_html=$(eval $(call asciidoc__make_html,$1))

$(foreach src,${SOURCE.adoc},$(call asciidoc__to_html,${src}))
$(foreach src,${SOURCE.adoc},$(call asciidoc__to_pdf,${src}))
