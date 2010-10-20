MODULES=pads stdpass usd-card

.SUFFIXES:	.fpd .mod
.PHONY:		all clean

all:		$(MODULES:%=%.mod)

clean:
		rm -f *~*.fpd

spotless:	clean
		rm -f $(MODULES:%=%.mod)

.fpd.mod:
		fped -k $< $@
