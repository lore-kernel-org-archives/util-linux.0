Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2927F1F8758
	for <util-linux@vger.kernel.org>; Mon,  7 Apr 2025 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038971; cv=none; b=m6kQtUcLsbGUTA8Te18opfeL6H8ML73L3aF0fFzP/Vh3tYQcaRMeC4mMdT839kwcSNR1Mfxcw+I2DJfPkBIsMCCzjJq0NFFRXdCmh1ahDX0OUaIbejmklEYPN4zU+UgHcYX5W+JifqhHoObXEn8xHhS2nUQz+mUxKTSFBJVQex4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038971; c=relaxed/simple;
	bh=zkiHJZxG/u1+wn/8uts0B9J93zhzCZ4h3i9JifonMys=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzu+XB1ar17CoMvt3tWqiFPr4IYEvioexC/ZvxXDXiF1fY5vjLZIKAyw/poAdBiPSBl4QT8LkS5ZmD6YiJpYz7p1bry1wy/0pXyFOSSWr4NV3KG2s6YGtLHAnj9N77uTv3PBh7CuNVu9M1Y0JccqxmTQFkq78rinwNQbBbUmoBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=WKzIvyPc; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="WKzIvyPc"
X-KPN-MessageId: 4fb0e4bc-13c3-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4fb0e4bc-13c3-11f0-86cb-005056aba152;
	Mon, 07 Apr 2025 17:16:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=ny5IRBdU7LviYfEtEOjPXXNpoyKL8M5CPECfo7oLhrI=;
	b=WKzIvyPcDXwCWOxPYNP9DNQvCpTHZMVSEZfX7n2qOdhf1HhOJ2EEw142BJ79pcE671bfnvm4q3MPQ
	 ij5Y7JDMQ/uZgXdgvdLMaBnts7GE6eG0FxTq33qfnedm+a31n3681MGA7KjkDTbQ/OuK/Z0KWuiqiC
	 WuIONnoFV1xxXYWc=
X-KPN-MID: 33|UfATCsvdaH21VMnTDUxRhfFuklX+k1lhFSNmrDkqfYJf5SXivXwPBpx6tpK2Nob
 lnlBCDXLya6abO9HZ99bEmg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ZNjNeWQYsi39/aWumBV7n6eg7FsdbOX3aaPKeFx15eOjxo6iW8RWMciAl0XoJdR
 zyUndw97DK8Sgtg81bH79Kg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 3abc12f2-13c3-11f0-9b62-005056ab1411;
	Mon, 07 Apr 2025 17:16:07 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 7/8] mount: (man) shorten an overlong line, and improve some markup
Date: Mon,  7 Apr 2025 17:14:38 +0200
Message-ID: <20250407151503.23394-7-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407151503.23394-1-bensberg@telfort.nl>
References: <20250407151503.23394-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also, in the synopis mention -F separately to make it more obvious that
it applies only to -A, swap two options to make a line more similar to
the preceding one, and improve some wording.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/mount.8.adoc | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index f4a704556..bb4151225 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -47,15 +47,16 @@ mount - mount a filesystem
 
 *mount* [*-l*] [*-t* _fstype_]
 
-*mount* *-a* [*-fFnrsvw*] [*-t* _fstype_] [*-O* _optlist_]
+*mount* *-a* [*-F*] [*-fnrsvw*] [*-t* _fstype_] [*-O* _optlist_]
 
 *mount* [*-fnrsvw*] [*-o* _options_] _device_|_mountpoint_
 
-*mount* [*-fnrsvw*] [*-t* _fstype_] [*-o* _options_] _device mountpoint_
+*mount* [*-fnrsvw*] [*-o* _options_] [*-t* _fstype_] _device mountpoint_
 
 *mount* *--bind*|*--rbind*|*--move* _olddir newdir_
 
-*mount* *--make-*[*shared*|*slave*|*private*|*unbindable*|*rshared*|*rslave*|*rprivate*|*runbindable*] _mountpoint_
+*mount* *--make-*[*r*]{*shared*|*slave*|*private*|*unbindable*} _mountpoint_
+
 
 == DESCRIPTION
 
@@ -765,8 +766,8 @@ Note that *mount*(8) still sanitizes and canonicalizes the source and target pat
 *X-mount.noloop*::
 Do not create and mount a loop device, even if the source of the mount is a regular file.
 
-*X-mount.subdir=*__directory__::
-Allow mounting sub-directory from a filesystem instead of the root directory. For now, this feature is implemented by temporary filesystem root directory mount in unshared namespace and then bind the sub-directory to the final mount point and umount the root of the filesystem. The sub-directory mount shows up atomically for the rest of the system although it is implemented by multiple *mount*(2) syscalls.
+**X-mount.subdir=**_directory_::
+Allow mounting a sub-directory of a filesystem instead of the root directory. For now, this feature is implemented by a temporary filesystem root-directory mount in an unshared namespace and then binding the sub-directory to the final mount point and unmounting the root of the filesystem. The sub-directory mount shows up atomically for the rest of the system although it is implemented by multiple *mount*(2) syscalls.
 +
 Note that this feature will not work in session with an unshared private mount namespace (after *unshare --mount*) on old kernels or with *mount*(8) without support for file-descriptors-based mount kernel API. In this case, you need *unshare --mount --propagation shared*.
 +
@@ -1513,7 +1514,7 @@ Set behavior on error:
 *panic*;;
 If an error is encountered, cause a kernel panic.
 
-[**lock**|**umount**|*repair*];;
+**lock**|**umount**|*repair*;;
 These mount options don't do anything at present; when an error is encountered only a console message is printed.
 
 === Mount options for umsdos
@@ -1590,7 +1591,7 @@ Parity bytes for FEC (default: 2). Optional.
 **verity.roothashsig=**__path__::
 Path to *pkcs7*(1ssl) signature of root hash hex string. Requires crypt_activate_by_signed_key() from cryptsetup and kernel built with *CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG*. For device reuse, signatures have to be either used by all mounts of a device or by none. Optional.
 
-**verity.oncorruption=**__ignore__|__restart__|__panic__::
+**verity.oncorruption=**{*ignore*|*restart*|*panic*}::
 Instruct the kernel to ignore, reboot or panic when corruption is detected. By default the I/O operation simply fails. Requires Linux 4.1 or newer, and libcrypsetup 2.3.4 or newer. Optional.
 +
 Supported since util-linux v2.35.
-- 
2.48.1

