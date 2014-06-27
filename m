Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f41.google.com ([209.85.160.41]:60730 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbaF0FS2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Jun 2014 01:18:28 -0400
Received: by mail-pb0-f41.google.com with SMTP id ma3so4128171pbc.0
        for <util-linux@vger.kernel.org>; Thu, 26 Jun 2014 22:18:28 -0700 (PDT)
From: "Eric Rannaud" <e@nanocritical.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Dave Reisner <d@falconindy.com>,
        Eric Rannaud <e@nanocritical.com>
Subject: [PATCH 4/4] findmnt: use mnt_cache_set_targets() for non-kernel table
Date: Thu, 26 Jun 2014 22:18:48 -0700
Message-Id: <7f69c8fad1eed4faee033f1164f7481b10593413.1403845374.git.e@nanocritical.com>
In-Reply-To: <747e9f8de90dc1e906d2f84f3952a801e70ef3d0.1403845374.git.e@nanocritical.com>
References: <747e9f8de90dc1e906d2f84f3952a801e70ef3d0.1403845374.git.e@nanocritical.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

findmnt compares the user-supplied path <target> with each entry in the
parsed table. To do this comparison, libmount attempts to canonicalize
the target path of each table entry, when the entry does not originate
from the kernel (kernel supplied target paths are already
canonicalized). However, if one of these entries is an active mount
point, stat(2) or readlink(2) on the mount target path can hang (e.g.
unreachable NFS server).

If the main table is not a kernel table, we parse /proc/self/mountinfo
into a secondary table and call mnt_cache_set_targets(). This allows
libmount to check that the target path of each entry in the main table
is not an active mount point, so it can avoid canonicalizing it.

Signed-off-by: Eric Rannaud <e@nanocritical.com>
---


* This was tested on a system with a stale mount under /mnt: findmnt -s /usr
  With 2.24.2, strace shows a lstat("/mnt") (and hangs), but no lstat on active
  mount points with this change (and doesn't hang).

* mountinfo is read whenever the main table is not from the kernel (tabtype !=
  TABTYPE_KERNEL), with or without -T. I can't think of a reason to only do
  this when -T is specified.

* Karel, you mentionned this would have a performance impact on large systems,
  but I do not know how to asses it. Should there an option to turn this new
  behavior on or off?
  Isn't it true that a system with a very large number of mount points in fstab
  is also likely to have a large number of active mount points, increasing the
  chance that one of them is stale or slow to respond? With this patch, while
  you have to read mountinfo every instantiation of findmnt, I reckon that the
  average runtime would be lower as you don't need to lstat any of the active
  mountpoints.

* Should --nocanonicalize be removed after this patch?

Thanks.


 misc-utils/findmnt.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 06fdd8f41074..37dd92a10a14 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -833,6 +833,36 @@ static struct libmnt_table *parse_tabfiles(char **files,
 	return tb;
 }
 
+/*
+ * Parses mountinfo and calls mnt_cache_set_targets(cache, mtab). Only
+ * necessary if @tb in main() was read from a non-kernel source.
+ */
+static void cache_set_targets(struct libmnt_cache *cache)
+{
+	struct libmnt_table *tb = NULL;
+	char *path = NULL;
+	int rc = 0;
+
+	tb = mnt_new_table();
+	if (!tb)
+		goto done;
+
+	path = access(_PATH_PROC_MOUNTINFO, R_OK) == 0 ?
+		_PATH_PROC_MOUNTINFO :
+		_PATH_PROC_MOUNTS;
+
+	rc = mnt_table_parse_file(tb, path);
+	if (rc)
+		goto done;
+
+	rc = mnt_cache_set_targets(cache, tb);
+	if (rc)
+		goto done;
+
+done:
+	mnt_unref_table(tb);
+}
+
 /* checks if @tb contains parent->child relations */
 static int tab_is_tree(struct libmnt_table *tb)
 {
@@ -1471,6 +1501,9 @@ int main(int argc, char *argv[])
 			goto leave;
 		}
 		mnt_table_set_cache(tb, cache);
+
+		if (tabtype != TABTYPE_KERNEL)
+			cache_set_targets(cache);
 	}
 
 	if (flags & FL_UNIQ)
-- 
2.0.1

