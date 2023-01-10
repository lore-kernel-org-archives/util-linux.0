Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA36BC63797
	for <util-linux@archiver.kernel.org>; Tue, 10 Jan 2023 13:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjAJN7p (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238851AbjAJN7C (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 10 Jan 2023 08:59:02 -0500
Received: from cdw.me.uk (cdw.me.uk [91.203.57.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEE38FAD0
        for <util-linux@vger.kernel.org>; Tue, 10 Jan 2023 05:58:59 -0800 (PST)
Received: from chris by delta.arachsys.com with local (Exim 4.80)
        (envelope-from <chris@arachsys.com>)
        id 1pFF9W-0002g2-D9
        for util-linux@vger.kernel.org; Tue, 10 Jan 2023 13:58:58 +0000
Date:   Tue, 10 Jan 2023 13:58:58 +0000
From:   Chris Webb <chris@arachsys.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH v2] unshare: support --map-users=inner:outer:count as well as
 outer,inner,count
Message-ID: <Y71vIkgFde7Zp9AI@arachsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The argument ordering in /proc/self/[gu]id_map and mount -o X-mount.idmap
is consistently inner:outer:count but unshare --map-users and --map-groups
were originally defined to expect outer,inner,count instead.

To reduce confusion caused by this mismatch, support a colon-separated
inner:outer:count ordering as well as the original comma-separated
outer,inner,count argument format. Although we accept both formats, only
document the new one in the usage text and deprecate the old format in
the man page.

Fixes: https://github.com/util-linux/util-linux/issues/1988
Signed-off-by: Chris Webb <chris@arachsys.com>
---
v2: Describe deprecation in the unshare(1) man page.

 sys-utils/unshare.1.adoc |  8 +++++--
 sys-utils/unshare.c      | 50 +++++++++++++---------------------------
 2 files changed, 22 insertions(+), 36 deletions(-)

diff --git a/sys-utils/unshare.1.adoc b/sys-utils/unshare.1.adoc
index 030e9a497..08e13373c 100644
--- a/sys-utils/unshare.1.adoc
+++ b/sys-utils/unshare.1.adoc
@@ -93,14 +93,18 @@ Just before running the program, mount the proc filesystem at _mountpoint_ (defa
 **--map-user=**__uid|name__::
 Run the program only after the current effective user ID has been mapped to _uid_. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--user*.
 
-**--map-users=**__outeruid,inneruid,count__|**auto**::
+**--map-users=**__inneruid:outeruid:count__|**auto**::
 Run the program only after the block of user IDs of size _count_ beginning at _outeruid_ has been mapped to the block of user IDs beginning at _inneruid_. This mapping is created with **newuidmap**(1). If the range of user IDs overlaps with the mapping specified by *--map-user*, then a "hole" will be removed from the mapping. This may result in the highest user ID of the mapping not being mapped. The special value *auto* will map the first block of user IDs owned by the effective user from _/etc/subuid_ to a block starting at user ID 0. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--user*.
++
+Before util-linux version 2.39, this option expected a comma-separated argument of the form _outeruid,inneruid,count_ but that format is now deprecated for consistency with the ordering used in _/proc/[pid]/uid_map_ and the _X-mount.idmap_ mount option.
 
 **--map-group=**__gid|name__::
 Run the program only after the current effective group ID has been mapped to _gid_. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--setgroups=deny* and *--user*.
 
-**--map-groups=**__outergid,innergid,count__|**auto**::
+**--map-groups=**__innergid:outergid:count__|**auto**::
 Run the program only after the block of group IDs of size _count_ beginning at _outergid_ has been mapped to the block of group IDs beginning at _innergid_. This mapping is created with **newgidmap**(1). If the range of group IDs overlaps with the mapping specified by *--map-group*, then a "hole" will be removed from the mapping. This may result in the highest group ID of the mapping not being mapped. The special value *auto* will map the first block of user IDs owned by the effective user from _/etc/subgid_ to a block starting at group ID 0. If this option is specified multiple times, the last occurrence takes precedence. This option implies *--user*.
++
+Before util-linux version 2.39, this option expected a comma-separated argument of the form _outergid,innergid,count_ but that format is now deprecated for consistency with the ordering used in _/proc/[pid]/gid_map_ and the _X-mount.idmap_ mount option.
 
 **--map-auto**::
 Map the first block of user IDs owned by the effective user from _/etc/subuid_ to a block starting at user ID 0. In the same manner, also map the first block of group IDs owned by the effective group from _/etc/subgid_ to a block starting at group ID 0. This option is intended to handle the common case where the first block of subordinate user and group IDs can map the whole user and group ID space. This option is equivalent to specifying *--map-users=auto* and *--map-groups=auto*.
diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 8313ee0a7..2aa239eff 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -375,49 +375,31 @@ struct map_range {
 
 #define UID_BUFSIZ  sizeof(stringify_value(ULONG_MAX))
 
-/**
- * uint_to_id() - Convert a string into a user/group ID
- * @name: The string representation of the ID
- * @sz: The length of @name, without an (optional) nul-terminator
- *
- * This converts a (possibly not nul-terminated_ string into user or group ID.
- * No name lookup is performed.
- *
- * Return: @name as a numeric ID
- */
-static int uint_to_id(const char *name, size_t sz)
-{
-	char buf[UID_BUFSIZ];
-
-	mem2strcpy(buf, name, sz, sizeof(buf));
-	return strtoul_or_err(buf, _("could not parse ID"));
-}
-
 /**
  * get_map_range() - Parse a mapping range from a string
- * @s: A string of the format outer,inner,count
+ * @s: A string of the format inner:outer:count or outer,inner,count
  *
- * Parse a string of the form outer,inner,count into a new mapping range.
+ * Parse a string of the form inner:outer:count or outer,inner,count into
+ * a new mapping range.
  *
  * Return: A new &struct map_range
  */
 static struct map_range *get_map_range(const char *s)
 {
-	int n, map[3];
+	int end;
 	struct map_range *ret;
 
-	n = string_to_idarray(s, map, ARRAY_SIZE(map), uint_to_id);
-	if (n < 0)
-		errx(EXIT_FAILURE, _("too many elements for mapping '%s'"), s);
-	if (n != ARRAY_SIZE(map))
-		errx(EXIT_FAILURE, _("mapping '%s' contains only %d elements"),
-		     s, n);
-
 	ret = xmalloc(sizeof(*ret));
-	ret->outer = map[0];
-	ret->inner = map[1];
-	ret->count = map[2];
-	return ret;
+
+	if (sscanf(s, "%u:%u:%u%n", &ret->inner, &ret->outer, &ret->count,
+		   &end) >= 3 && !s[end])
+		return ret; /* inner:outer:count */
+
+	if (sscanf(s, "%u,%u,%u%n", &ret->outer, &ret->inner, &ret->count,
+		   &end) >= 3 && !s[end])
+		return ret; /* outer,inner,count */
+
+	errx(EXIT_FAILURE, _("invalid mapping '%s'"), s);
 }
 
 /**
@@ -680,9 +662,9 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -r, --map-root-user       map current user to root (implies --user)\n"), out);
 	fputs(_(" -c, --map-current-user    map current user to itself (implies --user)\n"), out);
 	fputs(_(" --map-auto                map users and groups automatically (implies --user)\n"), out);
-	fputs(_(" --map-users=<outeruid>,<inneruid>,<count>\n"
+	fputs(_(" --map-users=<inneruid>:<outeruid>:<count>\n"
 		"                           map count users from outeruid to inneruid (implies --user)\n"), out);
-	fputs(_(" --map-groups=<outergid>,<innergid>,<count>\n"
+	fputs(_(" --map-groups=<innergid>:<outergid>:<count>\n"
 		"                           map count groups from outergid to innergid (implies --user)\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_(" --kill-child[=<signame>]  when dying, kill the forked child (implies --fork)\n"
