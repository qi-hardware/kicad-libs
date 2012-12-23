MODULES=8_10-card 8_10-socket-ra 8_10-socket-ra-push-pull \
	bat-clip-aa-th bga \
	c-smd c-t-smd \
	dcjack dfn din-5 dip dip4of6 do-214 dvi-recept-ra \
	e-switch320 eus evqq7 \
        fiducial \
	header he-2row-dip he-shrouded \
	ir \
	lga ledsmd \
	mdip meander-2450MHz mic-ra-dip mini-usb\
	pads pads-array phonejack \
	qfn qfp \
	rca-3-ra rj45 \
	soic sot23 spacer sot sot-323 ssop stdpass \
	tactile-sw-spst-ra-dip to tsop tssop5 \
	usb-a-dual-recept-r usb-a-pcb usb_a_plug_smt \
	xlr-plug xlr-socket \
 	xtal-2 xtal-4 \
	zx62-b-5pa zx62m-b-5p

SHELL = /bin/bash

TITLE_NAME = FOOTPRINTS/MODULES
TITLE_FILE = kicad-libs-modules.pdf

.SUFFIXES:	.fpd .mod
.PHONY:		all brd catalog view upload missing clean spotless

all:		$(MODULES:%=%.mod)

.fpd.mod:
		fped -k $< $@

modules.pro:	Makefile
		../scripts/modules-pro template.pro $(MODULES) >$@ || \
		    { rm -f $@; exit 1; }

brd:		all modules.pro
		pcbnew `pwd`/modules.brd

include ../common/Makefile.title

catalog catalog.pdf: HIERARCHY $(MODULES:%=%.fpd)
		$(MAKE) title.ps
		genkicat -F -p $(MODULES:%=-l %.fpd) -t title.ps \
		  HIERARCHY DESCR >catalog.pdf || \
		  { rm -f catalog.pdf; exit 1; }

view:		catalog.pdf
		$${DSV_PDFVIEWER:-xpdf} catalog.pdf

upload:		catalog.pdf
		qippl catalog.pdf tmp/kicad-libs-modules.pdf

missing:
		../scripts/missing-in-tree -F $(MODULES:%=-l %.fpd) HIERARCHY

clean:
		rm -f *~*.fpd
		rm -f title.ps

spotless:	clean
		rm -f $(MODULES:%=%.mod)
		rm -f modules.pro
