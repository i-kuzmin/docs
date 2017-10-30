ifdef DEBUG
    $(info #  Load t2t driver)
endif

TXT2TAGS = txt2tags --config-file ${TOOLCHAIN}/txt2tags/txt2tagsrc
ifndef DEBUG
  TXT2TAGS += -q
endif

define t2t__make_html =
${BUILD.html}/$2: $1 ${BUILD.html}/t2t.css |${BUILD.html}
	${ECHO} "#  compile [t2t->html] $$<"
	${TXT2TAGS} -t html -o $$@ $$<
CLEAN_HTML += ${BUILD.html}/$2
ALL_HTML += ${BUILD.html}/$2
endef

t2t__to_html=$(eval $(call t2t__make_html,$1,$(basename $1).html))

$(foreach src,${SOURCE.t2t},$(call t2t__to_html,${src}))

${BUILD.html}/t2t.css: ${TOOLCHAIN}/txt2tags/t2t.css
	${ECHO} "#  install [t2t] t2t.css"
	${CP} $< $@

CLEAN_HTML += ${BUILD.html}/t2t.css
