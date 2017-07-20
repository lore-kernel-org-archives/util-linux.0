Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37860 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933220AbdGTJkQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 20 Jul 2017 05:40:16 -0400
Date: Thu, 20 Jul 2017 11:40:12 +0200
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux stable v2.30.1
Message-ID: <20170720094012.kqm7qzrkihuyaufi@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The util-linux stable maintenance release v2.30.1 is available at

  http://www.kernel.org/pub/linux/utils/util-linux/v2.30

Feedback and bug reports, as always, are welcomed.

  Karel


util-linux 2.30.1 Release Notes
===============================

agetty:
   - fix login name DEL/CTRL^U issue  [Karel Zak]
cfdisk:
   - simplify ncurses includes  [Karel Zak]
column:
   - fix compilation when libc lacks wide-character support  [Carlos Santos]
dmesg:
   - print only 2 hex digits for each hex-escaped byte  [Ivan Delalande]
docs:
   - update AUTHORS file  [Karel Zak]
fdformat:
   - clear progress message before printing "done"  [Jakub Wilk]
fstrim:
   - prefer earlier mounted filesystems  [Alex Ivanov]
libblkid:
   - don't use CDROM_GET_CAPABILITY ioctl for DM devices  [Karel Zak]
   - udf  Fix detection of UDF images with block size 1024 and 4096  [Pali Rohár]
libfdisk:
   - (dos) accept start for log.partitions on template  [Karel Zak]
   - (dos) be more verbose on partno -ERANGE error  [Karel Zak]
   - (dos) cleanup template based partitioning  [Karel Zak]
   - (dos) fix primary/logical logic when follow template  [Karel Zak]
   - make fdisk compliant to UEFI/GPT specification on PMBR  [Karel Zak]
libmount:
   - make mnt_context_is_fs_mounted work for /proc  [Ivan Delalande]
lscpu:
   - cleanup DMI detection return codes  [Karel Zak]
mount:
   - fix man page typo (--bind,ro)  [Karel Zak]
po:
   - merge changes  [Karel Zak]
   - update da.po (from translationproject.org)  [Joe Hansen]
   - update pt_BR.po (from translationproject.org)  [Rafael Fontenelle]
pylibmount:
   - NULL terminate kwlist in Context_init  [Zac Medico]
test:
   - update PMBR hex dumps  [Karel Zak]
tests:
   - Add UDF hdd images with blocksize 1024 and 4096 created by Linux mkudffs 1.3  [Pali Rohár]
   - fix fincore, don't use variable COLUMNS  [Ruediger Meier]
   - update build-sys non-widechar test  [Karel Zak]
umount:
   - add note about NFS and -c to umount.8  [Karel Zak]
   - never 'stat' the path when "-c" is given.  [NeilBrown]
wipefs:
   - exit on failed erase  [Karel Zak]


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
