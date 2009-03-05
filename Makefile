#
# $Id: Makefile,v 1.3 2008/10/07 12:58:00 holger Exp $
#

NAME = cyrus2dovecot
RELEASE = 1.3
SECTION = 8

all: doc

release: rcs doc

doc: $(NAME).ps $(NAME).html

#
# $(NAME).log sollte keine Zeilen enthalten, die laenger als 64 Zeichen sind.
#
rcs: $(NAME).log
	ci -u -wholger cyrus2dovecot < $(NAME).log

$(NAME).ps: $(NAME)
	pod2man \
		--quotes=none \
		--center=ZEDAT \
		--release=$(RELEASE) \
		--section=$(SECTION) \
		$(NAME) $(NAME).$(SECTION)
	groff \
		-Tps \
		-dpaper=a4 \
		-P-pa4 \
		-fN \
		-man \
		$(NAME).$(SECTION) > $(NAME).ps
	@echo Created: $(NAME).ps

$(NAME).html: $(NAME)
	pod2html \
		--index \
		--nonetscape \
		--infile=$(NAME) \
		--outfile=$(NAME).html
	@rm -f pod2htmd.tmp pod2htmi.tmp
	@echo Created: $(NAME).html

clean:
	rm \
		-f \
		tmon.out \
		pod2htmd.tmp \
		pod2htmi.tmp \
		$(NAME).ps \
		$(NAME).html \
		$(NAME).$(SECTION)

install:
	@echo '$(NAME) is "release"d but never "install"ed.'
