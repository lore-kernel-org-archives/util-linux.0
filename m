Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92EC221DB3
	for <util-linux@vger.kernel.org>; Mon,  2 Jun 2025 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873716; cv=none; b=f6rdUJavNleL7fo35zJ1jGM0Qea38oP0mM6W+AmcARrovRBSuJRNAKJpnMOPhkeMV4khYOkd8JOgYAMR8Olsl3c2Jyp72ZdEp+ux51rBboYdU/MSZXUjauGRqrYkzTmuF9f8UcN0Q+7Tft51WteKx4jGza4RGN4kmcUgpR5OVE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873716; c=relaxed/simple;
	bh=xpzh/oBxkExgivfktfLfNLHlnRexeEs31giE3j8y1BY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AR5637TJhU8TFYwo2+4z4s6PdmzuS+MMIUjICgYNMVWd6fCtYwGoF2MDA7X6IR/w0C5tIiNrvdHc6v/Iim/NGX67ZxS8iD0FhDlO+jEDbrBL7BIzbXoeBCuFeIYFMPiBWaaVWq7Ilr9S4Rri69iU3rL3voEaV72oaVGFG0jOJrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=a4F/gmnI; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="a4F/gmnI"
X-KPN-MessageId: 2181ad59-3fbc-11f0-86cf-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2181ad59-3fbc-11f0-86cf-005056aba152;
	Mon, 02 Jun 2025 16:16:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=lJooYB9V/HW5F/Pjp9mXoD3no5R0YSXP2AwCjBw76es=;
	b=a4F/gmnIQjzsgJBiNE+kAfrBSaEpr1zaKuHOhE3Daya/hI4oJIxSc26rCIl4cu0wQCT67469kv6hg
	 O/M+FBdHhyVIEr0Fx2VECCgTyvHSxwbpMDI72A8zzftulSGWXHDrgKMdIxIit7rfWRtiFrGb8CvOPw
	 AxAhRr0ItDRPRWnU=
X-KPN-MID: 33|DHH1ejSXEWBBgdVNRjT/trdL4hDfx+2T5Giarow35VpEzH6emb8YB80jRVFr+nK
 KIJcwfBtm2LkEThKgLbSYEuC1Hcts08Uf2OhlHA4n948=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|fVKJSSJae2rTfaL444smwaUv3URMioNbdZVSbyOV8pfmro+N5KgSY4bTaP37RJd
 1hFsmuV1lfp2Ta3GHd3dmCw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id fe61fe16-3fbb-11f0-95af-005056abf0db;
	Mon, 02 Jun 2025 16:15:10 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/6] docs: stop the copyright verbiage from getting included in the POT file
Date: Mon,  2 Jun 2025 16:14:35 +0200
Message-ID: <20250602141436.11156-5-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250602141436.11156-1-bensberg@telfort.nl>
References: <20250602141436.11156-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For some reason the asciidoc parser from `po4a` includes *all* comments
from an adoc file into the util-linux-man.pot file.  Xgettext had a way
to include only certain comments, but `po4a` does not appear to have a
dedicated mechanism for this.

So... use some bricolage: insert a fruitless 'ifdef' as a barrier
between the copyright/license comment and the title line.  This
prevents `po4a` from seeing the two things as belonging together.

This shrinks the util-linux-man.pot file by 1267 lines (2.5%),
equivalent to nearly 67kB (4.8%).

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/addpart.8.adoc        | 2 ++
 disk-utils/blockdev.8.adoc       | 2 ++
 disk-utils/cfdisk.8.adoc         | 2 ++
 disk-utils/delpart.8.adoc        | 2 ++
 disk-utils/fdformat.8.adoc       | 2 ++
 disk-utils/fdisk.8.adoc          | 2 ++
 disk-utils/fsck.8.adoc           | 2 ++
 disk-utils/fsck.minix.8.adoc     | 2 ++
 disk-utils/mkfs.bfs.8.adoc       | 2 ++
 disk-utils/mkfs.minix.8.adoc     | 2 ++
 disk-utils/mkswap.8.adoc         | 2 ++
 disk-utils/partx.8.adoc          | 2 ++
 disk-utils/resizepart.8.adoc     | 2 ++
 disk-utils/sfdisk.8.adoc         | 2 ++
 disk-utils/swaplabel.8.adoc      | 2 ++
 lib/terminal-colors.d.5.adoc     | 1 +
 libblkid/libblkid.3.adoc         | 2 ++
 libsmartcols/scols-filter.5.adoc | 2 ++
 libuuid/man/uuid.3.adoc          | 2 ++
 libuuid/man/uuid_clear.3.adoc    | 2 ++
 libuuid/man/uuid_compare.3.adoc  | 2 ++
 libuuid/man/uuid_copy.3.adoc     | 2 ++
 libuuid/man/uuid_generate.3.adoc | 2 ++
 libuuid/man/uuid_is_null.3.adoc  | 2 ++
 libuuid/man/uuid_parse.3.adoc    | 2 ++
 libuuid/man/uuid_time.3.adoc     | 2 ++
 libuuid/man/uuid_unparse.3.adoc  | 2 ++
 login-utils/chfn.1.adoc          | 2 ++
 login-utils/chsh.1.adoc          | 2 ++
 login-utils/last.1.adoc          | 2 ++
 login-utils/login.1.adoc         | 2 ++
 login-utils/lslogins.1.adoc      | 2 ++
 login-utils/newgrp.1.adoc        | 2 ++
 login-utils/sulogin.8.adoc       | 2 ++
 login-utils/utmpdump.1.adoc      | 2 ++
 login-utils/vipw.8.adoc          | 2 ++
 lsfd-cmd/lsfd.1.adoc             | 2 ++
 misc-utils/blkid.8.adoc          | 2 ++
 misc-utils/cal.1.adoc            | 2 ++
 misc-utils/fincore.1.adoc        | 2 ++
 misc-utils/findfs.8.adoc         | 2 ++
 misc-utils/hardlink.1.adoc       | 2 ++
 misc-utils/kill.1.adoc           | 2 ++
 misc-utils/lastlog2.8.adoc       | 2 ++
 misc-utils/logger.1.adoc         | 2 ++
 misc-utils/look.1.adoc           | 2 ++
 misc-utils/lslocks.8.adoc        | 2 ++
 misc-utils/mcookie.1.adoc        | 2 ++
 misc-utils/rename.1.adoc         | 2 ++
 misc-utils/uuidd.8.adoc          | 2 ++
 misc-utils/uuidgen.1.adoc        | 2 ++
 misc-utils/uuidparse.1.adoc      | 2 ++
 misc-utils/whereis.1.adoc        | 2 ++
 misc-utils/wipefs.8.adoc         | 2 ++
 schedutils/chrt.1.adoc           | 2 ++
 schedutils/coresched.1.adoc      | 4 +---
 schedutils/taskset.1.adoc        | 2 ++
 schedutils/uclampset.1.adoc      | 2 ++
 sys-utils/ctrlaltdel.8.adoc      | 2 ++
 sys-utils/dmesg.1.adoc           | 2 ++
 sys-utils/eject.1.adoc           | 2 ++
 sys-utils/flock.1.adoc           | 2 ++
 sys-utils/fstab.5.adoc           | 2 ++
 sys-utils/hwclock.8.adoc         | 2 ++
 sys-utils/ipcmk.1.adoc           | 2 ++
 sys-utils/ipcrm.1.adoc           | 2 ++
 sys-utils/ipcs.1.adoc            | 2 ++
 sys-utils/ldattach.8.adoc        | 2 ++
 sys-utils/lsns.8.adoc            | 2 ++
 sys-utils/mount.8.adoc           | 2 ++
 sys-utils/prlimit.1.adoc         | 2 ++
 sys-utils/renice.1.adoc          | 2 ++
 sys-utils/setpgid.1.adoc         | 2 ++
 sys-utils/setsid.1.adoc          | 2 ++
 sys-utils/umount.8.adoc          | 2 ++
 term-utils/mesg.1.adoc           | 2 ++
 term-utils/script.1.adoc         | 2 ++
 term-utils/setterm.1.adoc        | 2 ++
 term-utils/wall.1.adoc           | 2 ++
 term-utils/write.1.adoc          | 2 ++
 text-utils/bits.1.adoc           | 2 ++
 text-utils/col.1.adoc            | 2 ++
 text-utils/colcrt.1.adoc         | 2 ++
 text-utils/colrm.1.adoc          | 2 ++
 text-utils/column.1.adoc         | 2 ++
 text-utils/hexdump.1.adoc        | 2 ++
 text-utils/line.1.adoc           | 2 ++
 text-utils/more.1.adoc           | 2 ++
 text-utils/pg.1.adoc             | 2 ++
 text-utils/rev.1.adoc            | 2 ++
 text-utils/ul.1.adoc             | 2 ++
 91 files changed, 180 insertions(+), 3 deletions(-)

diff --git a/disk-utils/addpart.8.adoc b/disk-utils/addpart.8.adoc
index 1c1a9dc04..ef3fe0673 100644
--- a/disk-utils/addpart.8.adoc
+++ b/disk-utils/addpart.8.adoc
@@ -5,6 +5,8 @@ Copyright 2007 Karel Zak <kzak@redhat.com>
 Copyright 2007 Red Hat, Inc.
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = addpart(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/disk-utils/blockdev.8.adoc b/disk-utils/blockdev.8.adoc
index 3c4178b63..a923c563c 100644
--- a/disk-utils/blockdev.8.adoc
+++ b/disk-utils/blockdev.8.adoc
@@ -5,6 +5,8 @@ Copyright 2007 Karel Zak <kzak@redhat.com>
 
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = blockdev(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/disk-utils/cfdisk.8.adoc b/disk-utils/cfdisk.8.adoc
index 121d023ab..33bbd4af6 100644
--- a/disk-utils/cfdisk.8.adoc
+++ b/disk-utils/cfdisk.8.adoc
@@ -13,6 +13,8 @@ manual under the conditions for verbatim copying, provided that the
 entire resulting derived work is distributed under the terms of a
 permission notice identical to this one.
 ////
+ifdef::neverdefined[---]
+
 = cfdisk(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/disk-utils/delpart.8.adoc b/disk-utils/delpart.8.adoc
index e52e25419..be2e77c36 100644
--- a/disk-utils/delpart.8.adoc
+++ b/disk-utils/delpart.8.adoc
@@ -5,6 +5,8 @@ Copyright 2007 Karel Zak <kzak@redhat.com>
 Copyright 2007 Red Hat, Inc.
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = delpart(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/disk-utils/fdformat.8.adoc b/disk-utils/fdformat.8.adoc
index d57f49d04..e717cb5c7 100644
--- a/disk-utils/fdformat.8.adoc
+++ b/disk-utils/fdformat.8.adoc
@@ -3,6 +3,8 @@
 Copyright 1992, 1993 Rickard E. Faith (faith@cs.unc.edu)
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = fdformat(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/disk-utils/fdisk.8.adoc b/disk-utils/fdisk.8.adoc
index 13e7147bb..d53ab432a 100644
--- a/disk-utils/fdisk.8.adoc
+++ b/disk-utils/fdisk.8.adoc
@@ -6,6 +6,8 @@ Copyright 2012 Davidlohr Bueso <dave@gnu.org>
 Copyright (C) 2013 Karel Zak <kzak@redhat.com>
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = fdisk(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/disk-utils/fsck.8.adoc b/disk-utils/fsck.8.adoc
index 8631bcd79..cfc4a072c 100644
--- a/disk-utils/fsck.8.adoc
+++ b/disk-utils/fsck.8.adoc
@@ -3,6 +3,8 @@
 Copyright 1993, 1994, 1995 by Theodore Ts'o.  All Rights Reserved.
 This file may be copied under the terms of the GNU General Public License.
 ////
+ifdef::neverdefined[---]
+
 = fsck(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/disk-utils/fsck.minix.8.adoc b/disk-utils/fsck.minix.8.adoc
index 37baaced5..7dfbc6688 100644
--- a/disk-utils/fsck.minix.8.adoc
+++ b/disk-utils/fsck.minix.8.adoc
@@ -3,6 +3,8 @@
 Copyright 1992, 1993, 1994 Rickard E. Faith (faith@cs.unc.edu)
 May be freely distributed.
 ////
+ifdef::neverdefined[---]
+
 = fsck.minix(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/disk-utils/mkfs.bfs.8.adoc b/disk-utils/mkfs.bfs.8.adoc
index e66f8e0b5..647b0d5bb 100644
--- a/disk-utils/mkfs.bfs.8.adoc
+++ b/disk-utils/mkfs.bfs.8.adoc
@@ -3,6 +3,8 @@
 Copyright 1999 Andries E. Brouwer (aeb@cwi.nl)
 May be freely distributed.
 ////
+ifdef::neverdefined[---]
+
 = mkfs.bfs(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/disk-utils/mkfs.minix.8.adoc b/disk-utils/mkfs.minix.8.adoc
index f747ee40f..99ff263fa 100644
--- a/disk-utils/mkfs.minix.8.adoc
+++ b/disk-utils/mkfs.minix.8.adoc
@@ -6,6 +6,8 @@ Copyright 2012 Davidlohr Bueso <dave@gnu.org>
 Copyright (C) 2013 Karel Zak <kzak@redhat.com>
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = mkfs.minix(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/disk-utils/mkswap.8.adoc b/disk-utils/mkswap.8.adoc
index a7838ae91..ace8dde73 100644
--- a/disk-utils/mkswap.8.adoc
+++ b/disk-utils/mkswap.8.adoc
@@ -3,6 +3,8 @@
 Copyright 1998 Andries E. Brouwer (aeb@cwi.nl)
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = mkswap(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/disk-utils/partx.8.adoc b/disk-utils/partx.8.adoc
index 180f1c32b..552cc6178 100644
--- a/disk-utils/partx.8.adoc
+++ b/disk-utils/partx.8.adoc
@@ -6,6 +6,8 @@ Copyright 2007 Red Hat, Inc.
 Copyright 2010 Davidlohr Bueso <dave@gnu.org>
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = partx(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/disk-utils/resizepart.8.adoc b/disk-utils/resizepart.8.adoc
index b07680b61..e65215b55 100644
--- a/disk-utils/resizepart.8.adoc
+++ b/disk-utils/resizepart.8.adoc
@@ -5,6 +5,8 @@ Copyright 2012 Vivek Goyal <vgoyal@redhat.com>
 Copyright 2012 Red Hat, Inc.
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = resizepart(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/disk-utils/sfdisk.8.adoc b/disk-utils/sfdisk.8.adoc
index ac81ec939..99849a638 100644
--- a/disk-utils/sfdisk.8.adoc
+++ b/disk-utils/sfdisk.8.adoc
@@ -12,6 +12,8 @@ manual under the conditions for verbatim copying, provided that the
 entire resulting derived work is distributed under the terms of a
 permission notice identical to this one.
 ////
+ifdef::neverdefined[---]
+
 = sfdisk(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/disk-utils/swaplabel.8.adoc b/disk-utils/swaplabel.8.adoc
index 0a1a1136f..94fc38d1f 100644
--- a/disk-utils/swaplabel.8.adoc
+++ b/disk-utils/swaplabel.8.adoc
@@ -3,6 +3,8 @@
 Copyright 2010 Jason Borden <jborden@bluehost.com>
 This file may be copied under the terms of the GNU General Public License.
 ////
+ifdef::neverdefined[---]
+
 = swaplabel(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/lib/terminal-colors.d.5.adoc b/lib/terminal-colors.d.5.adoc
index 4936947b1..40ed8b966 100644
--- a/lib/terminal-colors.d.5.adoc
+++ b/lib/terminal-colors.d.5.adoc
@@ -6,6 +6,7 @@ Copyright (C) 2014 Karel Zak <kzak@redhat.com>
 Copyright 2014 Red Hat, Inc.
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
 
 = terminal-colors.d(5)
 :doctype: manpage
diff --git a/libblkid/libblkid.3.adoc b/libblkid/libblkid.3.adoc
index 853d12134..9c92bc5c7 100644
--- a/libblkid/libblkid.3.adoc
+++ b/libblkid/libblkid.3.adoc
@@ -5,6 +5,8 @@ This man page was created for libblkid.so.1.0 from e2fsprogs-1.24.
 This file may be copied under the terms of the GNU Lesser General Public License.
 Created  Wed Sep 14 12:02:12 2001, Andreas Dilger
 ////
+ifdef::neverdefined[---]
+
 = libblkid(3)
 :doctype: manpage
 :man manual: Programmer's Manual
diff --git a/libsmartcols/scols-filter.5.adoc b/libsmartcols/scols-filter.5.adoc
index 939da7733..54a1b7251 100644
--- a/libsmartcols/scols-filter.5.adoc
+++ b/libsmartcols/scols-filter.5.adoc
@@ -4,6 +4,8 @@ Copyright (C) 2023 Karel Zak <kzak@redhat.com>
 
 This file may be copied under the terms of the GNU General Public License.
 ////
+ifdef::neverdefined[---]
+
 = scols-filter(5)
 :doctype: manpage
 :man manual: File formats and conventions
diff --git a/libuuid/man/uuid.3.adoc b/libuuid/man/uuid.3.adoc
index c8c6d66dd..df4b79277 100644
--- a/libuuid/man/uuid.3.adoc
+++ b/libuuid/man/uuid.3.adoc
@@ -30,6 +30,8 @@ DAMAGE.
 
 Created  Wed Mar 10 17:42:12 1999, Andreas Dilger
 ////
+ifdef::neverdefined[---]
+
 = uuid(3)
 :doctype: manpage
 :man manual: Programmer's Manual
diff --git a/libuuid/man/uuid_clear.3.adoc b/libuuid/man/uuid_clear.3.adoc
index 48c3a59b5..4975ca76f 100644
--- a/libuuid/man/uuid_clear.3.adoc
+++ b/libuuid/man/uuid_clear.3.adoc
@@ -30,6 +30,8 @@ DAMAGE.
 
 Created  Wed Mar 10 17:42:12 1999, Andreas Dilger
 ////
+ifdef::neverdefined[---]
+
 = uuid_clear(3)
 :doctype: manpage
 :man manual: Programmer's Manual
diff --git a/libuuid/man/uuid_compare.3.adoc b/libuuid/man/uuid_compare.3.adoc
index 600116750..9802e2bf1 100644
--- a/libuuid/man/uuid_compare.3.adoc
+++ b/libuuid/man/uuid_compare.3.adoc
@@ -30,6 +30,8 @@ DAMAGE.
 
 Created  Wed Mar 10 17:42:12 1999, Andreas Dilger
 ////
+ifdef::neverdefined[---]
+
 = uuid_compare(3)
 :doctype: manpage
 :man manual: Programmer's Manual
diff --git a/libuuid/man/uuid_copy.3.adoc b/libuuid/man/uuid_copy.3.adoc
index 31c963dec..5323e8472 100644
--- a/libuuid/man/uuid_copy.3.adoc
+++ b/libuuid/man/uuid_copy.3.adoc
@@ -30,6 +30,8 @@ DAMAGE.
 
 Created  Wed Mar 10 17:42:12 1999, Andreas Dilger
 ////
+ifdef::neverdefined[---]
+
 = uuid_copy(3)
 :doctype: manpage
 :man manual: Programmer's Manual
diff --git a/libuuid/man/uuid_generate.3.adoc b/libuuid/man/uuid_generate.3.adoc
index 420634d51..f8916eace 100644
--- a/libuuid/man/uuid_generate.3.adoc
+++ b/libuuid/man/uuid_generate.3.adoc
@@ -32,6 +32,8 @@ DAMAGE.
 
 Created  Wed Mar 10 17:42:12 1999, Andreas Dilger
 ////
+ifdef::neverdefined[---]
+
 = uuid_generate(3)
 :doctype: manpage
 :man manual: Programmer's Manual
diff --git a/libuuid/man/uuid_is_null.3.adoc b/libuuid/man/uuid_is_null.3.adoc
index 23f2bf85f..ba62e3315 100644
--- a/libuuid/man/uuid_is_null.3.adoc
+++ b/libuuid/man/uuid_is_null.3.adoc
@@ -30,6 +30,8 @@ DAMAGE.
 
 Created  Wed Mar 10 17:42:12 1999, Andreas Dilger
 ////
+ifdef::neverdefined[---]
+
 = uuid_is_null(3)
 :doctype: manpage
 :man manual: Programmer's Manual
diff --git a/libuuid/man/uuid_parse.3.adoc b/libuuid/man/uuid_parse.3.adoc
index 230023fd5..cecabe4cf 100644
--- a/libuuid/man/uuid_parse.3.adoc
+++ b/libuuid/man/uuid_parse.3.adoc
@@ -30,6 +30,8 @@ DAMAGE.
 
 Created  Wed Mar 10 17:42:12 1999, Andreas Dilger
 ////
+ifdef::neverdefined[---]
+
 = uuid_parse(3)
 :doctype: manpage
 :man manual: Programmer's Manual
diff --git a/libuuid/man/uuid_time.3.adoc b/libuuid/man/uuid_time.3.adoc
index 5e579e240..3d57e5f96 100644
--- a/libuuid/man/uuid_time.3.adoc
+++ b/libuuid/man/uuid_time.3.adoc
@@ -30,6 +30,8 @@ DAMAGE.
 
 Created  Wed Mar 10 17:42:12 1999, Andreas Dilger
 ////
+ifdef::neverdefined[---]
+
 = uuid_time(3)
 :doctype: manpage
 :man manual: Programmer's Manual
diff --git a/libuuid/man/uuid_unparse.3.adoc b/libuuid/man/uuid_unparse.3.adoc
index 20e8cfbab..13a8bec27 100644
--- a/libuuid/man/uuid_unparse.3.adoc
+++ b/libuuid/man/uuid_unparse.3.adoc
@@ -30,6 +30,8 @@ DAMAGE.
 
 Created  Wed Mar 10 17:42:12 1999, Andreas Dilger
 ////
+ifdef::neverdefined[---]
+
 = uuid_unparse(3)
 :doctype: manpage
 :man manual: Programmer's Manual
diff --git a/login-utils/chfn.1.adoc b/login-utils/chfn.1.adoc
index 527c6806c..94f95831b 100644
--- a/login-utils/chfn.1.adoc
+++ b/login-utils/chfn.1.adoc
@@ -7,6 +7,8 @@ This program is free software.  You can redistribute it and
 modify it under the terms of the GNU General Public License.
 There is no warranty.
 ////
+ifdef::neverdefined[---]
+
 = chfn(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/login-utils/chsh.1.adoc b/login-utils/chsh.1.adoc
index e259b593f..b28e1fbed 100644
--- a/login-utils/chsh.1.adoc
+++ b/login-utils/chsh.1.adoc
@@ -7,6 +7,8 @@ This program is free software.  You can redistribute it and
 modify it under the terms of the GNU General Public License.
 There is no warranty.
 ////
+ifdef::neverdefined[---]
+
 = chsh(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/login-utils/last.1.adoc b/login-utils/last.1.adoc
index adf82ae73..f3ee91c54 100644
--- a/login-utils/last.1.adoc
+++ b/login-utils/last.1.adoc
@@ -16,6 +16,8 @@ You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 ////
+ifdef::neverdefined[---]
+
 = last(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/login-utils/login.1.adoc b/login-utils/login.1.adoc
index 88c260688..2e49b7b8c 100644
--- a/login-utils/login.1.adoc
+++ b/login-utils/login.1.adoc
@@ -3,6 +3,8 @@
 Copyright 1993 Rickard E. Faith (faith@cs.unc.edu)
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = login(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/login-utils/lslogins.1.adoc b/login-utils/lslogins.1.adoc
index 7a344a7f4..1fa984768 100644
--- a/login-utils/lslogins.1.adoc
+++ b/login-utils/lslogins.1.adoc
@@ -1,6 +1,8 @@
 //po4a: entry man manual
 // Copyright 2014 Ondrej Oprala (ondrej.oprala@gmail.com)
 // May be distributed under the GNU General Public License
+ifdef::neverdefined[---]
+
 = lslogins(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/login-utils/newgrp.1.adoc b/login-utils/newgrp.1.adoc
index 0df01a3f7..046bb6bec 100644
--- a/login-utils/newgrp.1.adoc
+++ b/login-utils/newgrp.1.adoc
@@ -5,6 +5,8 @@
 //
 // Original author unknown.  This man page is in the public domain.
 // Modified Sat Oct  9 17:46:48 1993 by faith@cs.unc.edu
+ifdef::neverdefined[---]
+
 = newgrp(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/login-utils/sulogin.8.adoc b/login-utils/sulogin.8.adoc
index 3165d6195..db61ed4fb 100644
--- a/login-utils/sulogin.8.adoc
+++ b/login-utils/sulogin.8.adoc
@@ -17,6 +17,8 @@ You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 ////
+ifdef::neverdefined[---]
+
 = sulogin(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/login-utils/utmpdump.1.adoc b/login-utils/utmpdump.1.adoc
index a7672d3d4..8dd21f09c 100644
--- a/login-utils/utmpdump.1.adoc
+++ b/login-utils/utmpdump.1.adoc
@@ -16,6 +16,8 @@ You should have received a copy of the GNU General Public License
 along with this program; if not, write to the Free Software
 Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 ////
+ifdef::neverdefined[---]
+
 = utmpdump(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/login-utils/vipw.8.adoc b/login-utils/vipw.8.adoc
index 58acb9c4f..515252e6f 100644
--- a/login-utils/vipw.8.adoc
+++ b/login-utils/vipw.8.adoc
@@ -33,6 +33,8 @@ SUCH DAMAGE.
 
     @(#)vipw.8	6.7 (Berkeley) 3/16/91
 ////
+ifdef::neverdefined[---]
+
 = vipw(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/lsfd-cmd/lsfd.1.adoc b/lsfd-cmd/lsfd.1.adoc
index 9c4b8a0b5..2fa13b916 100644
--- a/lsfd-cmd/lsfd.1.adoc
+++ b/lsfd-cmd/lsfd.1.adoc
@@ -4,6 +4,8 @@ Copyright 2021 Red Hat, Inc.
 
 This file may be copied under the terms of the GNU General Public License.
 ////
+ifdef::neverdefined[---]
+
 = lsfd(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/misc-utils/blkid.8.adoc b/misc-utils/blkid.8.adoc
index 310ed3532..8ea98f07b 100644
--- a/misc-utils/blkid.8.adoc
+++ b/misc-utils/blkid.8.adoc
@@ -1,6 +1,8 @@
 //po4a: entry man manual
 // Copyright 2000 Andreas Dilger (adilger@turbolinux.com)
 // This file may be copied under the terms of the GNU General Public License.
+ifdef::neverdefined[---]
+
 = blkid(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/misc-utils/cal.1.adoc b/misc-utils/cal.1.adoc
index 43a9a3902..b4096ed15 100644
--- a/misc-utils/cal.1.adoc
+++ b/misc-utils/cal.1.adoc
@@ -36,6 +36,8 @@ SUCH DAMAGE.
 
     @(#)cal.1	8.1 (Berkeley) 6/6/93
 ////
+ifdef::neverdefined[---]
+
 = cal(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/misc-utils/fincore.1.adoc b/misc-utils/fincore.1.adoc
index 8403482d9..2d0ab248a 100644
--- a/misc-utils/fincore.1.adoc
+++ b/misc-utils/fincore.1.adoc
@@ -4,6 +4,8 @@ Copyright 2017 Red Hat, Inc.
 
 This file may be copied under the terms of the GNU General Public License.
 ////
+ifdef::neverdefined[---]
+
 = fincore(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/misc-utils/findfs.8.adoc b/misc-utils/findfs.8.adoc
index 5cc200305..8783cdc25 100644
--- a/misc-utils/findfs.8.adoc
+++ b/misc-utils/findfs.8.adoc
@@ -1,6 +1,8 @@
 //po4a: entry man manual
 // Copyright 1993, 1994, 1995 by Theodore Ts'o.  All Rights Reserved.
 // This file may be copied under the terms of the GNU General Public License.
+ifdef::neverdefined[---]
+
 = findfs(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/misc-utils/hardlink.1.adoc b/misc-utils/hardlink.1.adoc
index 5788014d2..613f7a1d4 100644
--- a/misc-utils/hardlink.1.adoc
+++ b/misc-utils/hardlink.1.adoc
@@ -5,6 +5,8 @@ SPDX-License-Identifier: MIT
 Copyright (C) 2008 - 2012 Julian Andres Klode. See hardlink.c for license.
 Copyright (C) 2021 Karel Zak <kzak@redhat.com>
 ////
+ifdef::neverdefined[---]
+
 = hardlink(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/misc-utils/kill.1.adoc b/misc-utils/kill.1.adoc
index 76027fb52..169f25866 100644
--- a/misc-utils/kill.1.adoc
+++ b/misc-utils/kill.1.adoc
@@ -4,6 +4,8 @@ Copyright 1994 Salvatore Valente (svalente@mit.edu)
 Copyright 1992 Rickard E. Faith (faith@cs.unc.edu)
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = kill(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/misc-utils/lastlog2.8.adoc b/misc-utils/lastlog2.8.adoc
index 4857cfdce..40602f247 100644
--- a/misc-utils/lastlog2.8.adoc
+++ b/misc-utils/lastlog2.8.adoc
@@ -3,6 +3,8 @@
 Copyright 2023 Thorsten Kukuk (kukuk@suse.de)
 This file may be copied under the terms of the GNU General Public License.
 ////
+ifdef::neverdefined[---]
+
 = lastlog2(8)
 :doctype: manpage
 :man manual: User Commands
diff --git a/misc-utils/logger.1.adoc b/misc-utils/logger.1.adoc
index e63f5eff8..f39d8cc70 100644
--- a/misc-utils/logger.1.adoc
+++ b/misc-utils/logger.1.adoc
@@ -33,6 +33,8 @@ SUCH DAMAGE.
 
 	@(#)logger.1	8.1 (Berkeley) 6/6/93
 ////
+ifdef::neverdefined[---]
+
 = logger(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/misc-utils/look.1.adoc b/misc-utils/look.1.adoc
index 0ef71ece3..bdc791929 100644
--- a/misc-utils/look.1.adoc
+++ b/misc-utils/look.1.adoc
@@ -33,6 +33,8 @@ SUCH DAMAGE.
 
     @(#)look.1	8.1 (Berkeley) 6/14/93
 ////
+ifdef::neverdefined[---]
+
 = look(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/misc-utils/lslocks.8.adoc b/misc-utils/lslocks.8.adoc
index 2395d86fb..743f275f3 100644
--- a/misc-utils/lslocks.8.adoc
+++ b/misc-utils/lslocks.8.adoc
@@ -9,6 +9,8 @@ Copyright 1994 Salvatore Valente (svalente@mit.edu)
 Copyright 1992 Rickard E. Faith (faith@cs.unc.edu)
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = lslocks(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/misc-utils/mcookie.1.adoc b/misc-utils/mcookie.1.adoc
index 9a77e4266..79a534b73 100644
--- a/misc-utils/mcookie.1.adoc
+++ b/misc-utils/mcookie.1.adoc
@@ -1,6 +1,8 @@
 //po4a: entry man manual
 // mcookie.1 --
 // Public Domain 1995 Rickard E. Faith (faith@cs.unc.edu)
+ifdef::neverdefined[---]
+
 = mcookie(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/misc-utils/rename.1.adoc b/misc-utils/rename.1.adoc
index 39b1496d5..b8ea2bfdf 100644
--- a/misc-utils/rename.1.adoc
+++ b/misc-utils/rename.1.adoc
@@ -5,6 +5,8 @@
 //
 // Written by Andries E. Brouwer (aeb@cwi.nl)
 // Placed in the public domain
+ifdef::neverdefined[---]
+
 = rename(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/misc-utils/uuidd.8.adoc b/misc-utils/uuidd.8.adoc
index f15d7b631..9658f0f41 100644
--- a/misc-utils/uuidd.8.adoc
+++ b/misc-utils/uuidd.8.adoc
@@ -3,6 +3,8 @@
 Copyright 2007 by Theodore Ts'o.  All Rights Reserved.
 This file may be copied under the terms of the GNU General Public License.
 ////
+ifdef::neverdefined[---]
+
 = uuidd(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/misc-utils/uuidgen.1.adoc b/misc-utils/uuidgen.1.adoc
index ce1d9e1a4..ac2db71fb 100644
--- a/misc-utils/uuidgen.1.adoc
+++ b/misc-utils/uuidgen.1.adoc
@@ -3,6 +3,8 @@
 Copyright 1999 Andreas Dilger (adilger@enel.ucalgary.ca)
 This file may be copied under the terms of the GNU General Public License.
 ////
+ifdef::neverdefined[---]
+
 = uuidgen(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/misc-utils/uuidparse.1.adoc b/misc-utils/uuidparse.1.adoc
index d517c1923..92a8d341d 100644
--- a/misc-utils/uuidparse.1.adoc
+++ b/misc-utils/uuidparse.1.adoc
@@ -1,6 +1,8 @@
 //po4a: entry man manual
 // Copyright (c) 2017 Sami Kerola
 // The 3-Clause BSD License
+ifdef::neverdefined[---]
+
 = uuidparse(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/misc-utils/whereis.1.adoc b/misc-utils/whereis.1.adoc
index 6a85e6c4c..e7ef4f7ce 100644
--- a/misc-utils/whereis.1.adoc
+++ b/misc-utils/whereis.1.adoc
@@ -33,6 +33,8 @@ SUCH DAMAGE.
 
 @(#)whereis.1 from UCB 4.2
 ////
+ifdef::neverdefined[---]
+
 = whereis(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/misc-utils/wipefs.8.adoc b/misc-utils/wipefs.8.adoc
index 7e75c7bba..4cf17745c 100644
--- a/misc-utils/wipefs.8.adoc
+++ b/misc-utils/wipefs.8.adoc
@@ -1,6 +1,8 @@
 //po4a: entry man manual
 // Copyright 2009 by Karel Zak.  All Rights Reserved.
 // This file may be copied under the terms of the GNU General Public License.
+ifdef::neverdefined[---]
+
 = wipefs(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/schedutils/chrt.1.adoc b/schedutils/chrt.1.adoc
index 4f610b839..3d3948050 100644
--- a/schedutils/chrt.1.adoc
+++ b/schedutils/chrt.1.adoc
@@ -23,6 +23,8 @@ You should have received a copy of the GNU General Public License along
 with this program; if not, write to the Free Software Foundation, Inc.,
 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 ////
+ifdef::neverdefined[---]
+
 = chrt(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/schedutils/coresched.1.adoc b/schedutils/coresched.1.adoc
index 0d4c211f8..997b6ab36 100644
--- a/schedutils/coresched.1.adoc
+++ b/schedutils/coresched.1.adoc
@@ -1,7 +1,5 @@
 //po4a: entry man manual
-////
-coresched(1) manpage
-////
+
 = coresched(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/schedutils/taskset.1.adoc b/schedutils/taskset.1.adoc
index 056b1ca30..8c4d84dcc 100644
--- a/schedutils/taskset.1.adoc
+++ b/schedutils/taskset.1.adoc
@@ -21,6 +21,8 @@ You should have received a copy of the GNU General Public License along
 with this program; if not, write to the Free Software Foundation, Inc.,
 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 ////
+ifdef::neverdefined[---]
+
 = taskset(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/schedutils/uclampset.1.adoc b/schedutils/uclampset.1.adoc
index b3cdb4e7f..fb48b2bf8 100644
--- a/schedutils/uclampset.1.adoc
+++ b/schedutils/uclampset.1.adoc
@@ -23,6 +23,8 @@ You should have received a copy of the GNU General Public License along
 with this program; if not, write to the Free Software Foundation, Inc.,
 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 ////
+ifdef::neverdefined[---]
+
 = uclampset(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/sys-utils/ctrlaltdel.8.adoc b/sys-utils/ctrlaltdel.8.adoc
index 57842400c..9548a329c 100644
--- a/sys-utils/ctrlaltdel.8.adoc
+++ b/sys-utils/ctrlaltdel.8.adoc
@@ -3,6 +3,8 @@
 Copyright 1992, 1993 Rickard E. Faith (faith@cs.unc.edu)
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = ctrlaltdel(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/sys-utils/dmesg.1.adoc b/sys-utils/dmesg.1.adoc
index 364c4aca4..24e79aa66 100644
--- a/sys-utils/dmesg.1.adoc
+++ b/sys-utils/dmesg.1.adoc
@@ -3,6 +3,8 @@
 Copyright 1993 Rickard E. Faith (faith@cs.unc.edu)
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = dmesg(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/sys-utils/eject.1.adoc b/sys-utils/eject.1.adoc
index 6db040729..8f6bafd56 100644
--- a/sys-utils/eject.1.adoc
+++ b/sys-utils/eject.1.adoc
@@ -7,6 +7,8 @@ It may be distributed under the GNU General Public License, version 2, or
 any higher version. See section COPYING of the GNU General Public license
 for conditions under which this file may be redistributed.
 ////
+ifdef::neverdefined[---]
+
 = eject(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/sys-utils/flock.1.adoc b/sys-utils/flock.1.adoc
index 247ab385f..1790f3f19 100644
--- a/sys-utils/flock.1.adoc
+++ b/sys-utils/flock.1.adoc
@@ -23,6 +23,8 @@ WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 ////
+ifdef::neverdefined[---]
+
 = flock(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/sys-utils/fstab.5.adoc b/sys-utils/fstab.5.adoc
index fb649d5f2..f5b4d0dcb 100644
--- a/sys-utils/fstab.5.adoc
+++ b/sys-utils/fstab.5.adoc
@@ -33,6 +33,8 @@ SUCH DAMAGE.
 
     @(#)fstab.5	6.5 (Berkeley) 5/10/91
 ////
+ifdef::neverdefined[---]
+
 = fstab(5)
 :doctype: manpage
 :man manual: File formats
diff --git a/sys-utils/hwclock.8.adoc b/sys-utils/hwclock.8.adoc
index 3ad02054f..145bd27af 100644
--- a/sys-utils/hwclock.8.adoc
+++ b/sys-utils/hwclock.8.adoc
@@ -6,6 +6,8 @@ hwclock.8 -- man page for util-linux' hwclock
    Authored new section: DATE-TIME CONFIGURATION.
    Subsections: Keeping Time..., LOCAL vs UTC, POSIX vs 'RIGHT'.
 ////
+ifdef::neverdefined[---]
+
 = hwclock(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/sys-utils/ipcmk.1.adoc b/sys-utils/ipcmk.1.adoc
index 11e333387..8e1ad2fe6 100644
--- a/sys-utils/ipcmk.1.adoc
+++ b/sys-utils/ipcmk.1.adoc
@@ -3,6 +3,8 @@
 Copyright 2008 Hayden A. James (hayden.james@gmail.com)
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = ipcmk(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/sys-utils/ipcrm.1.adoc b/sys-utils/ipcrm.1.adoc
index f4a8b4546..1f2960445 100644
--- a/sys-utils/ipcrm.1.adoc
+++ b/sys-utils/ipcrm.1.adoc
@@ -3,6 +3,8 @@
 Copyright 2002 Andre C. Mazzone (linuxdev@karagee.com)
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = ipcrm(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/sys-utils/ipcs.1.adoc b/sys-utils/ipcs.1.adoc
index 0234232b4..0853205f0 100644
--- a/sys-utils/ipcs.1.adoc
+++ b/sys-utils/ipcs.1.adoc
@@ -3,6 +3,8 @@
 Copyright 1993 Rickard E. Faith (faith@cs.unc.edu)
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = ipcs(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/sys-utils/ldattach.8.adoc b/sys-utils/ldattach.8.adoc
index 07549fb5a..6a51d672b 100644
--- a/sys-utils/ldattach.8.adoc
+++ b/sys-utils/ldattach.8.adoc
@@ -3,6 +3,8 @@
 Copyright 2008 Tilman Schmidt (tilman@imap.cc)
 May be distributed under the GNU General Public License version 2 or later
 ////
+ifdef::neverdefined[---]
+
 = ldattach(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/sys-utils/lsns.8.adoc b/sys-utils/lsns.8.adoc
index 3cbe3504e..49f0d5b95 100644
--- a/sys-utils/lsns.8.adoc
+++ b/sys-utils/lsns.8.adoc
@@ -4,6 +4,8 @@ Man page for the lsns command.
 Copyright 2015 Karel Zak <kzak@redhat.com>
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = lsns(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index f4f8669de..0e431004b 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -29,6 +29,8 @@ You should have received a copy of the GNU General Public License along
 with this program; if not, write to the Free Software Foundation, Inc.,
 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 ////
+ifdef::neverdefined[---]
+
 = mount(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/sys-utils/prlimit.1.adoc b/sys-utils/prlimit.1.adoc
index 4e839016d..fbfbc9f0a 100644
--- a/sys-utils/prlimit.1.adoc
+++ b/sys-utils/prlimit.1.adoc
@@ -4,6 +4,8 @@ prlimit.1 --
 Copyright 2011 Davidlohr Bueso <dave@gnu.org>
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = prlimit(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/sys-utils/renice.1.adoc b/sys-utils/renice.1.adoc
index 5f2e2a98d..6d24c3c1c 100644
--- a/sys-utils/renice.1.adoc
+++ b/sys-utils/renice.1.adoc
@@ -33,6 +33,8 @@ SUCH DAMAGE.
 
     @(#)renice.8	8.1 (Berkeley) 6/9/93
 ////
+ifdef::neverdefined[---]
+
 = renice(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/sys-utils/setpgid.1.adoc b/sys-utils/setpgid.1.adoc
index 493038d55..91cd9d00e 100644
--- a/sys-utils/setpgid.1.adoc
+++ b/sys-utils/setpgid.1.adoc
@@ -5,6 +5,8 @@
 //
 // Daan De Meyer <daan.j.demeyer@gmail.com>
 // In the public domain.
+ifdef::neverdefined[---]
+
 = setpgid(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/sys-utils/setsid.1.adoc b/sys-utils/setsid.1.adoc
index 5cf49a597..9f9f9081b 100644
--- a/sys-utils/setsid.1.adoc
+++ b/sys-utils/setsid.1.adoc
@@ -1,6 +1,8 @@
 //po4a: entry man manual
 // Rick Sladkey <jrs@world.std.com>
 // In the public domain.
+ifdef::neverdefined[---]
+
 = setsid(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/sys-utils/umount.8.adoc b/sys-utils/umount.8.adoc
index b9a3ff963..4f45dec7f 100644
--- a/sys-utils/umount.8.adoc
+++ b/sys-utils/umount.8.adoc
@@ -24,6 +24,8 @@ You should have received a copy of the GNU General Public License along
 with this program; if not, write to the Free Software Foundation, Inc.,
 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 ////
+ifdef::neverdefined[---]
+
 = umount(8)
 :doctype: manpage
 :man manual: System Administration
diff --git a/term-utils/mesg.1.adoc b/term-utils/mesg.1.adoc
index df9adfd38..38135a8db 100644
--- a/term-utils/mesg.1.adoc
+++ b/term-utils/mesg.1.adoc
@@ -33,6 +33,8 @@ SUCH DAMAGE.
 
 	@(#)mesg.1	8.1 (Berkeley) 6/6/93
 ////
+ifdef::neverdefined[---]
+
 = mesg(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/term-utils/script.1.adoc b/term-utils/script.1.adoc
index 7d9fa0eac..894115c5b 100644
--- a/term-utils/script.1.adoc
+++ b/term-utils/script.1.adoc
@@ -33,6 +33,8 @@ SUCH DAMAGE.
 
 	@(#)script.1	6.5 (Berkeley) 7/27/91
 ////
+ifdef::neverdefined[---]
+
 = script(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/term-utils/setterm.1.adoc b/term-utils/setterm.1.adoc
index 89e21532e..fa511bc46 100644
--- a/term-utils/setterm.1.adoc
+++ b/term-utils/setterm.1.adoc
@@ -6,6 +6,8 @@ Copyright 2000 Colin Watson (cjw44@cam.ac.uk)
 Do not restrict distribution.
 May be distributed under the GNU General Public License
 ////
+ifdef::neverdefined[---]
+
 = setterm(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/term-utils/wall.1.adoc b/term-utils/wall.1.adoc
index 441871d41..7c7936099 100644
--- a/term-utils/wall.1.adoc
+++ b/term-utils/wall.1.adoc
@@ -34,6 +34,8 @@ SUCH DAMAGE.
     @(#)wall.1	6.5 (Berkeley) 4/23/91
 
 ////
+ifdef::neverdefined[---]
+
 = wall(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/term-utils/write.1.adoc b/term-utils/write.1.adoc
index 22b537f2c..0a6a4717b 100644
--- a/term-utils/write.1.adoc
+++ b/term-utils/write.1.adoc
@@ -36,6 +36,8 @@ SUCH DAMAGE.
 
     @(#)write.1	8.1 (Berkeley) 6/6/93
 ////
+ifdef::neverdefined[---]
+
 = write(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/text-utils/bits.1.adoc b/text-utils/bits.1.adoc
index b444c087e..770ad363e 100644
--- a/text-utils/bits.1.adoc
+++ b/text-utils/bits.1.adoc
@@ -11,6 +11,8 @@ the Free Software Foundation; either version 2 of the License, or
 Copyright (c) 2024 Robin Jarry
 
 ////
+ifdef::neverdefined[---]
+
 = bits(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/text-utils/col.1.adoc b/text-utils/col.1.adoc
index bc1913a91..050332d58 100644
--- a/text-utils/col.1.adoc
+++ b/text-utils/col.1.adoc
@@ -36,6 +36,8 @@ SUCH DAMAGE.
 
     @(#)col.1	6.8 (Berkeley) 6/17/91
 ////
+ifdef::neverdefined[---]
+
 = col(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/text-utils/colcrt.1.adoc b/text-utils/colcrt.1.adoc
index dee315531..e3bab5f9a 100644
--- a/text-utils/colcrt.1.adoc
+++ b/text-utils/colcrt.1.adoc
@@ -33,6 +33,8 @@ SUCH DAMAGE.
 
     @(#)colcrt.1	8.1 (Berkeley) 6/30/93
 ////
+ifdef::neverdefined[---]
+
 = colcrt(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/text-utils/colrm.1.adoc b/text-utils/colrm.1.adoc
index 529133961..aa6f757cb 100644
--- a/text-utils/colrm.1.adoc
+++ b/text-utils/colrm.1.adoc
@@ -33,6 +33,8 @@ SUCH DAMAGE.
 
     @(#)colrm.1	6.6 (Berkeley) 3/14/91
 ////
+ifdef::neverdefined[---]
+
 = colrm(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/text-utils/column.1.adoc b/text-utils/column.1.adoc
index 97b7fec5b..73a8676d2 100644
--- a/text-utils/column.1.adoc
+++ b/text-utils/column.1.adoc
@@ -33,6 +33,8 @@ SUCH DAMAGE.
 
     @(#)column.1	8.1 (Berkeley) 6/6/93
 ////
+ifdef::neverdefined[---]
+
 = column(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/text-utils/hexdump.1.adoc b/text-utils/hexdump.1.adoc
index 33f889258..77ab798cf 100644
--- a/text-utils/hexdump.1.adoc
+++ b/text-utils/hexdump.1.adoc
@@ -33,6 +33,8 @@ SUCH DAMAGE.
 
 	@(#)hexdump.1	8.2 (Berkeley) 4/18/94
 ////
+ifdef::neverdefined[---]
+
 = hexdump(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/text-utils/line.1.adoc b/text-utils/line.1.adoc
index ecbc08817..05613ce62 100644
--- a/text-utils/line.1.adoc
+++ b/text-utils/line.1.adoc
@@ -4,6 +4,8 @@
 // it what you wish.
 //
 // This page is in the public domain
+ifdef::neverdefined[---]
+
 = line(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/text-utils/more.1.adoc b/text-utils/more.1.adoc
index aad95e008..d40b79bae 100644
--- a/text-utils/more.1.adoc
+++ b/text-utils/more.1.adoc
@@ -36,6 +36,8 @@ SUCH DAMAGE.
 
 Copyright (c) 1992 Rik Faith (faith@cs.unc.edu)
 ////
+ifdef::neverdefined[---]
+
 = more(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/text-utils/pg.1.adoc b/text-utils/pg.1.adoc
index 62b456e9a..3f4058956 100644
--- a/text-utils/pg.1.adoc
+++ b/text-utils/pg.1.adoc
@@ -1,5 +1,7 @@
 //po4a: entry man manual
 // Copyright 2001 Gunnar Ritter
+ifdef::neverdefined[---]
+
 = pg(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/text-utils/rev.1.adoc b/text-utils/rev.1.adoc
index 1cf375c27..d7b2002df 100644
--- a/text-utils/rev.1.adoc
+++ b/text-utils/rev.1.adoc
@@ -33,6 +33,8 @@ SUCH DAMAGE.
 
 	@(#)rev.1	6.3 (Berkeley) 3/21/92
 ////
+ifdef::neverdefined[---]
+
 = rev(1)
 :doctype: manpage
 :man manual: User Commands
diff --git a/text-utils/ul.1.adoc b/text-utils/ul.1.adoc
index bc19e61d7..626ced162 100644
--- a/text-utils/ul.1.adoc
+++ b/text-utils/ul.1.adoc
@@ -33,6 +33,8 @@ SUCH DAMAGE.
 
     @(#)ul.1	8.1 (Berkeley) 6/6/93
 ////
+ifdef::neverdefined[---]
+
 = ul(1)
 :doctype: manpage
 :man manual: User Commands
-- 
2.48.1

