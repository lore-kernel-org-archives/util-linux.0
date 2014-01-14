Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:65399 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbaANNa7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Jan 2014 08:30:59 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s0EDUwgF007133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 14 Jan 2014 08:30:58 -0500
Received: from x2.net.home ([10.3.113.19])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id s0EDUvlL001925
	for <util-linux@vger.kernel.org>; Tue, 14 Jan 2014 08:30:57 -0500
Date: Tue, 14 Jan 2014 14:30:56 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: v2.24.1 planning
Message-ID: <20140114133056.GG12700@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

 I'd like to release v2.24.1 this week (probably on Thursday or
 Friday). For more details see stable/v2.24 branch or the log below.

 Any objections or suggestions?
 
 (The remaining problem are pylibmount regression tests, but I guess it's some
  small mistake in the tests initialization or so..)

    Karel


agetty:
   - support the special terminal on first serial line on a S/390  [Werner Fink]
blkdiscard:
   - BLKSSZGET fills in an int, not a uint64  [Theodore Ts'o]
blkid:
   - escape quotes in the output  [Karel Zak]
   - simple typo  [Phillip Susi]
blockdev:
   - don't use HDIO_GETGEO  [Phillip Susi]
build-sys:
   - add --with-smack to config-gen.d  [Karel Zak]
chsh, chfn:
   - add info about non-local support to the man pages  [Karel Zak]
dmesg:
   - fix --raw zero timestamp for kmsg  [Karel Zak]
docs:
   - add patching process to howto-contribute.txt  [Sami Kerola]
   - update links to http //git.kernel.org/ web repository views  [Sami Kerola]
fdisk:
   - don't care about partition type  [Karel Zak]
   - fix printf stuff  [Karel Zak]
   - fix usage(), -l [<disk>]  [Karel Zak]
fsck:
   - add ext4 to list of filesystems with progress bars in fsck man page  [Phillip Susi]
fstrim:
   - add --all to discard all filesystem  [Karel Zak]
   - cleanup usage()  [Karel Zak]
lib/path:
   - add path_strdup()  [Karel Zak]
libblkid:
   - (nilfs2) check also backup superblock  [Karel Zak]
   - fix memory leak in blkid_parse_tag_string()  [Karel Zak]
   - fix swap-area version  [Karel Zak]
libfdisk:
   - (dos) be more verbose when change bootable flag  [Karel Zak]
   - (dos) fix free part counter  [Karel Zak]
   - (dos) warn on type 0  [Karel Zak]
   - (gpt) add /home GUID  [Karel Zak]
   - (gpt) improve and cleanup recovery code  [Karel Zak]
   - (gpt) recover from corrupted primary/backup PT  [Karel Zak]
   - (sgi) generate partname according to partition position  [Karel Zak]
   - (sun) fix end sectors with +1 error  [Karel Zak]
libmount:
   - add efivarfs to the list of pseudo filesystems  [Karel Zak]
   - add mnt_tag_is_valid()  [Karel Zak]
   - cleanup fix_optstr() regards to selinux and smack  [Karel Zak]
   - fix typo in smack path  [Karel Zak]
   - remove smackfs* option when SMACK not enabled  [Karel Zak]
lsblk:
   - fix -D segfault  [Karel Zak]
lscpu:
   - sort NUMA nodes to keep output human readable  [Karel Zak]
   - support discontinuous NUMA nodes  [Karel Zak]
   - support non sequentially numbering of CPUs  [Alexander Troosh]
man:
   - Syntax and spelling fixes.  [Ville Skyttä]
mkfs.minix:
   - fix fscanf() format string [coverity scan]  [Karel Zak]
mkswap:
   - remove cruft from the man page  [Phillip Susi]
mount:
   - add note about "noauto" to --all description  [Karel Zak]
   - correct mount man page default iso9660 permission  [Phillip Susi]
   - fix man mount page type  [Phillip Susi]
   - improve -s man mage info  [Karel Zak]
   - make NAME=value tags usable for non-root  [Karel Zak]
   - mount.8 fix grammar  [Phillip Susi]
   - update man page ext3/4 mount options  [Carlos Maiolino]
partx:
   - fix --update ranges and out of order tables  [Scott Moser]
pylibmount:
   - correctly import from pylibmount.so  [Dave Reisner]
script:
   - check that stdin is a terminal  [Karel Zak]
   - don't call TIOCGWINSZ in signal handler  [Karel Zak]
   - restore errno in signal handler  [Karel Zak]
setpriv:
   - simplify usage()  [Karel Zak]
setterm:
   - fix -dump man page info  [Karel Zak]
sulogin:
   - use dirent->d_type when scans /dev  [Karel Zak]
taskset:
   - fix PERMISSIONS section of taskset man page  [Rik van Riel]
tests:
   - update blkid swap tests  [Karel Zak]
   - update lscpu tests  [Karel Zak]
textual:
   - small inprovements to usage and man page of fstrim  [Benno Schulenberg]
umount:
   - fix umount by tag for non-roots  [Karel Zak]
unshare:
   - add more hints about mount namespaces to the man page  [Karel Zak]

- add more hints about mount namespaces to the man page  [Karel Zak]
