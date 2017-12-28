ifdef DEBUG
  $(info #  Load gnuplot driver)
endif

GNUPLOT=gnuplot

define gnuplot__make_svg =
$2: $1 |${BUILD.svg}
	${ECHO} "#  compile $$< -> $$@"
	${GNUPLOT} -d -e \
        "set terminal svg; \
         set output '$$@'; \
		" $$< 
ALL_SVG += $2
endef

gnuplot__to_svg=$(eval $(call gnuplot__make_svg, \
				$1,${BUILD.svg}/$(basename $1).svg))

$(foreach src,${SOURCE.plt},$(call gnuplot__to_svg,${src}))


define gnuplot__make_png =
$2: $1 |${BUILD.png}
	${ECHO} "#  compile compile $$< -> $$@"
	${GNUPLOT} -d -e \
        "set terminal png; \
         set output '$$@'; \
		" $$< 
ALL_PNG += $2
endef

gnuplot__to_png=$(eval $(call gnuplot__make_png, \
				$1,${BUILD.png}/$(basename $1).png))

$(foreach src,${SOURCE.plt},$(call gnuplot__to_png,${src}))
