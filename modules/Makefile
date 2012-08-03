MODULES=8_10-card 8_10-socket-ra \
	bat-clip-aa-th bga \
	c-smd c-t-smd \
	dcjack din-5 dip dip4of6 do-214 dvi-recept-ra \
	eus \
        fiducial \
	header he-2row-dip he-shrouded \
	ir \
	ledsmd \
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

.SUFFIXES:	.fpd .mod
.PHONY:		all catalog view upload missing clean spotless

all:		$(MODULES:%=%.mod)

.fpd.mod:
		fped -k $< $@

catalog catalog.pdf: HIERARCHY $(MODULES:%=%.fpd)
		genkicat -F -p $(MODULES:%=-l %.fpd) HIERARCHY DESCR \
		  >catalog.pdf || \
		  { rm -f catalog.pdf; exit 1; }

view:		catalog.pdf
		$${DSV_PDFVIEWER:-xpdf} catalog.pdf

upload:		catalog.pdf
		qippl catalog.pdf tmp/kicad-libs-modules.pdf

missing:
		../scripts/missing-in-tree -F $(MODULES:%=-l %.fpd) HIERARCHY

clean:
		rm -f *~*.fpd

spotless:	clean
		rm -f $(MODULES:%=%.mod)

