ifdef DEBUG
    $(info #  Load lout driver)
endif

LOUT:=lout -a -s
PS2PDF:= ps2pdf

#${MV} ${BUILD.pdf}/$$@ $$@
define lout__make_pdf =
$2: $1 |${BUILD.pdf}
	${ECHO} "#  compile [pdf] $$<"
	${LOUT} -o ${BUILD.pdf}/$1.ps $$<
	${PS2PDF} ${BUILD.pdf}/$1.ps $$@
	${RM} ${BUILD.pdf}/$1.ps
	${ECHO} "#  done $$@"
CLEAN_PDF += $2
ALL_PDF += $2
endef
lout__to_pdf = $(eval $(call lout__make_pdf,$1,$(basename $1).pdf))
$(foreach src,${SOURCE.lout},$(call lout__to_pdf,${src}))
