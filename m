Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:49005 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752636AbaA3QNg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 30 Jan 2014 11:13:36 -0500
Message-ID: <52EA7A2D.3000506@archlinux.org>
Date: Thu, 30 Jan 2014 17:13:33 +0100
From: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
MIME-Version: 1.0
To: Phillip Susi <psusi@ubuntu.com>,
        =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>,
        Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: pivot_root depreciated?
References: <52E91888.4080601@ubuntu.com> <20140130081651.GE22884@x2.net.home> <52EA5E6F.6040203@ubuntu.com> <52EA66CC.9070107@archlinux.org> <52EA6DBA.6000903@ubuntu.com>
In-Reply-To: <52EA6DBA.6000903@ubuntu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="t27fF46oEiNwba4n7hn5W3gWX6c0NQinr"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t27fF46oEiNwba4n7hn5W3gWX6c0NQinr
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 30.01.2014 16:20, schrieb Phillip Susi:
> On 1/30/2014 9:50 AM, Thomas B=E4chler wrote:
>> At least mkinitcpio now generates a fresh "initrd" to return to
>> during system shutdown instead of keeping around the actual
>> initrd.
>=20
> I see, so at shutdown the initramfs is re-loaded into a tmpfs that is
> then pivot_root()ed to?

Yes. This is the only choice, since you cannot access rootfs anymore, as
that would require running unmounting /.

And in our case, it's not "the initramfs" that is put into tmpfs - we
merely install systemd-shutdown as /shutdown and all needed shared
libraries. We use the initramfs generator for convenience, since it
knows how to resolve library dependencies.

> And at boot time, pivot_root is not used?

Correct.

>> 4) chdir("/realroot"); mount --move /realroot ., chroot(".");
>=20
> Wait, how do you move a mount into itself?  I thought this was just
> the chdir and chroot.

Hm, there's something wrong here. It should be:

chdir("/realroot");
mount(".", "/", NULL, MS_MOVE, NULL);
chroot(".");

The comment included in the busybox source file which I linked to
explains it all properly.


--t27fF46oEiNwba4n7hn5W3gWX6c0NQinr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJS6notAAoJEChPw0yOSxoltMgQAK8bIwp6B26nCAOe29G/Pbp4
TJ5w78K2COTU69bFXSw5q6GgClvUxLo3T9ziGljXsxwdBJPkc8Mqvv5WdzBFu0Yi
Hio+g6CSReU71uuwNF+W8/kjXcnFoXlMShIF5amkbXL8k45vMrGgFkofgh+ZLZtF
fJQkwwQPa2Wj+XHLlrMAmE64BlKu+h2NieQ1G/w+4URdjp0qD7AvNeV7UKNzCAUh
cdQwhiL9cg1g6CttYv/5OVCDOUxskGTMqdYiVFtMyhrDH2uuWp9kW1fTT+/+8HNd
n89hUWzjNeXN5TxjaR8nrWjpYqJKMqD1goZNWUz+XtqjcRvc9AyP3T0Dn3jvwglW
p9Eote2Gix2YGUy5axhL9NvfBvjUuY3o8bK+kI+uaHA0ykopFQX2IpXbL97KBbAl
o34jNxppxArOVsW3SV2UEQyXdFHNp2QnZL2XArKfqLMooyazhB1UluKuN9zD4WGr
3xChrRJEJPmmTEYEbXV/foc1K052pqc4AKVdFsDpNp4pxeKlaEHc67BadjJUHq5v
tb4MTDnAhk6L+gPApUcar5d+N+cgLe162FHOovnwikwB4jevRT9ZEdhrWdT+WimI
4UMZDoIMS04AzLqimKqNqaLwHc1a/z0YjipOAeXpVkmJmkEbEmCZAD9KC4UmTXuF
lz4shRfhU3PkoHv+yhPj
=aQJp
-----END PGP SIGNATURE-----

--t27fF46oEiNwba4n7hn5W3gWX6c0NQinr--
