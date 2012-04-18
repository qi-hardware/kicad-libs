#
# From http://svn.openmoko.org/trunk/gta02-core/components/
#
# Note that we don't have the concept of a "library of everything" so far.
#

.PHONY:		all sch catalog view upload missing clean spotless

all:		sch

#		@echo "make what ? targets: sch loe"
#		@exit 1

sch:
		eeschema `pwd`/components.sch

DESCR-dcm:	*.dcm
		../scripts/dcm2desc -L . >$@ || { rm -f $@; exit 1; }

catalog catalog.pdf: EXPAND DESCR-dcm *.lib
		genex -p -L . EXPAND DESCR-dcm >catalog.pdf || \
		  { rm -f catalog.pdf; exit 1; }

view:		catalog.pdf
		$${DSV_PDFVIEWER:-xpdf} catalog.pdf

upload:		catalog.pdf
		qippl catalog.pdf tmp/kicad-libs-components.pdf

missing:
		../scripts/missing-in-tree -L . EXPAND

#loe:
#		./mkloe

clean:
		rm -f DESCR-dcm

spotless:	clean
		rm -f catalog.pdf
