#
# From http://svn.openmoko.org/trunk/gta02-core/components/
#
# Note that we don't have the concept of a "library of everything" so far.
#

.PHONY:		all sch catalog missing clean spotless

all:		sch

#		@echo "make what ? targets: sch loe"
#		@exit 1

sch:
		eeschema `pwd`/components.sch

DESCR-dcm:	*.dcm
		../scripts/dcm2desc -L . >$@ || { rm -f $@; exit 1; }

catalog:	DESCR-dcm
		genex -p -L . EXPAND DESCR-dcm >catalog.pdf || \
		  { rm -f catalog.pdf; exit 1; }

missing:
		../scripts/missing-in-tree -L . EXPAND

#loe:
#		./mkloe

clean:
		rm -f DESCR-dcm

spotless:	clean
		rm -f catalog.pdf
