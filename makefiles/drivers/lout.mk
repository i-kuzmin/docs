ifdef DEBUG
    $(info #  Load lout driver)
endif

LOUT:=lout -a -s
PS2PDF:= ps2pdf

lout__to_pdf = $(eval $(call lout__make_pdf,$1,${BUILD.pdf}/$(basename $1).pdf))
define lout__make_pdf =
$2: $1 |${BUILD.pdf}
	${ECHO} "#  compile [lout:pdf] $$<"
	${LOUT} -o ${BUILD.pdf}/$1.ps $$<
	${PS2PDF} ${BUILD.pdf}/$1.ps $$@
	${RM} ${BUILD.pdf}/$1.ps
	${ECHO} "#  done $$@"
CLEAN_PDF += $2
ALL_PDF += $2
endef
$(foreach src,${SOURCE.lout},$(call lout__to_pdf,${src}))
