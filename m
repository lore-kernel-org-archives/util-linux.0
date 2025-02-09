Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71856FBF
	for <util-linux@vger.kernel.org>; Sun,  9 Feb 2025 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739089504; cv=none; b=BOMA2nI9mhTIPGXWtX3wvYQxhlkZqkplT4stKBXnfUHBPvjCOTv1JwxHG8VcHcoJ50ih7Hm4/k0ENg+7zLntO22BrZXOxYODqZVo9cHiN8dUfg23LpzxdGn/8HfqmCVW9KGtzc7772DnxA7NN+Bm+7Gk/6xaPJT8kmlLrZEiRRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739089504; c=relaxed/simple;
	bh=do8IgI0bnFYD1u0v/+ibJnJ3ZEz26+5X9DyOgLSCUlo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N85vC42+U9VelvM3gnW4+3JSfyJ2brDpsadiu0L0H20gIvsnwQEOAJbv2BsYLQqyhFdP1luFX7f4Ww72wP6K8A1RWfeGHEaq0ZZX6R9UYcROCo+uEjDMykZnBgzU2BroJraZtGKMvo4XkrKj2hUhnrS36nCwi0V/hwBOrscIOLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=CEMcHlbW; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="CEMcHlbW"
X-KPN-MessageId: 8edf215c-e6bf-11ef-a841-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8edf215c-e6bf-11ef-a841-005056ab378f;
	Sun, 09 Feb 2025 09:26:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=0ViLYyO3jo3YLLFaXtfcUMbcuNu7UhR5yMmGOHDxHmw=;
	b=CEMcHlbWKJCfH76kuWlbw47YwdmPrklHUu1y7bstUac8LM3ZSAYdzjFBTSRYRsTnpfqBuNjR6o2Ks
	 +5hlT/F/OnTlRZp1ipi7UjST450d/jG/xqcPAOw0iWBKabqqGBpGLGueTvBAJxmYbjuzXYUJNKOS0q
	 rs4OC66+ESTQeaLM=
X-KPN-MID: 33|u5u0hQrMJqfNZfiE1MCkIS4XgChl2JkqskEKWMaf31XgbV7l1V5AWC+NUiu5nCG
 UK7qZETaJtHgDPyQvaj2+TbuI5bfXRhn4k5cd8Z7L1nw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|ylRg2TuAVjmPJMSd4UkR3e+zLXMQ1bOZ79+78Hn+qSv5EKlmoTjYOGjLk33OH/n
 o18zs+ODHQQh0Yc66JfTWsQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 3314e8ab-e6bf-11ef-99a4-005056ab7447;
	Sun, 09 Feb 2025 09:23:54 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 02/14] unshare: don't use "=" before a required option argument
Date: Sun,  9 Feb 2025 09:23:18 +0100
Message-ID: <20250209082330.4235-2-bensberg@telfort.nl>
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

The "=" is not needed, is inconsistent with the presentation of the
other options that require an argument, and trying to use "=" with
the equivalent short option would lead to failure.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/unshare.1.adoc | 14 +++++++-------
 sys-utils/unshare.c      | 12 ++++++------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/sys-utils/unshare.1.adoc b/sys-utils/unshare.1.adoc
index 5c2b268b1..db2c07ab2 100644
--- a/sys-utils/unshare.1.adoc
+++ b/sys-utils/unshare.1.adoc
@@ -93,18 +93,18 @@ Just before running the program, mount the proc filesystem at _mountpoint_ (defa
 *--mount-binfmt*[**=**__mountpoint__]::
 Just before running the program, mount the binfmt_misc filesystem at _mountpoint_ (default is /proc/sys/fs/binfmt_misc).  It also implies creating a new mount namespace since the binfmt_misc mount would otherwise mess up existing programs on the system.  The new binfmt_misc filesystem is explicitly mounted as private (with *MS_PRIVATE*|*MS_REC*).
 
-**--map-user=**__uid|name__::
+**--map-user** __uid|name__::
 Run the program only after the current effective user ID has been mapped to _uid_. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--user*.
 
-**--map-users=**__inneruid:outeruid:count__|**auto**|**all**::
+**--map-users** __inneruid:outeruid:count__|**auto**|**all**::
 Run the program only after the block of user IDs of size _count_ beginning at _outeruid_ has been mapped to the block of user IDs beginning at _inneruid_. This mapping is created with **newuidmap**(1) if *unshare* was run unprivileged. If the range of user IDs overlaps with the mapping specified by *--map-user*, then a "hole" will be removed from the mapping. This may result in the highest user ID of the mapping not being mapped. Use *--map-users* multiple times to map more than one block of user IDs. The special value *auto* will map the first block of user IDs owned by the effective user from _/etc/subuid_ to a block starting at user ID 0. The special value *subids* will identity map the same block. The special value *all* will create a pass-through map for every user ID available in the parent namespace. This option implies *--user*.
 +
 Before util-linux version 2.39, this option expected a comma-separated argument of the form _outeruid,inneruid,count_ but that format is now deprecated for consistency with the ordering used in _/proc/[pid]/uid_map_ and the _X-mount.idmap_ mount option.
 
-**--map-group=**__gid|name__::
+**--map-group** __gid|name__::
 Run the program only after the current effective group ID has been mapped to _gid_. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--setgroups=deny* and *--user*.
 
-**--map-groups=**__innergid:outergid:count__|**auto**|**all**::
+**--map-groups** __innergid:outergid:count__|**auto**|**all**::
 Run the program only after the block of group IDs of size _count_ beginning at _outergid_ has been mapped to the block of group IDs beginning at _innergid_. This mapping is created with **newgidmap**(1) if *unshare* was run unprivileged. If the range of group IDs overlaps with the mapping specified by *--map-group*, then a "hole" will be removed from the mapping. This may result in the highest group ID of the mapping not being mapped. Use *--map-groups* multiple times to map more than one block of group IDs. The special value *auto* will map the first block of user IDs owned by the effective user from _/etc/subgid_ to a block starting at group ID 0. The special value *subids* will identity map the same block. The special value *all* will create a pass-through map for every group ID available in the parent namespace. This option implies *--user*.
 +
 Before util-linux version 2.39, this option expected a comma-separated argument of the form _outergid,innergid,count_ but that format is now deprecated for consistency with the ordering used in _/proc/[pid]/gid_map_ and the _X-mount.idmap_ mount option.
@@ -129,10 +129,10 @@ Allow or deny the *setgroups*(2) system call in a user namespace.
 +
 To be able to call *setgroups*(2), the calling process must at least have *CAP_SETGID*. But since Linux 3.19 a further restriction applies: the kernel gives permission to call *setgroups*(2) only after the GID map (**/proc/**__pid__*/gid_map*) has been set. The GID map is writable by root when *setgroups*(2) is enabled (i.e., *allow*, the default), and the GID map becomes writable by unprivileged processes when *setgroups*(2) is permanently disabled (with *deny*).
 
-*-R*, **--root=**__dir__::
+*-R*, **--root** __dir__::
 run the command with root directory set to _dir_.
 
-*-w*, **--wd=**__dir__::
+*-w*, **--wd** __dir__::
 change working directory to _dir_.
 
 *-S*, *--setuid* _uid_::
@@ -141,7 +141,7 @@ Set the user ID which will be used in the entered namespace.
 *-G*, *--setgid* _gid_::
 Set the group ID which will be used in the entered namespace and drop supplementary groups.
 
-*-l*, **--load-interp=**__string__::
+*-l*, **--load-interp** __string__::
 Load binfmt_misc definition in the namespace (implies *--mount-binfmt*). The __string__ argument is ``:name:type:offset:magic:mask:interpreter:flags``. For more details about new binary type registration see  https://www.kernel.org/doc/Documentation/admin-guide/binfmt-misc.rst.
 To manage the F flag in ``flags`` with **--root** parameter, binfmt_misc is mounted twice, once before the chroot to load the interpreter from the caller filesystem and once after to make it available from the chroot userspace.
 
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 9263606c3..9b87acd67 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -782,14 +782,14 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -T, --time[=<file>]       unshare time namespace\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_(" -f, --fork                fork before launching <program>\n"), out);
-	fputs(_(" --map-user=<uid>|<name>   map current user to uid (implies --user)\n"), out);
-	fputs(_(" --map-group=<gid>|<name>  map current group to gid (implies --user)\n"), out);
+	fputs(_(" --map-user <uid>|<name>   map current user to uid (implies --user)\n"), out);
+	fputs(_(" --map-group <gid>|<name>  map current group to gid (implies --user)\n"), out);
 	fputs(_(" -r, --map-root-user       map current user to root (implies --user)\n"), out);
 	fputs(_(" -c, --map-current-user    map current user to itself (implies --user)\n"), out);
 	fputs(_(" --map-auto                map users and groups automatically (implies --user)\n"), out);
-	fputs(_(" --map-users=<inneruid>:<outeruid>:<count>\n"
+	fputs(_(" --map-users <inneruid>:<outeruid>:<count>\n"
 		"                           map count users from outeruid to inneruid (implies --user)\n"), out);
-	fputs(_(" --map-groups=<innergid>:<outergid>:<count>\n"
+	fputs(_(" --map-groups <innergid>:<outergid>:<count>\n"
 		"                           map count groups from outergid to innergid (implies --user)\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_(" --kill-child[=<signame>]  when dying, kill the forked child (implies --fork)\n"
@@ -801,8 +801,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" --setgroups allow|deny    control the setgroups syscall in user namespaces\n"), out);
 	fputs(_(" --keep-caps               retain capabilities granted in user namespaces\n"), out);
 	fputs(USAGE_SEPARATOR, out);
-	fputs(_(" -R, --root=<dir>          run the command with root directory set to <dir>\n"), out);
-	fputs(_(" -w, --wd=<dir>            change working directory to <dir>\n"), out);
+	fputs(_(" -R, --root <dir>          run the command with root directory set to <dir>\n"), out);
+	fputs(_(" -w, --wd <dir>            change working directory to <dir>\n"), out);
 	fputs(_(" -S, --setuid <uid>        set uid in entered namespace\n"), out);
 	fputs(_(" -G, --setgid <gid>        set gid in entered namespace\n"), out);
 	fputs(_(" --monotonic <offset>      set clock monotonic offset (seconds) in time namespaces\n"), out);
-- 
2.48.1

