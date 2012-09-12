Return-Path: a.bonomi@endian.com
Subject: Re: [PATCH 0/2] agetty: display network address in issue
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=windows-1252
From: Andrea Bonomi <a.bonomi@endian.com>
In-Reply-To: <20120912093728.GA17256@x2.net.home>
Date: Wed, 12 Sep 2012 19:29:19 +0200
Cc: util-linux@vger.kernel.org
Message-Id: <49CAD42E-995E-4C66-A9AD-5939968A54F7@endian.com>
References: <2B6CF89C-6218-4289-B116-27108562664F@endian.com> <BBDB2F27-F199-4F90-B393-569763011661@endian.com> <20120912093728.GA17256@x2.net.home>
To: Karel Zak <kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Hi,
good idea, much better without the hardcoded interface name.
I think that the --interface option is useful for the machine with a =
dynamic IP address.
(in my experience, the getaddrinfo based on the hostname returns the =
loopback address)

Another idea will be to add the interface name after the \4 or \6, =
something like:
\4eth0 (or similar=85)
to get the IPv4 address of the interface eth0
So the user can specify the interface name directly in the issue file.
What do you think?

Andrea

:: e n d i a n
:: security with passion

:: andrea bonomi
:: senior software engineer
:: http://www.endian.com  :: a.bonomi@endian.com

On 12/set/2012, at 11:37, Karel Zak wrote:

>=20
> Hi,
>=20
> On Wed, Aug 15, 2012 at 11:08:16AM +0200, Andrea Bonomi wrote:
>> Hello, I developed a small patch for displaying the network address
>> (IPv4 or IPv6) of a selected network interface in the agetty issue
>> file.  The name of network interface (default eth0) can be
>> configured through a command line option.  I use this feature on my
>> virtual machines, so I can know the addresses without login. I hope
>> this can be useful for someone else.  Have a nice day, Andrea Bonomi
>=20
> I did some changes to the patch -- see below. I don't like the
> hardcoded interface names and I guess that on many machines is more
> important just machine IP (based on hostname) rather than interface
> IP. So:
>=20
> \4 and \6 print IP address as returned by getaddrinfo() *or* if
> --interface command line option is specified then interface IP is
> printed.
>=20
> It means that --interface is optional and probably unnecessary in many
> cases.
>=20
> Objections?
>=20
>    Karel
>=20
> =46rom ca2fda5f40440f4f7686716d76f93c302f1b2e67 Mon Sep 17 00:00:00 =
2001
> From: Andrea Bonomi <a.bonomi@endian.com>
> Date: Wed, 15 Aug 2012 11:10:19 +0200
> Subject: [PATCH] agetty: display network address in issue
>=20
> Signed-off-by: Andrea Bonomi <a.bonomi@endian.com>
> Signed-off-by: Karel Zak <kzak@redhat.com>
> ---
> term-utils/agetty.8 |   18 +++++++++-
> term-utils/agetty.c |   96 =
+++++++++++++++++++++++++++++++++++++++++++++++++-
> 2 files changed, 111 insertions(+), 3 deletions(-)
>=20
> diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
> index ebfdb96..bbf65d0 100644
> --- a/term-utils/agetty.8
> +++ b/term-utils/agetty.8
> @@ -3,7 +3,7 @@
> agetty \- alternative Linux getty
>=20
> .SH SYNOPSIS
> -.BR "agetty " [\-8chiLmnsUw]
> +.BR "agetty " [\-8chiLmnsUwx]
> .RI "[\-a " user ]
> .RI "[\-f " issue_file ]
> .RI "[\-H " login_host ]
> @@ -198,6 +198,10 @@ Wait for the user or the modem to send a =
carriage-return or a
> linefeed character before sending the \fI/etc/issue\fP (or other) file
> and the login prompt. Very useful in connection with the \-I option.
> .TP
> +\-x, \-\-interface \fIinterface_name\fP
> +The IPv4 and IPv6 addresses of a network interface can be displayed =
in
> +the issue. The name of the network is configured by this option.
> +.TP
> \-\-noclear
> Do not clear the screen before prompting for the login name
> (the screen is normally cleared).
> @@ -269,6 +273,18 @@ time etc. All escape codes consist of a backslash =
(\\) immediately
> followed by one of the letters explained below.
>=20
> .TP
> +4
> +Insert the IPv4 address of the machine hostname or IPv4 address the =
configured
> +network interface if the \fB\-\-interface\fP command line option is =
specified.
> +.TP
> +6
> +Insert the IPv6 address of the machine hostname or IPv6 address the =
configured
> +network interface if the \fB\-\-interface\fP command line option is =
specified.
> +.TP
> +x
> +Name of the configured network interface (configured by the =
\fB\-\-interface\fP
> +command line option).
> +.TP
> b
> Insert the baudrate of the current line.
> .TP
> diff --git a/term-utils/agetty.c b/term-utils/agetty.c
> index 43243f9..71c7da3 100644
> --- a/term-utils/agetty.c
> +++ b/term-utils/agetty.c
> @@ -31,6 +31,9 @@
> #include <netdb.h>
> #include <langinfo.h>
> #include <grp.h>
> +#include <arpa/inet.h>
> +#include <netdb.h>
> +#include <ifaddrs.h>
>=20
> #include "strutils.h"
> #include "all-io.h"
> @@ -145,6 +148,7 @@ struct options {
> 	int nice;			/* Run login with this priority =
*/
> 	int numspeed;			/* number of baud rates to try =
*/
> 	speed_t speeds[MAX_SPEED];	/* baud rates to be tried */
> +	char *interface;		/* name of the network interface =
displayed in issue */
> };
>=20
> #define	F_PARSE		(1<<0)	/* process modem status messages =
*/
> @@ -169,6 +173,7 @@ struct options {
> #define F_LONGHNAME	(1<<19) /* Show Full qualified hostname */
> #define F_NOHINTS	(1<<20) /* Don't print hints */
> #define F_REMOTE	(1<<21) /* Add '-h fakehost' to login(1) command =
line */
> +#define F_INTERFACE	(1<<22) /* Name of the network interface =
displayed in issue */
>=20
> #define serial_tty_option(opt, flag)	\
> 	(((opt)->flags & (F_VCONSOLE|(flag))) =3D=3D (flag))
> @@ -280,7 +285,7 @@ int main(int argc, char **argv)
> 		.login  =3D  _PATH_LOGIN,		/* default login =
program */
> 		.tty    =3D "tty1",		/* default tty line */
> 		.term   =3D  DEFAULT_VCTERM,	/* terminal type */
> -		.issue  =3D  ISSUE		/* default issue file */
> +		.issue  =3D  ISSUE,		/* default issue file */
> 	};
> 	char *login_argv[LOGIN_ARGV_MAX + 1];
> 	int login_argc =3D 0;
> @@ -569,6 +574,7 @@ static void parse_args(int argc, char **argv, =
struct options *op)
> 		{  "timeout",	     required_argument,  0,  't'  },
> 		{  "detect-case",    no_argument,	 0,  'U'  },
> 		{  "wait-cr",	     no_argument,	 0,  'w'  },
> +		{  "interface",      required_argument,  0,  'x'  },
> 		{  "nohints",        no_argument,        0,  =
NOHINTS_OPTION },
> 		{  "nohostname",     no_argument,	 0,  =
NOHOSTNAME_OPTION },
> 		{  "long-hostname",  no_argument,	 0,  =
LONGHOSTNAME_OPTION },
> @@ -578,7 +584,7 @@ static void parse_args(int argc, char **argv, =
struct options *op)
> 	};
>=20
> 	while ((c =3D getopt_long(argc, argv,
> -			   "8a:cC:d:Ef:hH:iI:Jl:LmnNo:pP:r:Rst:Uw", =
longopts,
> +			   "8a:cC:d:Ef:hH:iI:Jl:LmnNo:pP:r:Rst:Uwx:", =
longopts,
> 			    NULL)) !=3D -1) {
> 		switch (c) {
> 		case '8':
> @@ -659,6 +665,10 @@ static void parse_args(int argc, char **argv, =
struct options *op)
> 		case 'w':
> 			op->flags |=3D F_WAITCRLF;
> 			break;
> +		case 'x':
> +			op->flags |=3D F_INTERFACE;
> +			op->interface =3D optarg;
> +			break;
> 		case NOHINTS_OPTION:
> 			op->flags |=3D F_NOHINTS;
> 			break;
> @@ -1696,6 +1706,68 @@ static void log_warn(const char *fmt, ...)
> 	va_end(ap);
> }
>=20
> +static void output_iface_ip(struct ifaddrs *addrs, const char *iface, =
sa_family_t family)
> +{
> +	if (!iface)
> +		return;
> +
> +	if (addrs->ifa_name
> +	    && strcmp(addrs->ifa_name, iface) =3D=3D 0
> +	    && addrs->ifa_addr
> +	    && addrs->ifa_addr->sa_family =3D=3D family) {
> +
> +		void *addr =3D NULL;
> +		char buff[INET6_ADDRSTRLEN + 1];
> +
> +		switch (addrs->ifa_addr->sa_family) {
> +		case AF_INET:
> +			addr =3D &((struct sockaddr_in *)	=
addrs->ifa_addr)->sin_addr;
> +			break;
> +		case AF_INET6:
> +			addr =3D &((struct sockaddr_in6 *) =
addrs->ifa_addr)->sin6_addr;
> +			break;
> +		}
> +		if (addr) {
> +			inet_ntop(addrs->ifa_addr->sa_family, addr, =
buff, sizeof(buff));
> +			printf("%s", buff);
> +		}
> +
> +	} else if (addrs->ifa_next)
> +		output_iface_ip(addrs->ifa_next, iface, family);
> +}
> +
> +static void output_ip(sa_family_t family)
> +{
> +	char host[MAXHOSTNAMELEN + 1];
> +	struct addrinfo hints, *info =3D NULL;
> +
> +	memset(&hints, 0, sizeof(hints));
> +	hints.ai_family =3D family;
> +	if (family =3D=3D AF_INET6)
> +		hints.ai_flags =3D AI_V4MAPPED;
> +
> +	if (gethostname(host, sizeof(host)) =3D=3D 0
> +	    && getaddrinfo(host, NULL, &hints, &info) =3D=3D 0
> +	    && info) {
> +
> +		void *addr =3D NULL;
> +		char buff[INET6_ADDRSTRLEN + 1];
> +
> +		switch (info->ai_family) {
> +		case AF_INET:
> +			addr =3D &((struct sockaddr_in *) =
info->ai_addr)->sin_addr;
> +			break;
> +		case AF_INET6:
> +			addr =3D &((struct sockaddr_in6 *) =
info->ai_addr)->sin6_addr;
> +			break;
> +		}
> +		inet_ntop(info->ai_family, (void *) addr, buff, =
sizeof(buff));
> +		printf("%s", buff);
> +
> +		freeaddrinfo(info);
> +	}
> +}
> +
> static void output_special_char(unsigned char c, struct options *op,
> 				struct termios *tp)
> {
> @@ -1808,6 +1880,26 @@ static void output_special_char(unsigned char =
c, struct options *op,
> 			printf((users =3D=3D 1) ? _("user") : =
_("users"));
> 		break;
> 	}
> +	case 'x':
> +		if (op->interface)			/* interface =
name */
> +			printf("%s", op->interface);
> +		break;
> +	case '4':
> +	case '6':
> +	{
> +		sa_family_t family =3D c =3D=3D '4' ? AF_INET : =
AF_INET6;
> +
> +		if (op->interface) {			/* interface IP =
*/
> +			struct ifaddrs *addrs;
> +			int status =3D getifaddrs(&addrs);
> +			if (status !=3D 0)
> +				break;
> +			output_iface_ip(addrs, op->interface, family);
> +			freeifaddrs(addrs);
> +		} else					/* host IP */
> +			output_ip(family);
> +		break;
> +	}
> 	default:
> 		putchar(c);
> 		break;
> --=20
> 1.7.7.6
>=20
