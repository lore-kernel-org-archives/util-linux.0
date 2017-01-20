Return-Path: util-linux-owner@vger.kernel.org
Received: from a.free.hostzilla.ws ([67.227.165.253]:53694 "EHLO
        a.free.hostzilla.ws" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752463AbdATP4M (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 20 Jan 2017 10:56:12 -0500
Received: from a79-168-190-113.cpe.netcabo.pt ([79.168.190.113]:34712 helo=marte.localnet)
        by a.free.hostzilla.ws with esmtpsa (TLSv1:ECDHE-RSA-AES256-SHA:256)
        (Exim 4.87)
        (envelope-from <PedroMC@pmc.com.pt>)
        id 1cUaVK-0000zQ-1k
        for util-linux@vger.kernel.org; Fri, 20 Jan 2017 09:49:26 -0500
From: Pedro Miguel Carvalho <PedroMC@pmc.com.pt>
To: util-linux@vger.kernel.org
Subject: [PROBLEM] "findmnt --poll" does not flush stdout causing it to buffer the output more than it should when the output is to a pipe or file.
Date: Fri, 20 Jan 2017 14:49:18 +0000
Message-ID: <1493264.gvqBJzGE5V@marte>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4903115.UEL9ZnNKm4"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart4903115.UEL9ZnNKm4
Content-Type: multipart/mixed; boundary="nextPart1865518.7uAhIVuNxy"
Content-Transfer-Encoding: quoted-printable

This is a multi-part message in MIME format.

=2D-nextPart1865518.7uAhIVuNxy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

"findmnt --poll" does not flush stdout causing it to buffer the
output more than it should when the output is to a pipe or file.

This issue can be observed by comparing the output of:
	findmnt --poll --pairs
with the output of:
	findmnt --poll --pairs | tee /tmp/output.log
when these two command are run at the same time
and some filesystems are (un)(re)mounted.

Redirecting the output to a file:
	findmnt --poll --pairs > /tmp/output.log
or executing findmnt with ssh:
	ssh user@server findmnt --poll --pairs
also show the same symptom.

The attached patch simply adds a "fflush(stdout);" after the
output is printed.

Thanks

p.s. I'm not certain if this is the proper place and way to
report this issue. If this should go somewhere else, please
point me in the right direction.
=2D-nextPart1865518.7uAhIVuNxy
Content-Disposition: attachment; filename="findmnt.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="findmnt.patch"

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index aff2847..3984d44 100644
=2D-- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1142,6 +1142,7 @@ static int poll_table(struct libmnt_table *tb, const char *tabfile,
 
 		if (count) {
 			rc = scols_table_print_range(table, NULL, NULL);
+			fflush(stdout);
 			if (rc)
 				goto done;
 		}

=2D-nextPart1865518.7uAhIVuNxy--
This is a multi-part message in MIME format.

--nextPart1865518.7uAhIVuNxy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

"findmnt --poll" does not flush stdout causing it to buffer the
output more than it should when the output is to a pipe or file.

This issue can be observed by comparing the output of:
	findmnt --poll --pairs
with the output of:
	findmnt --poll --pairs | tee /tmp/output.log
when these two command are run at the same time
and some filesystems are (un)(re)mounted.

Redirecting the output to a file:
	findmnt --poll --pairs > /tmp/output.log
or executing findmnt with ssh:
	ssh user@server findmnt --poll --pairs
also show the same symptom.

The attached patch simply adds a "fflush(stdout);" after the
output is printed.

Thanks

p.s. I'm not certain if this is the proper place and way to
report this issue. If this should go somewhere else, please
point me in the right direction.
--nextPart1865518.7uAhIVuNxy
Content-Disposition: attachment; filename="findmnt.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="findmnt.patch"

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index aff2847..3984d44 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1142,6 +1142,7 @@ static int poll_table(struct libmnt_table *tb, const char *tabfile,
 
 		if (count) {
 			rc = scols_table_print_range(table, NULL, NULL);
+			fflush(stdout);
 			if (rc)
 				goto done;
 		}

--nextPart1865518.7uAhIVuNxy--

--nextPart4903115.UEL9ZnNKm4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJYgiNzAAoJEG7uFb8cEwCCqAkP/1+LdyBmq1GLYgqRSG2lgcwz
yBHcXRSAU0PjnYtRNz9TbmNRpNIgGTjWdJZLXNsQd9rZdFZcjYawDdB8JSaDO8vH
oArYq7g9FzHUUKSKYMb4Dk3nvqF7dMjs5I25XKBfxjTPBgMgHOdFyRBW/y/WWVEe
6ajJR7uEQPbWaoFFeLU0fJoic1b3lzOvPm45vjC3gWuume5Ugf1I2oVw9yDFNrBF
Np7Ow1Qn+1agNZGbT/C/Ko6vWEFwIppwxUBpvGeul+r3pFOa+FlgGVvFIO9fUbTY
MFh7yo4owV+nCHqAO2TJ96hl5qhVfqgudg/WEmVFpgWmm9QD6PaTD3IVXHmDKXxg
YIJmXwpxVgxcIVZLg04FobTVSEBbUwEb00uhA/kvtysCRBQTHnmRGY+uacgP/k0z
Dq+7f+y3AfWQmnMfJJOOhG1MmNCNtVF3LWOKqRs+rWcjhfgsyg7iohZpJ4BTA8rn
2r19i7e5n4MFwyg1Q6c5U6+jo68cHWnwWCLwaSfS5vxgnNWxmDEIgPY1z+pWZOb5
a+z1JCylBlQgW7IWHY219x86xXn12DniZO4Hpv3rmoAx/1ZtYk9ihPUwpBsnsdfk
Yczmi6dwJjMAfOVP98LmJs3cJpnQjYDLPQa+V/v6PoDijqXU0Q/38CuBhU6GgP9Q
sVAMTQPFCxMhtHp8mTQW
=c2+5
-----END PGP SIGNATURE-----

--nextPart4903115.UEL9ZnNKm4--

