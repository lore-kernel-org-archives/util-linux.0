Return-Path: werner@suse.de
Date: Tue, 17 May 2016 10:43:47 +0200
From: "Dr. Werner Fink" <werner@suse.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Use the plymouth local protocol instead the plymouth
 binary
Message-ID: <20160517084347.dkwcby6f7nyfkkq5@boole.suse.de>
References: <1461324096-29280-1-git-send-email-werner@suse.de>
 <20160505094245.6frwtvaxoueyrfw7@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iqghrbcw6oiwczi4"
In-Reply-To: <20160505094245.6frwtvaxoueyrfw7@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


--iqghrbcw6oiwczi4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 05, 2016 at 11:42:45AM +0200, Karel Zak wrote:
> On Fri, Apr 22, 2016 at 01:21:36PM +0200, Werner Fink wrote:
> > +static int open_un_socket_and_connect(void)
> > +{
> > +	struct sockaddr_un su =3D {		/* The abstract UNIX socket of plymouth =
*/
> > +		.sun_family =3D AF_UNIX,
> > +		.sun_path =3D PLYMOUTH_SOCKET_PATH,
> > +	};
> > +	const int one =3D 1;
> > +	int fd, ret;
> > +
> > +	fd =3D socket(PF_UNIX, SOCK_STREAM|SOCK_CLOEXEC|SOCK_NONBLOCK, 0);
> > +	if (fd < 0) {
> > +		warnx(_("can not open UNIX socket"));
> > +		goto err;
> > +	}
> > +
> > +	ret =3D setsockopt(fd, SOL_SOCKET, SO_PASSCRED, &one, (socklen_t)size=
of(one));
> > +	if (ret < 0) {
> > +		warnx(_("can not set option for UNIX socket"));
> > +		close(fd);
> > +		fd =3D -1;
> > +		goto err;
> > +	}
> > +
> > +	ret =3D connect(fd, &su, offsetof(struct sockaddr_un, sun_path) + 1 +=
 strlen(su.sun_path+1));
>                                                                   ^^^^^^^=
^^^^^^^^^^^^^^^^^^
> > +	if (ret < 0) {
>=20
> This is strange code, connect() returns -1 on error, I have doubts you
> will ever see ret < 0 and why connect() return value is not enough,
> why we need 1 + strlen(su.sun_path+1))?

AFAIK and AFAICS the plymouth socket has a leading NULL byte.  That is that=
 PLYMOUTH_SOCKET_PATH
is defined as "\0/org/freedesktop/plymouthd".  If I would not add both +1 t=
he NULL byte would
destroy first the result of strlen() as well the NULL byte would not be cou=
nted as well.

>=20
> > +		if (errno !=3D ECONNREFUSED)
> > +			warnx(_("can not connect on UNIX socket"));
> > +		close(fd);
> > +		fd =3D -1;
> > +		goto err;
> > +	}
> > +err:
> > +	return fd;
> > +}
> > +
> > +int plymouth_command(int cmd, ...)
> > +{
> > +	char answer[2], command[2];
> > +	struct sigaction sp, op;
> > +	int fdsock =3D -1, ret =3D 0;
> > +
> > +	sigemptyset (&sp.sa_mask);
> > +	sp.sa_handler =3D SIG_IGN;
> > +	sp.sa_flags =3D SA_RESTART;
> > +	sigaction(SIGPIPE, &sp, &op);
> > +
> > +	command[1] =3D '\0';
> > +	switch (cmd) {
> > +	case MAGIC_PING:
> > +		fdsock =3D open_un_socket_and_connect();
> > +		if (fdsock >=3D 0) {
> > +			command[0] =3D cmd;
>=20
> maybe define cmd as char or uint8_t

Yep, but does not hurt I guess.

>=20
> > +			write_all(fdsock, command, strlen(command)+1);
>=20
> why we need strlen(command)+1 everywhere if the commend is just one
> char+\0, sizeof(command) would be enough.

It is plymouthd which does require the lasting NULL byte here as the
command read by plymouthd has always the size of uint8_t header[2]
compare with ply_boot_connection_read_request() in src/ply-boot-server.c

>=20
> > +		}
> > +		break;
> > +	case MAGIC_QUIT:
> > +		fdsock =3D open_un_socket_and_connect();
> > +		if (fdsock >=3D 0) {
> > +			command[0] =3D cmd;
> > +			write_all(fdsock, command, strlen(command)+1);
> > +		}
> > +		break;
> > +	default:
> > +		warnx(_("the plymouth request %c is not implemented"), cmd);
> > +	case '?':
> > +		goto err;
> > +	}
> > +
> > +	answer[0] =3D '\0';
> > +	if (fdsock >=3D 0) {
> > +		if (can_read(fdsock, 1000))
> > +			read_all(fdsock, &answer[0], sizeof(answer));
> > +		close(fdsock);
> > +	}
> > +	sigaction(SIGPIPE, &op, NULL);
> > +	ret =3D (answer[0] =3D=3D ANSWER_ACK) ? 1 : 0;
> > +err:
> > +	return ret;
> > +}
>=20
> ...
>=20
> >  /*
> >   * Fix the tty modes and set reasonable defaults.
> >   */
> > @@ -138,8 +103,9 @@ static void tcinit(struct console *con)
> >  	struct termios lock;
> >  	int fd =3D con->fd;
> >  #ifdef TIOCGLCKTRMIOS
> > -	int i =3D (plymouth_command("--ping")) ? 20 : 0;
> > -
> > +	int i =3D (plymouth_command(MAGIC_PING)) ? 20 : 0;
> > +	if (i)
> > +		plymouth_command(MAGIC_QUIT);
>=20
> would be possible to #define PLYMOUTH_TERMIOS_FLAGS_DELAY,
> now we have 20s in sulogins and 30s in agetty. Why?

Ahh ... indeed this is a good point :)

Werner

--=20
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr

--iqghrbcw6oiwczi4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJXOtnDAAoJEFDpDVUdwWsurUIQAKKtRlECmqbM9LQhfdbmyMBn
wit6pJMiLGgOoRniBpPan5+LPoB9Bbcrn9fPQBeg/W8I0gpHJl8RYwRW+vFLc3gC
7hM4rSb7q4TtWHyPtsCECqcNoUgY3EP38aZJuQdKXD0bRY/vk+Cj1Ghp3WUA8OzS
sBPRcW5i6oCyaoMyzQzvhEDG9Kbl84UJ7TCL/NIMSkYGZrOKuIWact8gxq3HhA8v
n3GzYevLoSHquZ0Ya9mZm1dPfb8vtqxcE/0UOkdqEtZtlAVpWp0azfMnJNez5/5p
ybblgYRf3rfRP6wLUwdyJ6sn/Icnwnbh0W7EDkmYKLMXX767msniHOECNxib/kg1
coj3c46f2s74HOmSi+DBL2SqoOvCvROh6GuIkC4iPnP2GN8Se+fyd7qqazIapUVw
novaeZvnD6lxz9vdP4Ox4/muwWZyEXeAJw8BGddJxXTREmwH0Lv/7jQYwz3Y40c3
weTrcSDXWodwyYiC8whGzKXcWpefB391Qyc0xN4rIzAOnwL0qIvRsYBSlsWA3Gmp
BkDBO7XpDLD79iB76Y/LgdZZSEGkEdW9lUePpSSrqMbC+lqCE/llR8cnqQHlAmD7
+F4fE3kOgYLlgRWduRH/jwPOCqgJWCpJZn/Uxi9lbv2KOH9uwzbtOViXX8Z3rwzl
dONHj0a+DwYVqA08gLmT
=Bwdz
-----END PGP SIGNATURE-----

--iqghrbcw6oiwczi4--
