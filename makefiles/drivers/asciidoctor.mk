ifdef DEBUG
    $(info #  Load asciidoctortor driver)
endif

asciidoctor_ext := ${TOOLCHAIN}/etc/asciidoctor
ASCIIDOCTOR := asciidoctor

SOURCE.adoc := $(sort ${SOURCE.adoc})

#
# PDF driver
#

asciidoctor__make_pdf = $(call asciidoctor___make_pdf,$1,${BUILD.pdf}/$(basename $1).pdf)
define asciidoctor___make_pdf =
$2: $1 |${BUILD.pdf}
	${ECHO} "#  compile [$$<] $$@"
	BACKEND=pdf ${ASCIIDOCTOR} \
	  -r ${asciidoctor_ext}/attributes.rb \
      -b pdf -o $$@ $$<
ALL_PDF += $2
endef
$(foreach src,${SOURCE.adoc},$(eval $(call asciidoctor__make_pdf,${src})))

#
# HTML driver
#

asciidoctor__make_html = $(eval $(call asciidoctor__make_html_impl,$1,${BUILD.html}/$(basename $1).html))
define asciidoctor__make_html_impl =
$2: $1 |${BUILD.html}
	${ECHO} "#  compile [$$<] $$@"
	BACKEND=html ${ASCIIDOCTOR} \
	   	-r ${asciidoctor_ext}/attributes.rb \
        -o $$@ -b html5 $$<
ALL_HTML += $2
endef

$(foreach src,${SOURCE.adoc},$(call asciidoctor__make_html,${src}))

#
# Latex driver
#
asciidoctor__make_latex = $(eval $(call asciidoctor__make_latex_impl,$1,${BUILD.latex}/$(basename $1).latex))
define asciidoctor__make_latex_impl =
$2: $1 |${BUILD.latex}
	${ECHO} "#  compile [$$<] $$@"
	${ASCIIDOCTOR} -r asciidoctor-latex -o $$@ -b latex $$<
ALL_LATEX += $2
endef

$(foreach src,${SOURCE.adoc},$(call asciidoctor__make_latex,${src}))




