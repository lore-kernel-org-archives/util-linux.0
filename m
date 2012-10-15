Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:37792 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753035Ab2JOCMn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Oct 2012 22:12:43 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH 03/19] write: stop using MAXHOSTNAMELEN
Date: Sun, 14 Oct 2012 22:12:49 -0400
Cc: util-linux@vger.kernel.org
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi> <1350246070-10544-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-4-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5698554.zxs3q8h2du";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201210142212.50597.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart5698554.zxs3q8h2du
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 14 October 2012 16:20:54 Sami Kerola wrote:
> +	host =3D xmalloc(sizeof(char) * (sysconf(_SC_HOST_NAME_MAX) + 1));
> +	if (gethostname(host, sysconf(_SC_HOST_NAME_MAX)) < 0)

sysconf() isn't labeled pure or anything, so it'd be better imo to store th=
is=20
in a local var so you don't waste time calling it twice.
	long len =3D sysconf(...);
=2Dmike

--nextPart5698554.zxs3q8h2du
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQe3EiAAoJEEFjO5/oN/WBbOIQAKY63t4VDz4iAEnJ9RP8l9zL
jieW21x5dOclV+QJT3kwKRAdDgfYseg6NkfPUkUhrEZA8MbJX3/B7vT1DvLYcrBr
QtKoRVP0EhTfMxZHs+Cx+EJ/9Y25rqQEc8foX0Db4gHjvTxbBCZOnQEF4PetYsD+
uLZK8OpIj2D148pw4gwaBpinSbMXQRqrFCNzVlfJy5cKzHVuLf3f0seyG2O+1dk3
pz1ghVUob/WXqCOiWtYQ1tLFWRpH6USpOjwsoHUUpa1ftxb8wfi5Z5hqFZgIO4zL
CS916KNkDBlrIymqRsTPpaEVKsRcL6p/QnrfYFFZpULcke50QHtecfpOYWsnesqZ
ZiuaU3S7dRPh27D41nCO+9KLjL3nWfeEtbVG4IJX0nDHr84yaJP6ZjDu4tnCLRU3
DgN2cxn5SsG/wH8f3W03FQSJep8tNbygyxD8edI84/7eueKw+gB3SKTksw91N9+q
0/Sk6hmH62v7pXr50GYQmkohSI2FdHoOZEZCt+6dVYYcac8TndeE3WToL4QHpOm0
Z/o4m0EBYzrNkyarLzEzM4uyJqQXulBF8YpEaGf5svavt0cKeHAu4uljry89jUDv
wkCUzIuiVPCZBcmEtDZat9ltxbM9QXOEKkez6PVFoZF1vbqnpR9qoAUUliISEMhA
qVzsV51BP8Cd4pwsQEUE
=/trn
-----END PGP SIGNATURE-----

--nextPart5698554.zxs3q8h2du--
