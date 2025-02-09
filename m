Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E0C6FBF
	for <util-linux@vger.kernel.org>; Sun,  9 Feb 2025 08:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739089451; cv=none; b=XBIDQRFZYs8rbdn/KXgt9FM7Y4053okV6SrHYL20z64FYeDwWbqk/YTHGbOjThdUpDqnuGAez9tbXt5hlL2RAIRRczO1DXrW1/lfMTXyaWYQBUVGM5N49tERyz8enavlgj7rad+nn7w/hAq+wWInPDtACFetRO2HDUg4JYHNsQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739089451; c=relaxed/simple;
	bh=YpADxoDRmuf3dmp80Svuy29yOqMLOJ7zuEGsoBC3TQQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgS+xL4K1gNLCSo/qkkKKHu1cLifZqLBBRL9IfdrVwxHriT0Y0QUv1VqK67ld+//1q2s7IM4rWicqHDCn1N6NEiSw3sWDUk6yseAKeVAj09VJx46d8aRaHsFWqHqkZCK5Akk7GegLO0wsjIBeempyX5elB+1N179cMEdVKvwKyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=ti0+Bl7s; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="ti0+Bl7s"
X-KPN-MessageId: 95658201-e6bf-11ef-a841-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 95658201-e6bf-11ef-a841-005056ab378f;
	Sun, 09 Feb 2025 09:26:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=6dAflY1L9fGic+4vQhZ54pluKgEzPnIucGEsj0qE48g=;
	b=ti0+Bl7sr+kJ8zPWHMfwBAmWt/KtmkIrzAxu2AzNm1GFUDOZNafyu3lKnJljvU30B21vAW+JbY5Ky
	 JTMZN61QCjUMlx83w/lQlXk8WDbEuSZBracs/Usn+1LgE/Lw+TsR5FvfUNu0Q6DWNLNn//Fs8KHjg/
	 AJTgD0BWJIKoeKSM=
X-KPN-MID: 33|fAEZKrepGpijW4F8/zwiDVADP6FTtNDXH1R1Pziu8CyUEONOjrpdk8dnIcXU9SN
 FZm51egUoZ2g1z9wu4w5DMw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|G7HzsiM7iaItfoWgrR4rnZaom3EbtID9TRshofV9tq4jWRCjWvPenYkMb6U/bc9
 km6ADHkkx0HXtkWDV++CbPg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 3997533d-e6bf-11ef-a31b-005056abf0db;
	Sun, 09 Feb 2025 09:24:05 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 03/14] unshare: use single asterisks around long options, double around values
Date: Sun,  9 Feb 2025 09:23:19 +0100
Message-ID: <20250209082330.4235-3-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209082330.4235-1-bensberg@telfort.nl>
References: <20250209082330.4235-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/unshare.1.adoc | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sys-utils/unshare.1.adoc b/sys-utils/unshare.1.adoc
index db2c07ab2..c6973f938 100644
--- a/sys-utils/unshare.1.adoc
+++ b/sys-utils/unshare.1.adoc
@@ -93,26 +93,26 @@ Just before running the program, mount the proc filesystem at _mountpoint_ (defa
 *--mount-binfmt*[**=**__mountpoint__]::
 Just before running the program, mount the binfmt_misc filesystem at _mountpoint_ (default is /proc/sys/fs/binfmt_misc).  It also implies creating a new mount namespace since the binfmt_misc mount would otherwise mess up existing programs on the system.  The new binfmt_misc filesystem is explicitly mounted as private (with *MS_PRIVATE*|*MS_REC*).
 
-**--map-user** __uid|name__::
+*--map-user* __uid|name__::
 Run the program only after the current effective user ID has been mapped to _uid_. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--user*.
 
-**--map-users** __inneruid:outeruid:count__|**auto**|**all**::
+*--map-users* __inneruid:outeruid:count__|**auto**|**all**::
 Run the program only after the block of user IDs of size _count_ beginning at _outeruid_ has been mapped to the block of user IDs beginning at _inneruid_. This mapping is created with **newuidmap**(1) if *unshare* was run unprivileged. If the range of user IDs overlaps with the mapping specified by *--map-user*, then a "hole" will be removed from the mapping. This may result in the highest user ID of the mapping not being mapped. Use *--map-users* multiple times to map more than one block of user IDs. The special value *auto* will map the first block of user IDs owned by the effective user from _/etc/subuid_ to a block starting at user ID 0. The special value *subids* will identity map the same block. The special value *all* will create a pass-through map for every user ID available in the parent namespace. This option implies *--user*.
 +
 Before util-linux version 2.39, this option expected a comma-separated argument of the form _outeruid,inneruid,count_ but that format is now deprecated for consistency with the ordering used in _/proc/[pid]/uid_map_ and the _X-mount.idmap_ mount option.
 
-**--map-group** __gid|name__::
+*--map-group* __gid|name__::
 Run the program only after the current effective group ID has been mapped to _gid_. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--setgroups=deny* and *--user*.
 
-**--map-groups** __innergid:outergid:count__|**auto**|**all**::
+*--map-groups* __innergid:outergid:count__|**auto**|**all**::
 Run the program only after the block of group IDs of size _count_ beginning at _outergid_ has been mapped to the block of group IDs beginning at _innergid_. This mapping is created with **newgidmap**(1) if *unshare* was run unprivileged. If the range of group IDs overlaps with the mapping specified by *--map-group*, then a "hole" will be removed from the mapping. This may result in the highest group ID of the mapping not being mapped. Use *--map-groups* multiple times to map more than one block of group IDs. The special value *auto* will map the first block of user IDs owned by the effective user from _/etc/subgid_ to a block starting at group ID 0. The special value *subids* will identity map the same block. The special value *all* will create a pass-through map for every group ID available in the parent namespace. This option implies *--user*.
 +
 Before util-linux version 2.39, this option expected a comma-separated argument of the form _outergid,innergid,count_ but that format is now deprecated for consistency with the ordering used in _/proc/[pid]/gid_map_ and the _X-mount.idmap_ mount option.
 
-**--map-auto**::
+*--map-auto*::
 Map the first block of user IDs owned by the effective user from _/etc/subuid_ to a block starting at user ID 0. In the same manner, also map the first block of group IDs owned by the effective group from _/etc/subgid_ to a block starting at group ID 0. This option is intended to handle the common case where the first block of subordinate user and group IDs can map the whole user and group ID space. This option is equivalent to specifying *--map-users=auto* and *--map-groups=auto*.
 
-**--map-subids**::
+*--map-subids*::
 Identity map the first block of user IDs owned by the effective user from _/etc/subuid_. In the same manner, also identity map the first block of group IDs owned by the effective group from _/etc/subgid_. This option is equivalent to specifying *--map-users=subids* and *--map-groups=subids*.
 
 *-r*, *--map-root-user*::
@@ -121,18 +121,18 @@ Run the program only after the current effective user and group IDs have been ma
 *-c*, *--map-current-user*::
 Run the program only after the current effective user and group IDs have been mapped to the same UID and GID in the newly created user namespace. This option implies *--setgroups=deny* and *--user*. This option is equivalent to *--map-user=$(id -ru) --map-group=$(id -rg)*.
 
-**--propagation private**|**shared**|**slave**|*unchanged*::
+*--propagation* **private**|**shared**|**slave**|**unchanged**::
 Recursively set the mount propagation flag in the new mount namespace. The default is to set the propagation to _private_. It is possible to disable this feature with the argument *unchanged*. The option is silently ignored when the mount namespace (*--mount*) is not requested.
 
-**--setgroups allow**|*deny*::
+*--setgroups* **allow**|**deny**::
 Allow or deny the *setgroups*(2) system call in a user namespace.
 +
 To be able to call *setgroups*(2), the calling process must at least have *CAP_SETGID*. But since Linux 3.19 a further restriction applies: the kernel gives permission to call *setgroups*(2) only after the GID map (**/proc/**__pid__*/gid_map*) has been set. The GID map is writable by root when *setgroups*(2) is enabled (i.e., *allow*, the default), and the GID map becomes writable by unprivileged processes when *setgroups*(2) is permanently disabled (with *deny*).
 
-*-R*, **--root** __dir__::
+*-R*, *--root* __dir__::
 run the command with root directory set to _dir_.
 
-*-w*, **--wd** __dir__::
+*-w*, *--wd* __dir__::
 change working directory to _dir_.
 
 *-S*, *--setuid* _uid_::
@@ -141,9 +141,9 @@ Set the user ID which will be used in the entered namespace.
 *-G*, *--setgid* _gid_::
 Set the group ID which will be used in the entered namespace and drop supplementary groups.
 
-*-l*, **--load-interp** __string__::
+*-l*, *--load-interp* __string__::
 Load binfmt_misc definition in the namespace (implies *--mount-binfmt*). The __string__ argument is ``:name:type:offset:magic:mask:interpreter:flags``. For more details about new binary type registration see  https://www.kernel.org/doc/Documentation/admin-guide/binfmt-misc.rst.
-To manage the F flag in ``flags`` with **--root** parameter, binfmt_misc is mounted twice, once before the chroot to load the interpreter from the caller filesystem and once after to make it available from the chroot userspace.
+To manage the F flag in ``flags`` with *--root* parameter, binfmt_misc is mounted twice, once before the chroot to load the interpreter from the caller filesystem and once after to make it available from the chroot userspace.
 
 *--monotonic* _offset_::
 Set the offset of *CLOCK_MONOTONIC* which will be used in the entered time namespace. This option requires unsharing a time namespace with *--time*.
-- 
2.48.1

