/*
Perl Extension for the SHA Message-Digest Algorithm

This module by Uwe Hollerbach <uh@alumni.caltech.edu>
following example of MD5 module

This extension may be distributed under the same terms
as Perl. The SHA code is in the public domain.
*/

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "endian.h"
#include "sha.h"

typedef SHA_INFO	*SHA;

MODULE = SHA		PACKAGE = SHA

PROTOTYPES: DISABLE

SHA
new(packname = "SHA")
	char *		packname
    CODE:
	{
	    RETVAL = (SHA_INFO *) safemalloc(sizeof(SHA_INFO));
	    sha_init(RETVAL);
	}
    OUTPUT:
	RETVAL

void
DESTROY(context)
	SHA	context
    CODE:
	{
	    safefree((char *) context);
	}

void
reset(context)
	SHA	context
    CODE:
	{
	    sha_init(context);
	}

void
add(context, ...)
	SHA	context
    CODE:
	{
	    SV *svdata;
	    STRLEN len;
	    unsigned char *data;
	    int i;

	    for (i = 1; i < items; i++) {
		data = (unsigned char *) (SvPV(ST(i), len));
		sha_update(context, data, len);
	    }
	}

SV *
digest(context)
	SHA	context
    CODE:
	{
	    unsigned char d_str[20];
	    sha_final(d_str, context);
	    ST(0) = sv_2mortal(newSVpv(d_str, 20));
	}

char *
sha_version()
    CODE:
	{
#if (SHA_VERSION == 1)
	    RETVAL = "SHA-1";
#else
	    RETVAL = "SHA";
#endif
	}
    OUTPUT:
	RETVAL
