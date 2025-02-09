Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB441DA3D
	for <util-linux@vger.kernel.org>; Sun,  9 Feb 2025 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739089503; cv=none; b=FDu4ieJrjOCfCslG3oi3o2fwI387ygpKGnyFiJjNE3TaIzg2f467mjrsXbLPLJazo1W2QfZf3F7YXyR5VA+M16GmsfpZwmvyNS4QiFFOk/IwsKPDRDbenHICXW2U1ccKuSIjU4p8lhLUvsNv7XNWeChh3H52I92gbSOoucTadio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739089503; c=relaxed/simple;
	bh=/snqCWpD+ELZn8oFaxZOPAiTG+4oc91rz1HMIGL9XWI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NcScUMKQeO4aqzEUz34C5OA5jSQbHyzJ4W+RcjvxUaJYFGH0iQDlOWMnvW0/1/5VPSl0mfJsUk3lwhDddJp4iOHbyfTIZEr2rtGOvVkOiXsILY3j52ya3zehtbUT0yUlDZ2UzXNXR8jpZLDnEHzPZU5/dbcOj1U3ZMpX8z6b1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=gwZjR5GS; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="gwZjR5GS"
X-KPN-MessageId: 9b0aa66f-e6bf-11ef-aff5-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9b0aa66f-e6bf-11ef-aff5-005056abad63;
	Sun, 09 Feb 2025 09:26:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=IPJdq1sgI6NzmS+zSqP7LG/afMarXbLOfegYgDqeGKk=;
	b=gwZjR5GS9JH5GpkVEPTAD3mEzdyZVYCFxJEshh7DUIzTZu2rNqZJxx5D4fxQhImtnxUdXx4UEpmN9
	 rIAbdLx9HzVwkNGVB+WLl6AXWcHhV9prVQSrvct2qP/6EsPhGB6RGPAe9x3lxHHjEPZnkWg3WyB8wp
	 eV0lo7HpYPuYmw+A=
X-KPN-MID: 33|IzSa1uwmdTznAOqw+Ac6zNZFuEOGSzlPlaWGiaFNy90KMFXw90jxP+ksjYKS1lj
 QPV0IwEU407IflX+t52yKBTM9WNykpDgzWfROoGC7JhA=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|iWDUGwp9QNzyPYS4Bsbi1UORFGLt/dlcUljbZysbd+szifwKQW98iFqwi3X5OI2
 cyPp5OoKdfvfzk1ny8ncoxg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 5a331bcf-e6bf-11ef-99a4-005056ab7447;
	Sun, 09 Feb 2025 09:24:59 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 07/14] unshare: don't mark "|" and ":" as part of the placeholders
Date: Sun,  9 Feb 2025 09:23:23 +0100
Message-ID: <20250209082330.4235-7-bensberg@telfort.nl>
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

The "|" is a meta-character, and should thus be left unmarked, while
the ":" (in the argument of --map-users/--map-groups) is a literal,
and should therefore be marked in bold.

Also, add the new 'subids' literal value for the above two options.

And in the bargain tweak a comment.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/unshare.1.adoc | 12 ++++++------
 sys-utils/unshare.c      |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sys-utils/unshare.1.adoc b/sys-utils/unshare.1.adoc
index c6973f938..2bcc193ff 100644
--- a/sys-utils/unshare.1.adoc
+++ b/sys-utils/unshare.1.adoc
@@ -93,21 +93,21 @@ Just before running the program, mount the proc filesystem at _mountpoint_ (defa
 *--mount-binfmt*[**=**__mountpoint__]::
 Just before running the program, mount the binfmt_misc filesystem at _mountpoint_ (default is /proc/sys/fs/binfmt_misc).  It also implies creating a new mount namespace since the binfmt_misc mount would otherwise mess up existing programs on the system.  The new binfmt_misc filesystem is explicitly mounted as private (with *MS_PRIVATE*|*MS_REC*).
 
-*--map-user* __uid|name__::
+*--map-user* __uid__|__name__::
 Run the program only after the current effective user ID has been mapped to _uid_. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--user*.
 
-*--map-users* __inneruid:outeruid:count__|**auto**|**all**::
+*--map-users* __inneruid__**:**__outeruid__**:**__count__|**auto**|**subids**|**all**::
 Run the program only after the block of user IDs of size _count_ beginning at _outeruid_ has been mapped to the block of user IDs beginning at _inneruid_. This mapping is created with **newuidmap**(1) if *unshare* was run unprivileged. If the range of user IDs overlaps with the mapping specified by *--map-user*, then a "hole" will be removed from the mapping. This may result in the highest user ID of the mapping not being mapped. Use *--map-users* multiple times to map more than one block of user IDs. The special value *auto* will map the first block of user IDs owned by the effective user from _/etc/subuid_ to a block starting at user ID 0. The special value *subids* will identity map the same block. The special value *all* will create a pass-through map for every user ID available in the parent namespace. This option implies *--user*.
 +
-Before util-linux version 2.39, this option expected a comma-separated argument of the form _outeruid,inneruid,count_ but that format is now deprecated for consistency with the ordering used in _/proc/[pid]/uid_map_ and the _X-mount.idmap_ mount option.
+Before util-linux version 2.39, this option expected a comma-separated argument of the form _outeruid_**,**_inneruid_**,**_count_ but that format is now deprecated for consistency with the ordering used in _/proc/[pid]/uid_map_ and the _X-mount.idmap_ mount option.
 
-*--map-group* __gid|name__::
+*--map-group* __gid__|__name__::
 Run the program only after the current effective group ID has been mapped to _gid_. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--setgroups=deny* and *--user*.
 
-*--map-groups* __innergid:outergid:count__|**auto**|**all**::
+*--map-groups* __innergid__**:**__outergid__**:**__count__|**auto**|**subids**|**all**::
 Run the program only after the block of group IDs of size _count_ beginning at _outergid_ has been mapped to the block of group IDs beginning at _innergid_. This mapping is created with **newgidmap**(1) if *unshare* was run unprivileged. If the range of group IDs overlaps with the mapping specified by *--map-group*, then a "hole" will be removed from the mapping. This may result in the highest group ID of the mapping not being mapped. Use *--map-groups* multiple times to map more than one block of group IDs. The special value *auto* will map the first block of user IDs owned by the effective user from _/etc/subgid_ to a block starting at group ID 0. The special value *subids* will identity map the same block. The special value *all* will create a pass-through map for every group ID available in the parent namespace. This option implies *--user*.
 +
-Before util-linux version 2.39, this option expected a comma-separated argument of the form _outergid,innergid,count_ but that format is now deprecated for consistency with the ordering used in _/proc/[pid]/gid_map_ and the _X-mount.idmap_ mount option.
+Before util-linux version 2.39, this option expected a comma-separated argument of the form _outergid_**,**_innergid_**,**_count_ but that format is now deprecated for consistency with the ordering used in _/proc/[pid]/gid_map_ and the _X-mount.idmap_ mount option.
 
 *--map-auto*::
 Map the first block of user IDs owned by the effective user from _/etc/subuid_ to a block starting at user ID 0. In the same manner, also map the first block of group IDs owned by the effective group from _/etc/subgid_ to a block starting at group ID 0. This option is intended to handle the common case where the first block of subordinate user and group IDs can map the whole user and group ID space. This option is equivalent to specifying *--map-users=auto* and *--map-groups=auto*.
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 9b87acd67..4d078e4d5 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -413,7 +413,7 @@ static struct map_range get_map_range(const char *s)
  * @filename: The file to look up the range from. This should be either
  *            ``/etc/subuid`` or ``/etc/subgid``.
  * @uid: The uid of the user whose range we should look up.
- * @identity: (boolean) If true identity map the range, otherwise map to 0
+ * @identity: (boolean) If true, identity map the range, otherwise map to 0.
  *
  * This finds the first subid range matching @uid in @filename.
  */
-- 
2.48.1

