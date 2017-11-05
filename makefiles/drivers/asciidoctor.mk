ifdef DEBUG
    $(info #  Load asciidoctortor driver)
endif

asciidoctor_ext := ${TOOLCHAIN}/asciidoctor
ASCIIDOCTOR := asciidoctor

#
# PDF driver
#

asciidoctor__make_pdf = $(call asciidoctor___make_pdf,$1,${BUILD.pdf}/$(basename $1).pdf)
define asciidoctor___make_pdf =
$2: $1 |${BUILD.pdf}
	${ECHO} "#  compile [asciidoctor:pdf] $$<"
	${ASCIIDOCTOR} -r ${asciidoctor_ext}/attributes-pdf.rb \
	   			   -r asciidoctor-pdf \
			   	   -o $$@ -b pdf $$<
CLEAN_PDF += $2
ALL_PDF += $2
endef

$(foreach src,${SOURCE.adoc},$(eval $(call asciidoctor__make_pdf,${src})))

#
# HTML driver
#

asciidoctor__make_html = $(eval $(call asciidoctor__make_html_impl,$1,${BUILD.html}/$(basename $1).html))
define asciidoctor__make_html_impl =
$2: $1 |${BUILD.html}
	${ECHO} "#  compile [asciidoctor:html] $$<"
	${ASCIIDOCTOR} -r ${asciidoctor_ext}/attributes-html.rb -o $$@ -b html5 $$<
CLEAN_HTML += $2
ALL_HTML += $2
endef

$(foreach src,${SOURCE.adoc},$(call asciidoctor__make_html,${src}))

#
# Latex driver
#
asciidoctor__make_latex = $(eval $(call asciidoctor__make_latex_impl,$1,${BUILD.latex}/$(basename $1).latex))
define asciidoctor__make_latex_impl =
$2: $1 |${BUILD.latex}
	${ECHO} "#  compile [asciidoctor:latex] $$<"
	${ASCIIDOCTOR} -r asciidoctor-latex -o $$@ -b latex $$<
CLEAN_LATEX += $2
ALL_LATEX += $2
endef

$(foreach src,${SOURCE.adoc},$(call asciidoctor__make_latex,${src}))




