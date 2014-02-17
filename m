Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:52010 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbaBQIj0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Feb 2014 03:39:26 -0500
Received: from vapier.localnet (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id C4A3533F582
	for <util-linux@vger.kernel.org>; Mon, 17 Feb 2014 08:39:25 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: last/last test fails
Date: Mon, 17 Feb 2014 03:39:25 -0500
Message-ID: <1496112.KWppGQQCcY@vapier>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart40986695.LcNeSyDqqS"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nextPart40986695.LcNeSyDqqS
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

current git (24b2a479fd5ba138e9b836fa2115939eb3b59dfe) fails this test =
for me.
see recent blkid test post for config.log.
$ ./configure
$ make
$ ./tests/run.sh --nonroot --verbose last
...

     script: /usr/local/src/util-linux/tests/ts/last/last
    sub dir: /usr/local/src/util-linux/tests/ts/last
    top dir: /usr/local/src/util-linux/tests
       self: /usr/local/src/util-linux/tests/ts/last
  test name: last
  test desc: last
  component: last
  namespace: last/last
    verbose: yes
     output: /usr/local/src/util-linux/tests/output/last/last
   valgrind: /usr/local/src/util-linux/tests/output/last/last.vgdump
   expected: /usr/local/src/util-linux/tests/expected/last/last
 mountpoint: /usr/local/src/util-linux/tests/output/last/last-mnt

         last: last                           ...~~~ basic output ~~~
~~~ include system ~~~
~~~ dns short ~~~
~~~ dns long ~~~
~~~ dns host last ~~~
~~~ show ip ~~~
~~~ no host ~~~
~~~ full times ~~~
~~~ no time ~~~
~~~ iso-8601 time ~~~
~~~ since and until ~~~
~~~ present ~~~
 FAILED (last/last)

=2D--------------------------------------------------------------------
  1 tests of 2 FAILED
=2D--------------------------------------------------------------------

=2D-- tests/expected/last/last=092014-01-17 20:16:42.575779735 +0000
+++ tests/output/last/last=092014-02-17 08:38:08.610056705 +0000
@@ -1,6 +1,6 @@
 ~~~ basic output ~~~
 rick     long         never-gonna-logo Thu Jan  1 00:00 - 03:14 (24855=
+03:14)
=2Dtorvalds linux        hobby            Mon Aug 26 00:57   still logged=
 in
+torvalds linux        hobby            Mon Aug 26 00:57    gone - no l=
ogout
 reboot   system boot  system-name      Wed Aug 28 18:00   still runnin=
g
 reboot   system boot  system-name      Wed Aug 28 16:00 - 17:00  (01:0=
0)
 IPv4     root         dns-server       Wed Aug 28 13:00 - 14:00  (01:0=
0)
@@ -17,7 +17,7 @@
 wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ include system ~~~
 rick     long         never-gonna-logo Thu Jan  1 00:00 - 03:14 (24855=
+03:14)
=2Dtorvalds linux        hobby            Mon Aug 26 00:57   still logged=
 in
+torvalds linux        hobby            Mon Aug 26 00:57    gone - no l=
ogout
 reboot   system boot  system-name      Wed Aug 28 18:00   still runnin=
g
 shutdown system down  system-name      Wed Aug 28 17:00 - 18:00  (01:0=
0)
 reboot   system boot  system-name      Wed Aug 28 16:00 - 17:00  (01:0=
0)
@@ -47,16 +47,16 @@
=20
 wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ show ip ~~~
=2Dtorvalds linux        128.214.205.14   Mon Aug 26 00:57   still logged=
 in
+torvalds linux        128.214.205.14   Mon Aug 26 00:57    gone - no l=
ogout
=20
 wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ no host ~~~
=2Dtorvalds linux        Mon Aug 26 00:57   still logged in
+torvalds linux        Mon Aug 26 00:57    gone - no logout
=20
 wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ full times ~~~
 rick     long         never-gonna-logo Thu Jan  1 00:00:00 1970 - Tue =
Jan 19 03:14:07 2038 (24855+03:14)
=2Dtorvalds linux        hobby            Mon Aug 26 00:57:08 1991   stil=
l logged in
+torvalds linux        hobby            Mon Aug 26 00:57:08 1991   gone=
 - no logout
 reboot   system boot  system-name      Wed Aug 28 18:00:00 2013   stil=
l running
 reboot   system boot  system-name      Wed Aug 28 16:00:00 2013 - Wed =
Aug 28 17:00:00 2013  (01:00)
 IPv4     root         dns-server       Wed Aug 28 13:00:00 2013 - Wed =
Aug 28 14:00:00 2013  (01:00)
@@ -73,7 +73,7 @@
 wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ no time ~~~
 rick     long         never-gonna-logo   (24855+03:14)
=2Dtorvalds linux        hobby              logged in
+torvalds linux        hobby              - no logout
 reboot   system boot  system-name        running
 reboot   system boot  system-name         (01:00)
 IPv4     root         dns-server          (01:00)
@@ -90,7 +90,7 @@
 wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ iso-8601 time ~~~
 rick     long         never-gonna-logout 1970-01-01T00:00:00+0000 - 20=
38-01-19T03:14:07+0000 (24855+03:14)
=2Dtorvalds linux        hobby            1991-08-26T00:57:08+0000   stil=
l logged in
+torvalds linux        hobby            1991-08-26T00:57:08+0000   gone=
 - no logout
 reboot   system boot  system-name      2013-08-28T18:00:00+0000   stil=
l running
 reboot   system boot  system-name      2013-08-28T16:00:00+0000 - 2013=
=2D08-28T17:00:00+0000  (01:00)
 IPv4     root         dns-server       2013-08-28T13:00:00+0000 - 2013=
=2D08-28T14:00:00+0000  (01:00)
@@ -115,7 +115,7 @@
 wtmp begins Wed Aug 28 03:00:00 2013
 ~~~ present ~~~
 rick     long         never-gonna-logo Thu Jan  1 00:00 - 03:14 (24855=
+03:14)
=2Dtorvalds linux        hobby            Mon Aug 26 00:57   still logged=
 in
+torvalds linux        hobby            Mon Aug 26 00:57    gone - no l=
ogout
 runlevel foo          one              Wed Aug 28 11:00 - 12:00  (01:0=
0)
=20
 wtmp begins Wed Aug 28 03:00:00 2013
=2Dmike
--nextPart40986695.LcNeSyDqqS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTAcq9AAoJEEFjO5/oN/WB21kP/ira/liY4SCXdxE3HQOSV6Ls
scJOPqm4xQZbVBTsS66KHjid4cCkWZqivMOydgc/L/IRGX6AhFO+IWEWhvPwqMNX
RjnrtPBN22swSBpbHC03acrg0mlVIey8EJhM5uAmWnRcHtUo8ojpbCP33QHFoHte
oteAh1qj4kSpDe/FC1g8rxZhbZG4xHY6If8kYkbfYxLBmjl7y1BXM1Xl/mbOAyNK
9qxX3HcnLytJE+BEZ/fIhuaZ2lymAeGZzYK7FnMBVYjpj3wGYwE7zjp2AVnUf7Qs
CWy8Ei3Gd14Lem7TvN3rPQq+PWxEn9R47pqGD0uLr16CN/o5wqgCsLFMiSMVsCeX
q7eFH3c30BT1NeDR+XaGcOvH2RbUi3JLpG5tRzWpG1q3izcI/F7g6KURIS+Ly3z8
aFBbtIuGWTrRiN0WhdtajiA9xeIEzZZLo3+UjblGx5qzI0YbMFBmtE9K7YJFQWwz
R+7noOhZCA9Y4AYibYs8wRq+HGxhxYvd3v3pCqBPUa+QR6pP5NEd1rnLkmJnFh1d
gQOm3FvaSAAFjo8kV/FBWpBEpg4roeCvqKQ/bY3QpNdEv87l3sgFyQT6i2csqSmE
Q+3jXWXEl2l6VP3sISVhZ719OagbcIP4B4xSl3vnAWRe+lvCKa4MTbg2UYbEtAC5
Iz3/mJc43W+HZeGtmk2L
=a4mG
-----END PGP SIGNATURE-----

--nextPart40986695.LcNeSyDqqS--

