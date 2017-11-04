ifdef DEBUG
    $(info #  Load asciidoctortor driver)
endif

ASCIIDOCTOR := asciidoctor

#
# PDF driver
#

define asciidoctor__make_pdf =
$2: $1 |${BUILD.pdf}
	${ECHO} "#  compile [pdf] $$<"
	${ECHO} "#  not implemented"
	false

CLEAN_PDF += $2
ALL_PDF += $2
endef

$(foreach src,${SOURCE.adoc},$(eval $(call asciidoctor__make_pdf,${src},$(basename ${src}).pdf)))

#
# HTML driver
#

asciidoctor_ext := ${TOOLCHAIN}/asciidoctor

ASCIIDOCTOR_FLAGS := -a toolchain=${TOOLCHAIN} \
					 -r ${asciidoctor_ext}/attributes.rb

define asciidoctor__make_html_impl =
${BUILD.html}/$2: $1 |${BUILD.html}
	${ECHO} "#  compile [asciidoctor:html] $$<"
	${ASCIIDOCTOR} ${ASCIIDOCTOR_FLAGS} -o $$@ -b html5 $$<
CLEAN_HTML += ${BUILD.html}/$2
ALL_HTML += ${BUILD.html}/$2
endef

asciidoctor__make_html = $(eval $(call asciidoctor__make_html_impl,$1,$(basename $1).html))

$(foreach src,${SOURCE.adoc},$(call asciidoctor__make_html,${src}))
