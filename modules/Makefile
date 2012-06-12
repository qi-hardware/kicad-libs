MODULES=8_10-card bat-clip-aa-th \
        fiducial meander-2450MHz mini-usb pads pads-array \
	qfn qfp sot sot-323 ssop stdpass \
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
