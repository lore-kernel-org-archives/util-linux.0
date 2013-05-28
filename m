Return-Path: util-linux-owner@vger.kernel.org
Received: from fep12.mx.upcmail.net ([62.179.121.32]:38652 "EHLO
	fep12.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754464Ab3E1TJ2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 May 2013 15:09:28 -0400
Received: from edge01.upcmail.net ([192.168.13.236])
          by viefep15-int.chello.at
          (InterMail vM.8.01.05.05 201-2260-151-110-20120111) with ESMTP
          id <20130528185411.MFKF28100.viefep15-int.chello.at@edge01.upcmail.net>
          for <util-linux@vger.kernel.org>; Tue, 28 May 2013 20:54:11 +0200
Received: from album.bayer.uni.cx (album.bayer.uni.cx [IPv6:2002:5e71:d886:1:5246:5dff:fe8e:a186])
	by router.bayer.uni.cx (Postfix) with SMTP id BD69E3BD53
	for <util-linux@vger.kernel.org>; Tue, 28 May 2013 20:54:09 +0200 (CEST)
Date: Tue, 28 May 2013 20:54:09 +0200
From: Petr Pisar <petr.pisar@atlas.cz>
To: util-linux@vger.kernel.org
Subject: Mistakes in messages
Message-ID: <20130528185409.GA3590@album.bayer.uni.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

while translating version 2.23.1, I found following messages that I consider
to be wrong:

# FIXME: failed _to parse_ edition number argument
#: disk-utils/mkfs.cramfs.c:739
msgid "edition number argument failed"

# FIXME: allocate
#: disk-utils/mkfs.minix.c:485
#, c-format
msgid "%s: unable to alloc buffer for superblock"

# FIXME: s/Partitions/Partition/
#: fdisks/fdiskdoslabel.c:767
#, c-format
msgid "Partitions %zd: cylinder %d greater than maximum %llu\n"

# FIXME: split lines 6.xpartitions, additionalinformation
#: fdisks/fdiskdoslabel.c:1099
#, c-format
msgid ""
"\n"
"WARNING: If you have created or modified any DOS 6.xpartitions, please see "
"the fdisk manual page for additionalinformation.\n"
"\n"

# FIXME: Signular or plural? Missing `s'.
#: fdisks/fdisksgilabel.c:631
#, c-format
msgid "Partition overlap on the disk.\n"

# FIXME: s/type/press/
#: login-utils/sulogin.c:493
#, c-format
msgid "(or type Control-D to continue): "

# FIXME: s/frequency/period/
#: misc-utils/findmnt.c:136
msgid "dump(8) frequency in days [fstab only]"

# FIXME: s/complate/complete
#: misc-utils/lsblk.c:1378
msgid " -p, --paths          print complate device path\n"

# FIXME: Missing full stop.
#: misc-utils/uuidd.c:600
#, c-format
msgid "Both --socket-activation and --socket specified. Ignoring --socket\n"

# FIXME: typo `tailed'
#: mount-deprecated/mount.c:1314
msgid "mount: tailed to initialize loopdev context"

# FIXME: Missing comma after sector
#: sys-utils/losetup.c:393
#, c-format
msgid ""
"%s: warning: file does not fit into a 512-byte sector the end of the file "
"will be ignored."

-- Petr

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iF4EABEIAAYFAlGk/VEACgkQEsnFx2fG+qJ5xAD8C6CwSB04wdEEz04tgb0b283U
gGsXpMV0mZscEkbO734A/28sG9ykJ+R5Zszeiwq5uq1ilXFJvpS0EOB7J4w3Z3G/
=JLoc
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
