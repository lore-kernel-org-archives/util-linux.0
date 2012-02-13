Return-Path: util-linux-owner@vger.kernel.org
Received: from minas.ics.muni.cz ([147.251.4.40]:40808 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757907Ab2BMUWJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Feb 2012 15:22:09 -0500
Received: from album.ics.muni.cz (album.ics.muni.cz [147.251.23.20])
	by minas.ics.muni.cz (8.13.8/8.13.8/SuSE Linux 0.8) with SMTP id q1DKEKlw030309
	for <util-linux@vger.kernel.org>; Mon, 13 Feb 2012 21:14:21 +0100
Date: Mon, 13 Feb 2012 21:14:20 +0100
From: Petr Pisar <petr.pisar@atlas.cz>
To: util-linux@vger.kernel.org
Subject: Message bugs in 2.21-rc2
Message-ID: <20120213201420.GA3110@album.bayer.uni.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

while updating Czech translation of util-linux-2.21-rc2, I found following
insufficiencies in original messages:


# FIXME: mkfs.bfs does not call setlocale().
#: disk-utils/mkfs.bfs.c:72
#, c-format
msgid ""
"\n"
"Options:\n"
" -N, --inodes=NUM    specify desired number of inodes\n"
" -V, --vname=NAME    specify volume name\n"
" -F, --fname=NAME    specify file system name\n"
" -v, --verbose       explain what is being done\n"
" -c                  this option is silently ignored\n"
" -l                  this option is silently ignored\n"
" -V, --version       output version information and exit\n"
"                     -V as version must be only option\n"
" -h, --help          display this help and exit\n"
"\n"

# FIXME: failed _to parse_ edition number argument
#: disk-utils/mkfs.cramfs.c:736
msgid "edition number argument failed"

# FIXME: allocate
#: disk-utils/mkfs.minix.c:484
#, c-format
msgid "%s: unable to alloc buffer for superblock"

# FIXME: Singular or plural? Missing `s'.
#: fdisk/fdisksgilabel.c:572
#, c-format
msgid "Partition overlap on the disk.\n"

# FIXME: Typo mure
#: misc-utils/findmnt.c:1070
msgid "--poll accepts only one file, but mure specified by --tab-file"

# FIXME: enties should be entities
#: misc-utils/whereis.c:143
msgid ""
" -f <file>  define search scope\n"
" -b         search only binaries\n"
" -B <dirs>  define binaries lookup path\n"
" -m         search only manual paths\n"
" -M <dirs>  define man lookup path\n"
" -s         search only sources path\n"
" -S <dirs>  define sources lookup path\n"
" -u         search from unusual enties\n"
" -V         output version information and exit\n"
" -h         display this help and exit\n"
"\n"

# FIXME: typo timrout
#: sys-utils/cytune.c:140
#, c-format
msgid ""
"File %s, For threshold value %lu and timrout value %lu, Maximum characters "
"in fifo were %d,\n"
"and the maximum transfer rate in characters/second was %f"

# FIXME: Typo }
#: sys-utils/flock.c:50
#, c-format
msgid ""
" %1$s [options] <file descriptor number>\n"
" %1$s [options] <file> -c <command>\n"
" %1$s [options} <directory> -c <command>\n"

# FIXME: Typo semaprhore
#: sys-utils/ipcrm.c:56
msgid " -s, --semaphore-id <id>    remove semaprhore by id\n"

# FIXME: Typo semaprhore
#: sys-utils/ipcrm.c:57
msgid " -S, --semaphore-key <key>  remove semaprhore by key\n"

# FIXME: value alignment counts bytes instead of columns
#: sys-utils/lscpu.c:1089
msgid "CPU op-mode(s):"

# FIXME: Remove trailing period from --priority line
#: sys-utils/swapon.c:118
msgid ""
" -a, --all              enable all swaps from /etc/fstab\n"
" -d, --discard          discard freed pages before they are reused\n"
" -e, --ifexists         silently skip devices that do not exis\n"
" -f, --fixpgsz          reinitialize the swap space if necessary\n"
" -h, --help             display help and exit\n"
" -p, --priority <prio>  specify the priority of the swap device.\n"
" -s, --summary          display summary about used swap devices and exit\n"
" -v, --verbose          verbose mode\n"
" -V, --version          display version and exit\n"

# FIXME: Getting teminal environment variable...
#: text-utils/column.c:140
msgid "terminal environment COLUMNS failed"

# FIXME: typo: disblay
#: text-utils/more.c:302
#, c-format
msgid ""
"Options:\n"
"  -d        display help instead of ring bell\n"
"  -f        count logical, rather than screen lines\n"
"  -l        suppress pause after form feed\n"
"  -p        suppress scroll, clean screen and disblay text\n"
"  -c        suppress scroll, display text and clean line ends\n"
"  -u        suppress underlining\n"
"  -s        squeeze multiple blank lines into one\n"
"  -NUM      specify the number of lines per screenful\n"
"  +NUM      display file beginning from line number NUM\n"
"  +/STRING  display file beginning from search string match\n"
"  -V        output version information and exit\n"


-- Petr

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iF4EABEIAAYFAk85bxwACgkQEsnFx2fG+qIgFQD+NgdZqUOjPHYagZEpHY2k7jDf
gKSd9m1SX25Zm5lpLisBAJLssowVFImX8XXsYE8XJUeKLYrv9679gEyefgXr26hZ
=9MJB
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
