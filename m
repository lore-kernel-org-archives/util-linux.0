Return-Path: util-linux-owner@vger.kernel.org
Received: from thejh.net ([37.221.195.125]:46937 "EHLO thejh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbbC3L2s (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 30 Mar 2015 07:28:48 -0400
Date: Mon, 30 Mar 2015 13:21:29 +0200
From: Jann Horn <jann@thejh.net>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux: wall security issue: unprivileged users can suppress
 banner
Message-ID: <20150330112129.GA24751@pc.thejh.net>
References: <20150327182707.GA9561@pc.thejh.net>
 <20150330094447.GR1749@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
In-Reply-To: <20150330094447.GR1749@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2015 at 11:44:47AM +0200, Karel Zak wrote:
> On Fri, Mar 27, 2015 at 07:27:07PM +0100, Jann Horn wrote:
> > I found a (tiny) security issue in wall that an unprivileged user can u=
se
> > to suppress the banner and send arbitrary bytes (and thereby mess up ot=
her
> > people's terminals with colors and stuff). Do you want to treat this as=
 a
> > security issue and keep it private until a fix is released or should I
> > resend this message to util-linux@vger.kernel.org?
>=20
> I think we can discus it publicly, it does not seem like fatal
> security issue, from my point of view it seems like security
> disadvantage :-)=20

Heh, ok.


> Note that I'm not sure how often is wall installed with setgid, for
> example on Fedora only superuser can write to another terminals.

E.g. on Debian, it is.


> > wall normally runs setgid, but not setuid. This means that any file
> > created by wall is accessible for the user running wall. wall writes the
> > banner and filtered input from the user to a temporary file, then writes
> > data from the temporary file to everyone's terminals without further
> > filtering. This means that the user can bypass the filtering by writing
> > to the temporary file directly.
> [...]
>=20
> > From 96d238cad0151a4cd271ab38d1f47a82c58dc313 Mon Sep 17 00:00:00 2001
> > From: Jann Horn <jann@thejh.net>
> > Date: Fri, 27 Mar 2015 19:13:09 +0100
> > Subject: [PATCH] fix wall: Do not use a temporary file.
> >=20
> > The issue with using a temporary file in wall is that wall runs as setg=
id.
> > This means that an unprivileged user who runs wall can modify wall's
> > temporary files, even if those are mode 0600, so the unprivileged user =
can
> > edit and effectively suppress the banner.
> > The fix is to simply not use temporary files.
> > ---
> >  term-utils/wall.c | 80 ++++++++++++++++++++++++++++++++---------------=
--------
> >  1 file changed, 47 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/term-utils/wall.c b/term-utils/wall.c
> > index 387594c..666b4b0 100644
> > --- a/term-utils/wall.c
> > +++ b/term-utils/wall.c
> > @@ -181,14 +181,42 @@ int main(int argc, char **argv)
> >  	exit(EXIT_SUCCESS);
> >  }
> > =20
> > +static void buf_append(char *data, char **buf, size_t *size, size_t *u=
sed)
> > +{
> > +	size_t data_len =3D strlen(data);
> > +	while (data_len > *size - *used) {
> > +		*size =3D 2 * *size;
>=20
>  How do you know that "2 * size" is enough for data_len?

I don't. It probably usually is, but if it's not, the while loop is going
to increase the size again and again until it fits.


>=20
> > +		*buf =3D xrealloc(*buf, *size + 1);
> > +	}
> > +	strcpy(*buf + *used, data);
> > +	*used +=3D data_len;
> > +}
> > +
> > +static void buf_append_careful(int c, char **buf, size_t *size, size_t=
 *used)
> > +{
> > +	char cbuf[10];
> > +
> > +	if (isprint(c) || c =3D=3D '\a' || c =3D=3D '\t' || c =3D=3D '\r' || =
c =3D=3D '\n')
> > +		sprintf(cbuf, "%c", c);
> > +	else if (!isascii(c))
> > +		sprintf(cbuf, "\\%3o", (unsigned char)c);
> > +	else {
> > +		cbuf[0] =3D '^';
> > +		cbuf[1] =3D c ^ 0x40;
> > +		cbuf[2] =3D '\0';
> > +	}
> > +	buf_append(cbuf, buf, size, used);
> > +}
> > +
> >  static char *makemsg(char *fname, char **mvec, int mvecsz,
> >  		     size_t *mbufsize, int print_banner)
> >  {
> >  	register int ch, cnt;
> > -	struct stat sbuf;
> > -	FILE *fp;
> > -	char *p, *lbuf, *tmpname, *mbuf;
> > +	char *p, *lbuf;
> >  	long line_max;
> > +	char headerbuf[TERM_WIDTH + 20];
>=20
> btw, we have get_terminal_width() in "ttyutils.h"

The existing code also used TERM_WIDTH. Also, won't get_terminal_width()
look up the size of one specific terminal, which won't work for wall?


> > +	size_t buf_used =3D 0, buf_size =3D 1024;
> > +	char *buf =3D xmalloc(buf_size + 1);
> > =20
> >  	line_max =3D sysconf(_SC_LINE_MAX);
> >  	if (line_max <=3D 0)
> > @@ -196,11 +224,6 @@ static char *makemsg(char *fname, char **mvec, int=
 mvecsz,
> > =20
> >  	lbuf =3D xmalloc(line_max);
> > =20
> > -	if ((fp =3D xfmkstemp(&tmpname, NULL)) =3D=3D NULL)
> > -		err(EXIT_FAILURE, _("can't open temporary file"));
>=20
> if you replace xfmkstemp() with open_memstream() than you don't need
> all the buf_append() changes. libc is able to use FILE as in memory
> buffer for fprintf-like function :-)

Which libcs? The manpage for open_memstream() says something about "not
widely available on other systems". Is that acceptable? The wall code
even avoids the use of snprintf because it "is not always available".


> > -	unlink(tmpname);
> > -	free(tmpname);
> > -
> >  	if (print_banner =3D=3D TRUE) {
> >  		char *hostname =3D xgethostname();
> >  		char *whom, *where, *date;
> > @@ -233,14 +256,17 @@ static char *makemsg(char *fname, char **mvec, in=
t mvecsz,
> >  		 */
> >  		/* snprintf is not always available, but the sprintf's here
> >  		   will not overflow as long as %d takes at most 100 chars */
> > -		fprintf(fp, "\r%*s\r\n", TERM_WIDTH, " ");
> > +		sprintf(headerbuf, "\r%*s\r\n", TERM_WIDTH, " ");
> > +		buf_append(headerbuf, &buf, &buf_size, &buf_used);
> >  		sprintf(lbuf, _("Broadcast message from %s@%s (%s) (%s):"),
> >  			      whom, hostname, where, date);
> > -		fprintf(fp, "%-*.*s\007\007\r\n", TERM_WIDTH, TERM_WIDTH, lbuf);
> > +		sprintf(headerbuf, "%-*.*s\007\007\r\n", TERM_WIDTH, TERM_WIDTH, lbu=
f);
>=20
> it would be probably better to use=20
>=20
>         snprintf(headerbuf, sizeof(headerbuf), ....)
>=20
> or use the real terminal width than sizeof().

Again, at this point, the message is formatted for all terminals at
once, so I'm not sure what "the real terminal width" would be there.


> > +		buf_append(headerbuf, &buf, &buf_size, &buf_used);
> >  		free(hostname);
> >  		free(date);
> >  	}
> > -	fprintf(fp, "%*s\r\n", TERM_WIDTH, " ");
> > +	sprintf(headerbuf, "%*s\r\n", TERM_WIDTH, " ");
> > +	buf_append(headerbuf, &buf, &buf_size, &buf_used);
> > =20
> >  	 if (mvec) {
> >  		/*
> > @@ -249,12 +275,11 @@ static char *makemsg(char *fname, char **mvec, in=
t mvecsz,
> >  		int i;
> > =20
> >  		for (i =3D 0; i < mvecsz; i++) {
> > -			fputs(mvec[i], fp);
> > +			buf_append(mvec[i], &buf, &buf_size, &buf_used);
> >  			if (i < mvecsz - 1)
> > -				fputc(' ', fp);
> > +				buf_append(" ", &buf, &buf_size, &buf_used);
> >  		}
> > -		fputc('\r', fp);
> > -		fputc('\n', fp);
> > +		buf_append("\r\n", &buf, &buf_size, &buf_used);
> > =20
> >  	} else {
> >  		/*
> > @@ -284,33 +309,22 @@ static char *makemsg(char *fname, char **mvec, in=
t mvecsz,
> >  			for (cnt =3D 0, p =3D lbuf; (ch =3D *p) !=3D '\0'; ++p, ++cnt) {
> >  				if (cnt =3D=3D TERM_WIDTH || ch =3D=3D '\n') {
> >  					for (; cnt < TERM_WIDTH; ++cnt)
> > -						putc(' ', fp);
> > -					putc('\r', fp);
> > -					putc('\n', fp);
> > +						buf_append(" ", &buf, &buf_size, &buf_used);
> > +					buf_append("\r\n", &buf, &buf_size, &buf_used);
> >  					cnt =3D 0;
> >  				}
> >  				if (ch =3D=3D '\t')
> >  					cnt +=3D (7 - (cnt % 8));
> >  				if (ch !=3D '\n')
> > -					fputc_careful(ch, fp, '^');
> > +					buf_append_careful(ch, &buf, &buf_size, &buf_used);
> >  			}
> >  		}
> >  	}
> > -	fprintf(fp, "%*s\r\n", TERM_WIDTH, " ");
> > +	sprintf(headerbuf, "%*s\r\n", TERM_WIDTH, " ");
> > +	buf_append(headerbuf, &buf, &buf_size, &buf_used);
> > =20
> >  	free(lbuf);
> > -	rewind(fp);
> > -
> > -	if (fstat(fileno(fp), &sbuf))
> > -		err(EXIT_FAILURE, _("stat failed"));
> > -
> > -	*mbufsize =3D (size_t) sbuf.st_size;
> > -	mbuf =3D xmalloc(*mbufsize);
> > -
> > -	if (fread(mbuf, 1, *mbufsize, fp) !=3D *mbufsize)
> > -		err(EXIT_FAILURE, _("fread failed"));
> > =20
> > -	if (close_stream(fp) !=3D 0)
> > -		errx(EXIT_FAILURE, _("write error"));
> > -	return mbuf;
> > +	*mbufsize =3D buf_used;
> > +	return buf;
> >  }

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVGTG5AAoJED4KNFJOeCOooi4QAKZaGqarE08OMY7+0c3856m4
FxcXEye/ULaT9IvhspH0SfVDQ+fIAd9pGe8p+yIu3aKdc3CJYqvvRKsUW1dxgLYR
O+KG+Uzv2zoom32P1giJCe23efdVUYXo6v69OHHXbqdGU60e6wGHudH8W6iYr6L7
feSXN3dL8vJvq+WY1cGt3yoCtqdpEw/W64ej5w8oV2ezqIFfgJYhjkY2tFnAFNX2
afsAykbvfnlFu2MHvqJkZFuxin3EvJSespcn5kCEFyELp0ZQT7ki2m45+cABWN9K
sWSFbzfKpJHDyOlGzXSjDUaBfpN+bkywrs2Y+sXcexq2Qpv5R3MTxvjp9tZTfQt1
PqO+j9y/v+DyX7dMP2lY6cnvY/erel/UVUjCMDtCEP7A4t7pgPfw6m0BbvDEk+S1
gBVL/jdktui6PuF4wUhZ6yW6W5t2NAhUcb8HNzjwcvP2QImp8vCp8ov6NN+Km6aU
y4TxvHFPpx3ij1+wFXhvL1/lRBJgfh1IFgBT+x+IW5dLoJcBEnn9hvgNIRLtY0wa
Udlgm9HHijmtFG/Z6bMmSCogYEmH9gXrf8Zgx1RVZBjOWNykpxhkRKyIKuR55ySo
iC/qxO4vYnrk9EpLbLdxJAEG3MmhftEo53ozcRet6og/wuioEjnixk5Ioxt5cZO3
qemw6zdxaL4yVWhNEKZA
=FovI
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
