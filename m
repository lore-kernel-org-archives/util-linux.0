Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782892E3390
	for <util-linux@vger.kernel.org>; Mon, 31 Mar 2025 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414341; cv=none; b=kAXXmutV/B2PxCkHnVH9fO1ekUBECs5TFmwerRGspdT+a/3CnUu1Ey54/4F2RzOJ7o+j0mXNkOk1p102KBlOERcV1fyvtFOLBY+e2+7rw4aN6oe2bgN8pqopkVIPYdYQG0XD7pCZtZKkZgbk/IgdzH/pz0jABY3HAYMeYvSHePs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414341; c=relaxed/simple;
	bh=bkf7ABBIUdZxB04rjhnwFLzLUsIg7bu5NcrtByh9W6E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNYiEG/Anxq234MpZtQYj4A78Vs+El6dwJSUM1Ej/A3Bpqh+xIWFodnTsX2WHiP+Hr3MjkCAEmfOCtZtJzwddFxGPwFZ6HcZZgzSfB+FUNMNadvmxyCTLVfTvdUDk6iHIW0SsuYmvE7nQKxGspTZodfMzrH8uwxbJSwQgn2Zq34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=Z5pEVIbB; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="Z5pEVIbB"
X-KPN-MessageId: f2661656-0e14-11f0-a82d-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f2661656-0e14-11f0-a82d-005056abad63;
	Mon, 31 Mar 2025 11:45:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=dhzykks/zIKbqbjsqlOBVOjkMQ4yHtR9ZsihorQAQ1s=;
	b=Z5pEVIbBbVZc7CZnSl1yWVc+SNlo6lldXSNCiAUtCAV4GwP+k8QLjR7TqGrnTCc49N5+vc6D/5cl7
	 06aUL8zex2KQ3D6efG1RWInPHBVKCtWXT7aPhJqQfgHhcoK0AQpMJbeki+Kd0q1GOcySxLeSjFHp9F
	 2vG5/k76X4N4HlR4=
X-KPN-MID: 33|hu7Lfj6DaHKFJgRHaMXAH/iuzsoUEgurjI8rxvjZ+zfDwq+q7S6IyT6CS/CZ49V
 ohq7zydx302nszA6mE1qaXD5vM6xQ09oP7azHoI60Dg4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|N4Tn8rrdgdNEeAX6AXHExd7KeLyaK+jNRUC4+N+pndo/Tpw0fWbTficvE6m4vjN
 38rVUIIUx4DQ5hfZFS/hPUg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id e2d36dfa-0e14-11f0-9bef-005056ab7447;
	Mon, 31 Mar 2025 11:45:31 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 06/10] findmnt: (man) remove duplicated option, and correct a description
Date: Mon, 31 Mar 2025 11:44:39 +0200
Message-ID: <20250331094443.9619-6-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331094443.9619-1-bensberg@telfort.nl>
References: <20250331094443.9619-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The page listed both '--shadowed' and '--shadow', while the description
of '--hyperlink' duplicated the possible values of the _mode_ argument
and mistakenly spoke of _when_.

Also, sort the options alphabetically and fix two bits of markup.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/findmnt.8.adoc | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/misc-utils/findmnt.8.adoc b/misc-utils/findmnt.8.adoc
index fe29afe77..8a679153b 100644
--- a/misc-utils/findmnt.8.adoc
+++ b/misc-utils/findmnt.8.adoc
@@ -57,9 +57,6 @@ The search direction, either *forward* or *backward*.
 *-e*, *--evaluate*::
 Convert all tags (LABEL, UUID, PARTUUID, or PARTLABEL) to the corresponding device names for the SOURCE column.  It's an unusual situation, but the same tag may be duplicated (used for more devices). For this purpose, there is SOURCES (pl.) column. This column displays by multi-line cell all devices where the tag is detected by libblkid. This option makes sense for _fstab_ only.
 
-*--hyperlink*[**=**_mode_]::
-Print mountpoint paths as terminal hyperlinks. The _mode_ can be set to "always", "never", or "auto". The optional argument _when_ can be set to "auto", "never", or "always". If the _when_ argument is omitted, it will default to "auto". The "auto" setting means that hyperlinks will only be used if the output is on a terminal.
-
 *-F*, *--tab-file* _path_::
 Search in an alternative file. If used with *--fstab*, *--mtab* or *--kernel*, then it overrides the default paths. If specified more than once, then tree-like output is disabled (see the *--list* option).
 
@@ -69,6 +66,12 @@ Print the first matching filesystem only.
 *-H*, *--list-columns*::
 List the available columns, use with *--json* or *--raw* to get output in machine-readable format.
 
+*--hyperlink*[**=**_mode_]::
+Print mountpoint paths as terminal hyperlinks. The optional _mode_ argument
+can be *always*, *never*, or *auto*. If the argument is omitted, it defaults
+to *auto*, which means that hyperlinks will only be used when the output goes
+to a terminal.
+
 *-I*, *--dfi*::
 Imitate the output of *df*(1) with its *-i* option. This option is equivalent to *-o SOURCE,FSTYPE,INO.TOTAL,INO.USED,INO.AVAIL,INO.USE%,TARGET* but excludes all pseudo filesystems. Use *--all* to print all filesystems.
 
@@ -84,7 +87,7 @@ Select a filesystem using the mount node 64-bit ID, use with *--kernel=listmount
 *-J*, *--json*::
 Use JSON output format.
 
-*-k*, *--kernel*[_=method_]::
+*-k*, *--kernel*[**=**_method_]::
 Reads information about filesystems from the kernel. This is the default output. The format is tree-like and only includes mount options managed by the kernel (see also *--mtab*).
 +
 The optional argument _method_ can be either:
@@ -126,7 +129,7 @@ Produce output in the form of key="value" pairs. All potentially unsafe value ch
 +
 Note that SOURCES column, use multi-line cells. In these cases, the column use an array-like formatting in the output, for example *name=("aaa" "bbb" "ccc")*.
 
-*-p*, *--poll*[_=list_]::
+*-p*, *--poll*[**=**_list_]::
 Monitor changes in the _/proc/self/mountinfo_ file. Supported actions are: mount, umount, remount and move. More than one action may be specified in a comma-separated list. All actions are monitored by default.
 +
 The time for which *--poll* will block can be restricted with the *--timeout* or *--first-only* options.
@@ -143,9 +146,6 @@ available for umount and remount actions
 *--pseudo*::
 Print only pseudo filesystems.
 
-*--shadow*::
-Print only filesystems over-mounted by another filesystem.
-
 *-Q*, *--filter* _expr_::
 Print only the filesystems that meet the conditions specified by the expr.
 +
@@ -172,6 +172,9 @@ Explicitly define the mount source. Supported specifications are _device_, __maj
 *-s*, *--fstab*::
 Search in _/etc/fstab_. The output is in the list format (see *--list*).
 
+*--shadowed*::
+Print only filesystems that are over-mounted by another filesystem.
+
 *-T*, *--target* _path_::
 Define the mount target. If _path_ is not a mountpoint file or directory, then *findmnt* checks the _path_ elements in reverse order to get the mountpoint (this feature is supported only when searching in kernel files and unsupported for *--fstab*). It's recommended to use the option *--mountpoint* when checks of _path_ elements are unwanted and _path_ is a strictly specified mountpoint.
 
@@ -181,9 +184,6 @@ Limit the set of printed filesystems. More than one type may be specified in a c
 *--tree*::
 Enable tree-like output if possible. The options is silently ignored for tables where is missing child-parent relation (e.g., _fstab_).
 
-*--shadowed*::
-Print only filesystems over-mounted by another filesystem.
-
 *-U*, *--uniq*::
 Ignore filesystems with duplicate mount targets, thus effectively skipping over-mounted mount points.
 
@@ -193,18 +193,18 @@ Do not truncate text in columns. The default is to not truncate the *TARGET*, *S
 *-v*, *--nofsroot*::
 Do not print a [/dir] in the SOURCE column for bind mounts or btrfs subvolumes.
 
-*-w*, *--timeout* _milliseconds_::
-Specify an upper limit on the time for which *--poll* will block, in milliseconds.
-
-*-x*, *--verify*::
-Check mount table content. The default is to verify _/etc/fstab_ parsability and usability. It's possible to use this option also with *--tab-file*. It's possible to specify source (device) or target (mountpoint) to filter mount table. The option *--verbose* forces *findmnt* to print more details.
-
 *--verbose*::
 Force *findmnt* to print more information (*--verify* only for now).
 
 *--vfs-all*::
 When used with *VFS-OPTIONS* column, print all VFS (fs-independent) flags. This option is designed for auditing purposes to list also default VFS kernel mount options which are normally not listed.
 
+*-w*, *--timeout* _milliseconds_::
+Specify an upper limit on the time for which *--poll* will block, in milliseconds.
+
+*-x*, *--verify*::
+Check mount table content. The default is to verify _/etc/fstab_ parsability and usability. It's possible to use this option also with *--tab-file*. It's possible to specify source (device) or target (mountpoint) to filter mount table. The option *--verbose* forces *findmnt* to print more details.
+
 *-y*, *--shell*::
 The column name will be modified to contain only characters allowed for shell variable identifiers. This is usable, for example, with *--pairs*. Note that this feature has been automatically enabled for *--pairs* in version 2.37, but due to compatibility issues, now it's necessary to request this behavior by *--shell*.
 
-- 
2.48.1

