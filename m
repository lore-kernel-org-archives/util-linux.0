Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51209 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934709Ab2C3UGg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 30 Mar 2012 16:06:36 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2UK6ae7022642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 30 Mar 2012 16:06:36 -0400
Received: from x2 (ovpn-116-49.ams2.redhat.com [10.36.116.49])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q2UK6ZYx021185
	for <util-linux@vger.kernel.org>; Fri, 30 Mar 2012 16:06:35 -0400
Date: Fri, 30 Mar 2012 22:06:34 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.21.1
Message-ID: <20120330200634.GF23437@x2.net.home>
References: <20120330114251.GA23437@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20120330114251.GA23437@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 30, 2012 at 01:42:51PM +0200, Karel Zak wrote:
> 
> The util-linux bugfix release v2.21.1 is available at
> 
>   ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.21/
> 
> Feedback and bug reports, as always, are welcomed.

 Ah, I forgot release notes...

    Karel



util-linux 2.21.1 Release Notes
===============================

Changes since v2.21
-------------------

 For more details see ChangeLog files at:
 ftp://ftp.infradead.org/pub/util-linux/v2.21/


blkid:
   - add note about variable tags and devices order.  [Karel Zak]
build-sys:
   - add a crosscompile path for scanf_cv_alloc_modifier  [Sebastian Andrzej Siewior]
   - don't create empty man/ru directory  [Karel Zak]
   - make the crosscompile path for scanf_cv_alloc_modifier clever  [Sebastian Andrzej Siewior]
docs:
   - update AUTHORS file  [Karel Zak]
fdisk:
   - don't print confusing warning on non-partitioned disks  [Karel Zak]
   - fix to build for IA32  [Christian Wiese]
findmnt:
   - add -P, --pairs to the man page  [Bill Pemberton]
fstab:
   - fstab.5 fix misspelling of deprecated  [Dave Reisner]
libblkid:
   - properly reset chain in probe_do_wipe()  [Karel Zak]
libmount:
   - add configfs to pseudofs list  [Karel Zak]
   - add mnt_fs_streq_srcpath()  [Karel Zak]
   - add mnt_fs_streq_target()  [Karel Zak]
   - add nfsd to mnt_fstype_is_pseudofs()  [Karel Zak]
   - allow empty source for mount(2) syscall  [Karel Zak]
   - avoid infinite loop in child fs iteration  [Dave Reisner]
   - canonicalize all paths from (fs)tab  [Karel Zak]
   - canonicalize targets from fstab on mount -a  [Karel Zak]
   - cosmetic changes around "none"  [Karel Zak]
   - don't treat "none" differently  [Dave Reisner]
   - fix "already mounted" detection on systems with mtab  [Karel Zak]
   - optimize for paths with tailing slash  [Karel Zak]
   - use mount.<type> -s for NFS only  [Karel Zak]
login:
   - correction in sig_handler()  [Karel Zak]
   - fix LOGIN_CHOWN_VCS code  [Karel Zak]
   - support crazy shadow-utils syntax in login.defs  [Karel Zak]
losetup:
   - Fix setting of sizelimit on new loop devices  [Daniel Drake]
   - add --detach-all to the list of options  [Petr Uzel]
lsblk:
   - RQ-SIZE is part of the --topology output (man page bugfix)  [Dave Reisner]
   - remove (dm-N) from NAME for raw/pair output format  [Karel Zak]
mount:
   - (new) add 'internal-only(i)' to non-root allowed options  [Raghavendra D Prabhu]
   - (new) add missing xalloc.h  [Karel Zak]
   - (new) cleanup mount -a return codes  [Karel Zak]
   - fix recursively propagation mounting  [Dong Hao]
mountpoint:
   - account for error from in mnt_fs_get_target  [Dave Reisner]
   - fix a minor bug with 0 0 devno  [Zhi Li]
po:
   - merge changes  [Karel Zak]
   - update vi.po (from translationproject.org)  [Trần Ngọc Quân]
script:
   - play well with csh when invoked from within /etc/csh.login  [Karel Zak]
tests:
   - test 'none' source for mount(8)  [Karel Zak]
   - add tests for mount --make-* stuff  [Karel Zak]
   - make output and diff dirs usage more robust  [Karel Zak]
   - search for "none" by findmnt  [Karel Zak]
   - test non-canonical paths in fstab  [Karel Zak]
   - update fdisk test  [Karel Zak]
   - update libmount tests  [Karel Zak]
   - wait a moment between mount and umount  [Karel Zak]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
