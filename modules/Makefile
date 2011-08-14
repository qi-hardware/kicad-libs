MODULES=8_10-card fiducial mini-usb pads qfn qfp sot-323 stdpass \
        usb-a-pcb usb_a_plug_smt

.SUFFIXES:	.fpd .mod
.PHONY:		all clean

all:		$(MODULES:%=%.mod)

clean:
		rm -f *~*.fpd

spotless:	clean
		rm -f $(MODULES:%=%.mod)

.fpd.mod:
		fped -k $< $@
