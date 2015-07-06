Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:43533 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751047AbbGFOHN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 6 Jul 2015 10:07:13 -0400
Date: Mon, 6 Jul 2015 10:07:11 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Stef Walter <stefw@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: Reprompt once the network addresses change if
 address displayed
Message-ID: <20150706140711.GF17734@vapier>
References: <1435928288-25644-1-git-send-email-stefw@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JMKEfAmnQy+WzDHS"
In-Reply-To: <1435928288-25644-1-git-send-email-stefw@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--JMKEfAmnQy+WzDHS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03 Jul 2015 14:58, Stef Walter wrote:
  #ifdef AGETTY_RELOAD
>  # include <sys/inotify.h>
> +# include <linux/netlink.h>
> +# include <linux/rtnetlink.h>

why not use libmnl instead ?
	http://netfilter.org/projects/libmnl

> +static void open_netlink(void)
> +{
> ...
> +		if (bind(sock,(struct sockaddr *)&addr, sizeof(addr)) < 0)

need space after the first ,

> +			close (sock);

no space before the (

> +static int process_netlink_msg(int *changed)
> +{
> +	char buf[4096];
> +	struct sockaddr_nl snl;
> +	struct iovec iov =3D { buf, sizeof buf };
> +	struct msghdr msg =3D { (void*)&snl, sizeof (snl), &iov, 1, NULL, 0, 0 =
};

would be nice to use nmed initializers imo.  makes it easier to read, more=
=20
portable, and less error prone.

	struct iovec iov =3D {
		.iov_base =3D ...,
		.iov_len =3D ...,
	};

also your use of parens w/sizeof is inconsistent.  should use them, and not=
 put=20
a space between them.

> +		close (netlink_fd);

no space before the (

> +			close (netlink_fd);

same here

> +	for (;;) {

while (1) is more common i think

> +		} else if (inotify_fd >=3D 0 && FD_ISSET (inotify_fd, &rfds)) {

no space before the (
-mike

--JMKEfAmnQy+WzDHS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVmouPAAoJEEFjO5/oN/WB2F4P/3vRaUM2NV6rBIqNiPpXi1kH
gAAgZ/O+7mBqOHfehmuWVm53lNFy/i3gKWrHAZ7Q+6cYi68BhD6fc8inhHnM/gHl
F7Lte1BA2zJcc+aSHd1KjYr6LWvcCzMkSaYI0wD28VSBDKgq1TLfuPTvInxLgTw3
6m6VfN8AOAMDpOo5alKuylA/PQXENuv2pqsbGe8b5LibgZPPNQh9Z0xTi+265IbU
hmxUg4uykPAhdlWAoWE2VFDlB+q9IR4SnKuDmOskGlE4ax7yOZuGuij6dkOj0UgB
tUxbH03r64mR+EdjnGb/3O/fHDQVNPL5tebIbkgBjFOv+q9jz7QfWPijF04OU8DH
1MM+IV3rwo1t6NQVg5v1b83qFHLC+oa/jM2TEQnJQzgNiPIUhPCXC/qgg+1sHsnm
kOS4MjuH5lns93tHE1Jx7yxcBZaxH89xOjvrmUt1HbFg69nkkaDbiKLp9h+YreRi
8e5Nbv45JiEinpv85HuxzJpKmm9LbQUdeR3vs+Djx/x2/3/B7rKHD1apkx6dk+78
7ZAp6bAKGfPJihUU9rEyDkor462Y8sRhadKpEI1PNXxPUmzddML4BuqxV4NjClcW
v2OmOK5+tZp6DjU9biZysN9/F7kU1iDe87et/ChHZq7UX6LLZizcLjcEInJwA5Ya
DWJjwfJoqHFyBsjNQ16U
=EIOg
-----END PGP SIGNATURE-----

--JMKEfAmnQy+WzDHS--
