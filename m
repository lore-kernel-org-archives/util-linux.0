Return-Path: util-linux-owner@vger.kernel.org
Received: from fep12.mx.upcmail.net ([62.179.121.32]:49841 "EHLO
	fep12.mx.upcmail.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab3JDI4l (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 4 Oct 2013 04:56:41 -0400
Received: from edge02.upcmail.net ([192.168.13.237])
          by viefep12-int.chello.at
          (InterMail vM.8.01.05.05 201-2260-151-110-20120111) with ESMTP
          id <20131004085639.LSJR27765.viefep12-int.chello.at@edge02.upcmail.net>
          for <util-linux@vger.kernel.org>; Fri, 4 Oct 2013 10:56:39 +0200
Received: from album.bayer.uni.cx (album.bayer.uni.cx [IPv6:2002:5e71:d886:1:5246:5dff:fe8e:a186])
	by router.bayer.uni.cx (Postfix) with SMTP id 86F178F8C1
	for <util-linux@vger.kernel.org>; Fri,  4 Oct 2013 10:56:37 +0200 (CEST)
Date: Fri, 4 Oct 2013 10:56:37 +0200
From: Petr Pisar <petr.pisar@atlas.cz>
To: util-linux@vger.kernel.org
Subject: util-linux 2.24-rc1 message errors
Message-ID: <20131004085637.GC3808@album.bayer.uni.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xesSdrSSBC0PokLI"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--xesSdrSSBC0PokLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

while translating util-linux 2.24-rc1, I found following mistakes or
insufficiencies in the messages:

# TODO: Pluralize
#: disk-utils/mkfs.bfs.c:247
#, c-format
msgid "Inodes: %lu (in %llu blocks)\n"

# TODO: Pluralize
#: disk-utils/mkfs.cramfs.c:902
#, c-format
msgid "warning: uids truncated to %u bits.  (This may be a security concern.)"

# TODO: Pluralize
#: disk-utils/mkfs.cramfs.c:905
#, c-format
msgid "warning: gids truncated to %u bits.  (This may be a security concern.)"

# TODO: Pluralize
#: disk-utils/mkfs.cramfs.c:908
#, c-format
msgid ""
"WARNING: device numbers truncated to %u bits.  This almost certainly means\n"
"that some device files will be wrong."

# TODO: Pluralize
#: disk-utils/mkfs.minix.c:544
#, c-format
msgid "%lu inodes\n"

# TODO: Pluralize
#: disk-utils/mkfs.minix.c:545
#, c-format
msgid "%lu blocks\n"

# TODO: Pluralize
#: disk-utils/mkfs.minix.c:618 disk-utils/mkfs.minix.c:644
#, c-format
msgid "%d bad blocks\n"

# TODO: Pluralize %ju sectors
#: disk-utils/partx.c:526
#, c-format
msgid "#%2d: %9ju-%9ju (%9ju sectors, %6ju MB)\n"

# FIXME: s/aprimary/a primary/
#: libfdisk/src/dos.c:1253
msgid ""
"If you want to create more than four partitions, you must replace aprimary "
"partition with an extended partition first."

# FIXME: s/table Probably/table. Probably/
#: libfdisk/src/dos.c:1588
msgid ""
"This doesn't look like a partition table Probably you selected the wrong "
"device."

# FIXME: Plural
#: libfdisk/src/gpt.c:1528
#, c-format
msgid "A total of %ld free sectors available in %d segment(s) (largest %ld)."

# FIXME: Plural
#: libfdisk/src/gpt.c:1532
#, c-format
msgid "Detected %d error(s)."

# TODO: Plurals
#: libfdisk/src/sgi.c:420
#, c-format
msgid "Name of Bootfile too long: %zu bytes maximum."

# TODO: Plurals
#: libfdisk/src/sgi.c:659
#, c-format
msgid "The Partition %d and %d overlap by %d sectors."

# FIXME: Signular or plural? Missing `s'.
#: libfdisk/src/sgi.c:762
msgid "Partition overlap on the disk."

# FIXME: Missing space after full stop.
#: libfdisk/src/sgi.c:976
#, c-format
msgid ""
"Warning:  BLKGETSIZE ioctl failed on %s.  Using geometry cylinder value of "
"%llu.This value may be truncated for devices > 33.8 GB."

# TODO: Pluralize
#: libfdisk/src/sun.c:657
#, c-format
msgid ""
"If you want to maintain SunOS/Solaris compatibility, consider leaving this "
"partition as Whole disk (5), starting at 0, with %u sectors"

# TODO: Plural
#: login-utils/su-common.c:805
#, c-format
msgid "can't specify more than %d supplemental groups"

# TODO: Pluralize
#: misc-utils/mcookie.c:150 misc-utils/mcookie.c:174
#, c-format
msgid "Got %d bytes from %s\n"

# TODO: Pluralize
#: misc-utils/wipefs.c:311
#, c-format
msgid "%s: %zd bytes were erased at offset 0x%08jx (%s): "

# TODO: Capitalize FTP
#: sys-utils/dmesg.c:118
msgid "ftp daemon"

# FIXME: s/mhz/MHz/
#: sys-utils/lscpu.c:260
msgid "shows the maximum mhz of the CPU"

# FIXME: s/mhz/MHz/
#: sys-utils/lscpu.c:261
msgid "shows the minimum mhz of the CPU"

# FIXME: value alignment counts bytes instead of columns
#: sys-utils/lscpu.c:1229
msgid "CPU op-mode(s):"

# TODO: Pluralize
#: sys-utils/wdctl.c:452 sys-utils/wdctl.c:454 sys-utils/wdctl.c:456
#, c-format
msgid "%-15s%2i seconds\n"

# FIXME: s/cotrol/control/
#: term-utils/agetty.c:1810
msgid " -L, --local-line[=<mode>]  cotrol local line flag\n"

# FIXME: Enclose argument within angle parentheses
#: text-utils/hexsyntax.c:150
msgid ""
" -e, --format format       format string to be used for displaying data\n"

-- Petr

--xesSdrSSBC0PokLI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iF4EABEIAAYFAlJOgsUACgkQEsnFx2fG+qIqYwD9EToEYTjnJ4zTmdVSSdNTfMV6
wxwnXMPk3g9pV2HGWg4A/1IBS8ZAnqPzCI8aD5zZyXUfkjuQorIFzHX4U+ezhU4I
=MK7+
-----END PGP SIGNATURE-----

--xesSdrSSBC0PokLI--
