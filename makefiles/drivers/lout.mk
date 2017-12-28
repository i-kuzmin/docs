ifdef DEBUG
    $(info #  Load lout driver)
endif

LOUT   := lout -a -s
PS2PDF := ps2pdf
#ICONV  := iconv -c -f utf8 -t koi8-r

lout_to_pdf = $(eval $(call lout_make_pdf,$1,${BUILD.pdf}/$(basename $1).pdf))
define lout_make_pdf =
$2: $1 |${BUILD.pdf}
	${ECHO} "#  compile [lout:pdf] $$<"
	${TOOLCHAIN}/bin/ulout "$$<"  "${BUILD.pdf}/$1.ps"
	${PS2PDF} ${BUILD.pdf}/$1.ps $$@
	${RM} ${BUILD.pdf}/$1.ps "$${BUILD.pdf}/koi8-r.$$<"
	${ECHO} "#  done $$@"
ALL_PDF += $2
endef
	#${TOOLCHAIN}/bin/ulout "$$<" | ${ICONV} -  -o "$${BUILD.pdf}/koi8-r.$$<"
	#${LOUT} -o ${BUILD.pdf}/$1.ps "$${BUILD.pdf}/koi8-r.$$<"
$(foreach src,$(sort ${SOURCE.lout}),$(call lout_to_pdf,${src}))
