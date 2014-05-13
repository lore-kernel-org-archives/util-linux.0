Return-Path: werner@suse.de
Date: Tue, 13 May 2014 12:42:22 +0200
From: "Dr. Werner Fink" <werner@suse.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Ruediger Meier <sweet_f_a@gmx.de>
Subject: Re: [PATCH 1/4] Avoid that agetty nor sulogin are fooled by a
 running plymouth
Message-ID: <20140513104222.GA16787@boole.suse.de>
References: <1399543765-31106-1-git-send-email-werner@suse.de>
 <20140513085658.GM8951@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
In-Reply-To: <20140513085658.GM8951@x2.net.home>
List-ID: <util-linux.vger.kernel.org>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2014 at 10:56:58AM +0200, Karel Zak wrote:
> On Thu, May 08, 2014 at 12:09:22PM +0200, Werner Fink wrote:
> > The nowadays used plymouth locks the devices used for the system
> > console which causes that agetty as well as sulogin can not modify
> > the termios settings of e.g. the serial devices of the systenm console.
>=20
>  All applied, thanks!
>=20
> > +	int fd =3D con->fd, i =3D (plymouth_command("--ping")) ? 20 : 0;
> > +
> > +	while (i-- > 0) {
> > +		/*
> > +		 * With plymouth the termios flags become changed after this
> > +		 * function had changed the termios.
> > +		 */
> > +		memset(&lock, 0, sizeof(struct termios));
> > +		if (ioctl(fd, TIOCGLCKTRMIOS, &lock) < 0)
> > +			break;
> > +		if (!lock.c_iflag && !lock.c_oflag && !lock.c_cflag && !lock.c_lflag)
> > +			break;
> > +		if (i =3D=3D 15 && plymouth_command("quit") !=3D 0)
> > +			break;
> > +		sleep(1);
> > +	}
> > +	memset(&lock, 0, sizeof(struct termios));
> > +	ioctl(fd, TIOCSLCKTRMIOS, &lock);
>=20
>  I hope 20s sleep is the worst case and in normal situations we don't
>  have to call plymouth "quit" from sulogin/agetty.

Indeed the 20 seconds are the worst case, in normal case this is not hit but
during debugging a few service units I had run into a blocking plymouth, th=
at
is that plymouth hold the terminal termios structure locked and this has
lead to that fact that no password could be specified.

In my experience plymouth has some more further side effects if on is using
a further serial console or if there is no virtual console (s390 and some
x86_64 server systems).  Maybe upstream of plymouth is not aware that in
server business a virtual console used for graphic is not that common.

Werner

--=20
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAABAgAGBQJTcfcOAAoJEFDpDVUdwWsuNHEQAJpfybH7P+h66mGveZfHSTg1
qipVLxj3SMHyPvBc/1mBLdPvRxfL0Y0vP5KrWJ7vBu7O+fgZDDRsOyvO0s74BTBM
OgtrUBM6PL0hEiZuB6Bj9cJGNC0H+pnDsOoTvxLPwkTgBxmBb+AKv4JTs8YkFoai
4qVFUo51U+TeM7Q+zBU2iyG9n1XzKeD4BEXwrB/kdYO/ZGB1CRJcMFj5SK4qnpzh
/r7xlYI/TQqfUOzgbTQqg5HsNQvgu1FqjvIJM8FTjjgf9pNEWz+Dt2R6LcsucDQI
E3iFQJPb6qre3fA5D6nN+ROnuAs4Z8X9/j2nEBx8rmo1LzNPmkTBMJMkyWZ03A/c
oPYBNyq+DfosVAgqJEV+HqVOlONxpRYNZHUjFuIkkNrIlmkeXPeRLi5M5eWz2QaA
3ThVS4jQf/XdQx9ecfqhIf5/CY6kjr/RbJcJ8s0VagfH+zqfEMt8GW0HGmau9qPf
qXVcO6lgOJUzfiCgD9VHOnv7qkqAeq8ui6kCW4dx+EF3EnCB/Zss2YQ6RqTeHZLY
F6qpNRTC0HTTHVckIPm3XJnpWjDWgbzGm0fuYavj3lq2k4wmE2sXXO7732GSWdE5
TwqO0Kg5zsyFTbtQ6oZU86mqanXIqzfSLmXoldRxcB+4Gbv+yq0uhPwvMZBqKzC5
WbG+1F1glqwxRw+ZYDck
=NTaS
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
