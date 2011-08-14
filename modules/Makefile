MODULES=8_10-card fiducial pads qfn qfp stdpass

.SUFFIXES:	.fpd .mod
.PHONY:		all clean

all:		$(MODULES:%=%.mod)

clean:
		rm -f *~*.fpd

spotless:	clean
		rm -f $(MODULES:%=%.mod)

.fpd.mod:
		fped -k $< $@
