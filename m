Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:37934 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752988Ab2JOCRa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Oct 2012 22:17:30 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH 19/19] fsck.cramfs: replace utime() with utimensat()
Date: Sun, 14 Oct 2012 22:17:36 -0400
Cc: util-linux@vger.kernel.org
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi> <1350246070-10544-20-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-20-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart9313414.v1pmnLAgKl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201210142217.37008.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart9313414.v1pmnLAgKl
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 14 October 2012 16:21:10 Sami Kerola wrote:
> +	if (utimensat(path, &epoch, 0) < 0)

err, did you test this at all ?  utimensat() takes 4 args one of which is a=
=20
reference file descriptor.
=2Dmike

--nextPart9313414.v1pmnLAgKl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQe3JAAAoJEEFjO5/oN/WBv+cP/RLfC9js0rwkr4PFQZN4PBh7
zCWw6Op4zVjK9knGTCuRTryUdvk/KiaXtNJMKkv2JEQQ6qFtbjEJnbVsgizRYe+k
+AeWZzAlaqElkYfzUeHwmTgQi2Doyih60lnefvrbn0DCqP6A2Q4NW7cvRncbTo1G
pasvawGKsq5yQJvJErwcpoaqvS0ZPUbltLNLGk3jQ2NkgXJggJxj5LhKkUehmQEd
AXyXHE+gUxww+Uc27rWKnxsApcUuXM6TWgfsWFAUeW9+JdID8i5Wl89xupVFLfKB
qgZ0kV1gqjGkgjk/HPVWy3GhJt0ajuCiDSrcoX8le8KpDxoQjW+LmcdwwQxWlIbj
qTpiZRd3K3y3dcw6Y+XMIpRA+las61VqNtuQfXXEcjzM8SQBhZSGBaSHwFfKenRS
5wz88SyyBLXfR4koI0iNkyxQ7moVZvuzhHZRx2QvmQMHKn+NIYdViGr0cFwwx9wG
vJL17/hh8kek8YPKVC5uRkR7/KYoZXYW93tSyEcCl4OzI0hd3PBm8F2bZvz/QWxx
Bm099WCD5XOg/znVLR0AAh+n4CLMR/7zboSZbDU+8Kmoc4N/cCWtt6u7g6K+DV1X
eWSJVdlyi3HFAjnveDk+I5ZIpWQ6MXAzoPh7AuPyAONXkI290qX9rut2byj7Ge8n
wV9syYpX1dc+7vvK/PYe
=Xpsr
-----END PGP SIGNATURE-----

--nextPart9313414.v1pmnLAgKl--
