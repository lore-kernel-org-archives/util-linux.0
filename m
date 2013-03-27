Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f182.google.com ([209.85.212.182]:41072 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682Ab3C0WIa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Mar 2013 18:08:30 -0400
Received: by mail-wi0-f182.google.com with SMTP id hi18so2703696wib.15
        for <util-linux@vger.kernel.org>; Wed, 27 Mar 2013 15:08:29 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/10] bash-completion: add completion files to Makefile.am
Date: Wed, 27 Mar 2013 22:07:52 +0000
Message-Id: <1364422072-23552-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
References: <1364422072-23552-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And remove shell completion TODO item.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/TODO             |   6 -
 shell-completion/Makemodule.am | 261 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 260 insertions(+), 7 deletions(-)

diff --git a/Documentation/TODO b/Documentation/TODO
index b4139d3..4adf05d 100644
--- a/Documentation/TODO
+++ b/Documentation/TODO
@@ -8,12 +8,6 @@ hwlock
  - the /var/lib/hwclock/drift should be implemented backwardly compatible,
    it means use the file only if exists, otherwise follow /etc/adjtime 
 
-bash completion
----------------
- - file per command in shel-completion/bash/
- - use $(pkg-config --variable=completionsdir bash-completion)/util-linux/
-   as a destination install directory
-
 wipefs
 ------
  - generate /root/wipefs-<devname>-<offset>.bak with wiped bytes, so after 
diff --git a/shell-completion/Makemodule.am b/shell-completion/Makemodule.am
index b784ec7..0bb8652 100644
--- a/shell-completion/Makemodule.am
+++ b/shell-completion/Makemodule.am
@@ -1 +1,260 @@
-dist_bashcompletion_DATA =
+dist_bashcompletion_DATA = \
+	shell-completion/blkid \
+	shell-completion/cal \
+	shell-completion/col \
+	shell-completion/colcrt \
+	shell-completion/colrm \
+	shell-completion/column \
+	shell-completion/findmnt \
+	shell-completion/flock \
+	shell-completion/fsck.minix \
+	shell-completion/getopt \
+	shell-completion/hexdump \
+	shell-completion/ipcrm \
+	shell-completion/ipcs \
+	shell-completion/isosize \
+	shell-completion/logger \
+	shell-completion/look \
+	shell-completion/mcookie \
+	shell-completion/mkfs \
+	shell-completion/mkfs.bfs \
+	shell-completion/mkfs.minix \
+	shell-completion/mkswap \
+	shell-completion/namei \
+	shell-completion/prlimit \
+	shell-completion/readprofile \
+	shell-completion/renice \
+	shell-completion/rev \
+	shell-completion/script \
+	shell-completion/scriptreplay \
+	shell-completion/setsid \
+	shell-completion/tailf \
+	shell-completion/wall \
+	shell-completion/whereis \
+	shell-completion/wipefs
+
+# disk-utils...
+if BUILD_CRAMFS
+dist_bashcompletion_DATA += \
+	shell-completion/fsck.cramfs \
+	shell-completion/mkfs.cramfs
+endif
+if BUILD_FSCK
+dist_bashcompletion_DATA += \
+	shell-completion/fsck
+endif
+if BUILD_PARTX
+dist_bashcompletion_DATA += \
+	shell-completion/addpart \
+	shell-completion/delpart \
+	shell-completion/resizepart \
+	shell-completion/partx
+endif
+if BUILD_RAW
+dist_bashcompletion_DATA += \
+	shell-completion/raw
+endif
+if BUILD_SWAPLABEL
+dist_bashcompletion_DATA += \
+	shell-completion/swaplabel
+endif
+if LINUX
+dist_bashcompletion_DATA += \
+	shell-completion/blockdev \
+	shell-completion/fdformat
+endif
+# ...disk-utils
+
+# fdisks...
+if !ARCH_M68K
+dist_bashcompletion_DATA += \
+	shell-completion/fdisk
+if !ARCH_SPARC
+dist_bashcompletion_DATA += \
+	shell-completion/sfdisk
+if BUILD_CFDISK
+dist_bashcompletion_DATA += \
+	shell-completion/cfdisk
+endif
+endif # !ARCH_SPARC
+endif # !ARCH_M68
+# ...fdisks
+
+# login-utils...
+if BUILD_CHFN_CHSH
+dist_bashcompletion_DATA += \
+	shell-completion/chfn \
+	shell-completion/chsh
+endif
+if BUILD_LAST
+dist_bashcompletion_DATA += \
+	shell-completion/last
+endif
+if BUILD_LOGIN
+dist_bashcompletion_DATA += \
+	shell-completion/login
+endif
+if BUILD_NEWGRP
+dist_bashcompletion_DATA += \
+	shell-completion/newgrp
+endif
+if BUILD_SU
+dist_bashcompletion_DATA += \
+	shell-completion/su
+endif
+if BUILD_SULOGIN
+dist_bashcompletion_DATA += \
+	shell-completion/sulogin
+endif
+if BUILD_UTMPDUMP
+dist_bashcompletion_DATA += \
+	shell-completion/utmpdump
+endif
+# ...login-utils
+
+# misc-utils...
+if BUILD_LIBUUID
+dist_bashcompletion_DATA += \
+	shell-completion/uuidgen
+endif
+if BUILD_UUIDD
+dist_bashcompletion_DATA += \
+	shell-completion/uuidd
+endif
+if BUILD_LSBLK
+dist_bashcompletion_DATA += \
+	shell-completion/lsblk
+endif
+if BUILD_LSLOCKS
+dist_bashcompletion_DATA += \
+	shell-completion/lslocks
+endif
+if BUILD_RENAME
+dist_bashcompletion_DATA += \
+	shell-completion/rename
+endif
+# ...misc-utils
+
+# schedutils...
+if BUILD_SCHEDUTILS
+dist_bashcompletion_DATA += \
+	shell-completion/chrt
+if BUILD_IONICE
+dist_bashcompletion_DATA += \
+	shell-completion/ionice
+endif
+if BUILD_TASKSET
+dist_bashcompletion_DATA += \
+	shell-completion/taskset
+endif
+endif # BUILD_SCHEDUTILS
+# ...schedutils
+
+# sys-utils...
+if BUILD_CHCPU
+dist_bashcompletion_DATA += \
+	shell-completion/chcpu
+endif
+if BUILD_EJECT
+dist_bashcompletion_DATA += \
+	shell-completion/eject
+endif
+if BUILD_FALLOCATE
+dist_bashcompletion_DATA += \
+	shell-completion/fallocate
+endif
+if BUILD_HWCLOCK
+dist_bashcompletion_DATA += \
+	shell-completion/hwclock
+endif
+if BUILD_TUNELP
+dist_bashcompletion_DATA += \
+	shell-completion/tunelp
+endif
+if BUILD_LSCPU
+dist_bashcompletion_DATA += \
+	shell-completion/lscpu
+endif
+if BUILD_LOSETUP
+dist_bashcompletion_DATA += \
+	shell-completion/losetup
+endif
+if BUILD_MOUNTPOINT
+dist_bashcompletion_DATA += \
+	shell-completion/mountpoint
+endif
+if BUILD_NSENTER
+dist_bashcompletion_DATA += \
+	shell-completion/nsenter
+endif
+if BUILD_PIVOT_ROOT
+dist_bashcompletion_DATA += \
+	shell-completion/pivot_root
+endif
+if BUILD_SETPRIV
+dist_bashcompletion_DATA += \
+	shell-completion/setpriv
+endif
+if BUILD_SWAPON
+dist_bashcompletion_DATA += \
+	shell-completion/swapon
+endif
+if BUILD_UNSHARE
+dist_bashcompletion_DATA += \
+	shell-completion/unshare
+endif
+if BUILD_WDCTL
+dist_bashcompletion_DATA += \
+	shell-completion/wdctl
+endif
+if LINUX
+dist_bashcompletion_DATA += \
+	shell-completion/blkdiscard \
+	shell-completion/ctrlaltdel \
+	shell-completion/cytune \
+	shell-completion/dmesg \
+	shell-completion/fsfreeze \
+	shell-completion/fstrim \
+	shell-completion/ldattach \
+	shell-completion/rtcwake \
+	shell-completion/setarch
+endif
+# ...sys-utils
+
+# term-utils...
+if BUILD_AGETTY
+dist_bashcompletion_DATA += \
+	shell-completion/agetty
+endif
+if BUILD_MESG
+dist_bashcompletion_DATA += \
+	shell-completion/mesg
+endif
+if BUILD_WALL
+dist_bashcompletion_DATA += \
+	shell-completion/wall
+endif
+if BUILD_WRITE
+dist_bashcompletion_DATA += \
+	shell-completion/write
+endif
+if LINUX
+dist_bashcompletion_DATA += \
+	shell-completion/setterm
+endif
+# ...term-utils
+
+# text-utils...
+if BUILD_MORE
+dist_bashcompletion_DATA += \
+	shell-completion/more
+endif
+if BUILD_PG
+dist_bashcompletion_DATA += \
+	shell-completion/pg
+endif
+if BUILD_UL
+dist_bashcompletion_DATA += \
+	shell-completion/ul
+endif
+# ...text-utils
-- 
1.8.2

