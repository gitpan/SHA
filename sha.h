#ifndef SHA_H
#define SHA_H

/* NIST Secure Hash Algorithm */
/* heavily modified from Peter C. Gutmann's implementation */

/* This code is in the public domain */

/* Useful defines & typedefs */

typedef unsigned char BYTE;	/* an 8-bit quantity */
typedef unsigned long LONG;	/* a 32-bit quantity */

#define SHA_BLOCKSIZE		64
#define SHA_DIGESTSIZE		20

typedef struct {
    LONG digest[5];		/* message digest */
    LONG count_lo, count_hi;	/* 64-bit bit count */
    LONG data[16];		/* SHA data buffer */
    int local;			/* unprocessed amount in data */
} SHA_INFO;

void sha_init(SHA_INFO *);
void sha_update(SHA_INFO *, BYTE *, int);
void sha_final(SHA_INFO *);

#endif /* SHA_H */
