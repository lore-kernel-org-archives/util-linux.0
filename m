Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:39521 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab3JKQFM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 11 Oct 2013 12:05:12 -0400
Message-ID: <525821B6.9010304@ubuntu.com>
Date: Fri, 11 Oct 2013 12:05:10 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: blkid doesn't find lvm pv when boot loader installed
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When installing a boot loader into an LVM PV, blkid detects it as a
dos partition table and does not probe the lvm superblock.

Easy way to reproduce is to pvcreate a volume, then xxd -r the
following grub boot sector into it:

0000000: eb63 9000 0000 0000 0000 0000 0000 0000 .c..............
0000010: 0000 0000 0000 0000 0000 0000 0000 0000 ................
0000020: 0000 0000 0000 0000 0000 0000 0000 0000 ................
0000030: 0000 0000 0000 0000 0000 0000 0000 0000 ................
0000040: 0000 0000 0000 0000 0000 0000 0000 0000 ................
0000050: 0000 0000 0000 0000 0000 0080 7eb0 0300 ............~...
0000060: 0000 0000 fffa 9090 f6c2 8074 05f6 c270 ...........t...p
0000070: 7402 b280 ea79 7c00 0031 c08e d88e d0bc t....y|..1......
0000080: 0020 fba0 647c 3cff 7402 88c2 52be 807d . ..d|<.t...R..}
0000090: e817 01be 057c b441 bbaa 55cd 135a 5272 .....|.A..U..ZRr
00000a0: 3d81 fb55 aa75 3783 e101 7432 31c0 8944 =..U.u7...t21..D
00000b0: 0440 8844 ff89 4402 c704 1000 668b 1e5c .@.D..D.....f..\
00000c0: 7c66 895c 0866 8b1e 607c 6689 5c0c c744 |f.\.f..`|f.\..D
00000d0: 0600 70b4 42cd 1372 05bb 0070 eb76 b408 ..p.B..r...p.v..
00000e0: cd13 730d f6c2 800f 84d8 00be 8b7d e982 ..s..........}..
00000f0: 0066 0fb6 c688 64ff 4066 8944 040f b6d1 .f....d.@f.D....
0000100: c1e2 0288 e888 f440 8944 080f b6c2 c0e8 .......@.D......
0000110: 0266 8904 66a1 607c 6609 c075 4e66 a15c .f..f.`|f..uNf.\
0000120: 7c66 31d2 66f7 3488 d131 d266 f774 043b |f1.f.4..1.f.t.;
0000130: 4408 7d37 fec1 88c5 30c0 c1e8 0208 c188 D.}7....0.......
0000140: d05a 88c6 bb00 708e c331 dbb8 0102 cd13 .Z....p..1......
0000150: 721e 8cc3 601e b900 018e db31 f6bf 0080 r...`......1....
0000160: 8ec6 fcf3 a51f 61ff 265a 7cbe 867d eb03 ......a.&Z|..}..
0000170: be95 7de8 3400 be9a 7de8 2e00 cd18 ebfe ..}.4...}.......
0000180: 4752 5542 2000 4765 6f6d 0048 6172 6420 GRUB .Geom.Hard
0000190: 4469 736b 0052 6561 6400 2045 7272 6f72 Disk.Read. Error
00001a0: 0d0a 00bb 0100 b40e cd10 ac3c 0075 f4c3 ...........<.u..
00001b0: 0000 0000 0000 0000 0000 0000 0000 0000 ................
00001c0: 0000 0000 0000 0000 0000 0000 0000 0000 ................
00001d0: 0000 0000 0000 0000 0000 0000 0000 0000 ................
00001e0: 0000 0000 0000 0000 0000 0000 0000 0000 ................
00001f0: 0000 0000 0000 0000 0000 0000 0000 55aa ..............U.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSWCG2AAoJEJrBOlT6nu759noIAK7V5ZjDb1skpoIsQKLBGEty
5wU9Cm4yBJ9/uRhsE/w6kahZDQvjcj7jUZoYNpau94NySRLZ10QNBvMBZiflMaZF
9lZ2dtATh57eo0PvDPZ25ZgKO9rYzeAlrGx86/FffxmCpKzPAzRk7g4ggVtItEtl
irUtru4rDMdaKdfJQ9rSlYA7JcI/OcPiORUQQ+Zm1Ff2eRUSFr/8AWZrMD/oHMKb
qzln7tzKCktnKY1Iyyhr2mrNBxXxFV0QB7ObihQZxHrOmMTJTWIREVTPmDSp+jOX
7RHzV6DHLxR80HN2I2Y5iM4rEipQGxJ5Img/K6QPHWgo1BobfZNoeqe7o4lJwRg=
=rwTa
-----END PGP SIGNATURE-----
