MODULES=0805-6 1059 8_10-card 8_10-socket-ra 8_10-socket-ra-push-pull \
	bat-clip-aa-th bga \
	c-smd c-t-smd \
	dcjack df40 dfn din-5 dip dip4of6 do-214 dvi-recept-ra \
	e-switch320 er-oled-fpc30 eus evqq7 \
        fiducial \
	header he-2row-dip he-shrouded header-50mil-pin \
	inductor-2p ir \
	jtrace \
	lga ledsmd lp2032sm \
	mdip meander-2450MHz memcard8-amp-10100660 memcard8-hirose-dm3cs \
	memcard8-jae-st1w008s4b memcard8-molex-1050270001 memcard8-molex-47309 \
	mic-ra-dip mini-usb msl0104 \
	pads pads-array phonejack pogo \
	qfn qfp \
	rca-3-ra rev-led rj45 \
	sod soic sot23 spacer sot sot-323 ssop stdpass stqfn20 sw-spdt-smt \
	tact-4-rect-smt tactile-sw-spst-ra-dip to tsop tssop5 tswa \
	usb-a-dual-recept-r usb-a-pcb usb_a_plug_smt usb_a_rcpt_smt \
	usb_a_rcpt_mid \
	vson-powerpad \
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
