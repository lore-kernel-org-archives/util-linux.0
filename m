Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79472192B89
	for <util-linux@vger.kernel.org>; Mon,  7 Apr 2025 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038960; cv=none; b=RUjMLhE6fRSYnBjgo7bSBybbSzpx95in+cngcMYvPG8Wy9enhmRCaksNM82zjjo88SnpsIcfJLZOclgIKOhBvtbaZSwAA3JpD/1HDq+BP3UXljFjfJ4aGp+smUi5ua6IHVJLy/c/oCQt0cb8dg9wDPrOQXHuP/FBs95KfcC3x/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038960; c=relaxed/simple;
	bh=FcGr15833sUy7qevcd5QekhunUgYPGtw+h3kc2pee/Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p91wvjWeITfq8RuR/A+N0R5eACpehA8aaGV7HakkA/w4tvCFlr1yJsk+3skAAyxHAWHUL8ht01WnW8/n/sTmxHVD+SaezchE0gCThmK/jFliMwNQSVL0Nenl5j1DEM83/gGlOJBH+Ugx+lfgsyYGG5PrjHV6G3NWVTM+LO4sYqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=Jsvnv+m7; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="Jsvnv+m7"
X-KPN-MessageId: 5447559f-13c3-11f0-b9a0-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 5447559f-13c3-11f0-b9a0-005056abbe64;
	Mon, 07 Apr 2025 17:16:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:mime-version:message-id:date:subject:to:from;
	bh=KE9qNGynq0W4hZDADXg3votcLtQNM5L3J/FY2x9N0Qg=;
	b=Jsvnv+m7mx/pfCX4EeJV5EH5U1aoVrwQHStf4497G2ARuIKsgl4kyAK+bu2nsPFnpRWml9qPA2yi7
	 N5ZCBaAfZ0IQoJ0eI4RmqgDC5G5jsYfVBlTJs64tzuSuNBPVJDYkzOsxRA6CMjkNtQ2V8QBzkO2ASB
	 onMJ/bR/hyyQxiOI=
X-KPN-MID: 33|CtOch1rLiPZd4Zh7NY+ok/YyWEphShFVh+C4rGvzG8s1Iifx2mhuNxJF4A5Sy7B
 S1dGyY/OWl6mlKJ2kqCXwlWqh7PYiR54bcH+uAE7azTI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|twP2JTCC+ciH0hQzv4UFq+YsDRoKz6FPqqTIfaYDtradYcCMh4MU9oGbtMw26+L
 5HotQuJuuAk/ZO7i2u4M2Iw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 33cc071b-13c3-11f0-9b62-005056ab1411;
	Mon, 07 Apr 2025 17:15:56 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/8] mount: (man) fix some indentation issues, and improve a few wordings
Date: Mon,  7 Apr 2025 17:14:37 +0200
Message-ID: <20250407151503.23394-6-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407151503.23394-1-bensberg@telfort.nl>
References: <20250407151503.23394-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/mount.8.adoc | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index 5103b91c5..f4a704556 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -567,6 +567,7 @@ mount -t tmpfs none /mnt -o \
 ....
 ____
 
++
 For more details, see *selinux*(8).
 
 *defaults*::
@@ -746,6 +747,7 @@ and xfs.
 Note that comma is used as a separator between mount options, it means
 that auto-fstypes values have to be properly quoted, don’t forget that the shell
 strips off quotes and thus double quoting is required. For example:
++
 ____
 mount -t auto -o'X-mount.auto-fstypes="noext2,ext3"'  /dev/sdc1 /mnt/test
 ____
@@ -933,17 +935,23 @@ Set the umask applied to directories only. The default is the umask of the curre
 Set the umask applied to regular files only. The default is the umask of the current process. The value is given in octal.
 
 **allow_utime=**__value__::
-This option controls the permission check of mtime/atime.
+This option controls the permission check of mtime/atime.  Possible values:
 
 *20*;;
-If current process is in group of file's group ID, you can change timestamp.
-
+If the current process is in the group of the file's group ID,
+you can change the timestamp.
++
 *2*;;
-Other users can change timestamp.
+Other users can change the timestamp.
 
-The default is set from 'dmask' option. (If the directory is writable, *utime*(2) is also allowed. I.e. ~dmask & 022)
-
-Normally *utime*(2) checks that the current process is owner of the file, or that it has the *CAP_FOWNER* capability. But FAT filesystems don't have UID/GID on disk, so the normal check is too inflexible. With this option you can relax it.
++
+The default is set from the above *dmask* option. (If the directory
+is writable, *utime*(2) is also allowed.  That is: ~dmask & 022.)
+ +
+Normally *utime*(2) checks that the current process is the owner of the
+file, or that it has the *CAP_FOWNER* capability. But FAT filesystems
+don't have UID/GID on disk, so the normal check is too inflexible.
+With this option you can relax it.
 
 **check=**__value__::
 Three different levels of pickiness can be chosen:
@@ -1584,11 +1592,11 @@ Path to *pkcs7*(1ssl) signature of root hash hex string. Requires crypt_activate
 
 **verity.oncorruption=**__ignore__|__restart__|__panic__::
 Instruct the kernel to ignore, reboot or panic when corruption is detected. By default the I/O operation simply fails. Requires Linux 4.1 or newer, and libcrypsetup 2.3.4 or newer. Optional.
-
++
 Supported since util-linux v2.35.
-
-For example commands:
-
++
+For example, the commands:
++
 ....
 mksquashfs /etc /tmp/etc.raw
 veritysetup format /tmp/etc.raw /tmp/etc.verity --root-hash-file=/tmp/etc.roothash
@@ -1598,6 +1606,7 @@ mount -o verity.hashdevice=/tmp/etc.verity,verity.roothashfile=/tmp/etc.roothash
 verity.roothashsig=/tmp/etc.roothash.p7s /tmp/etc.raw /mnt
 ....
 
++
 create squashfs image from _/etc_ directory, verity hash device and mount verified filesystem image to _/mnt_. The kernel will verify that the root hash is signed by a key from the kernel keyring if roothashsig is used.
 
 == LOOP-DEVICE SUPPORT
-- 
2.48.1

