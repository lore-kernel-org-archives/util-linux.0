Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49368 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752014AbaKGL2Z (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Nov 2014 06:28:25 -0500
Date: Fri, 7 Nov 2014 12:28:13 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/8] swapoff: make LABEL= and UUID= work when turning off
 swap files
Message-ID: <20141107112813.GI6880@x2.net.home>
References: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
 <1414959991-8369-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414959991-8369-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 02, 2014 at 08:26:24PM +0000, Sami Kerola wrote:
> -static int swapoff_by_label(const char *label, int quiet)
> +static int swapoff_by(const char *type, const char *request, int quiet)
>  {
> -	const char *special = mnt_resolve_tag("LABEL", label, mntcache);
> -	return special ? do_swapoff(special, quiet, CANONIC) : cannot_find(label);
> -}
> +	struct libmnt_table *tb = get_swaps();
> +	struct libmnt_iter *itr = mnt_new_iter(MNT_ITER_BACKWARD);
> +	struct libmnt_fs *fs;
> +	int ret = 0, notfound = -1;
>  
> -static int swapoff_by_uuid(const char *uuid, int quiet)
> -{
> -	const char *special = mnt_resolve_tag("UUID", uuid, mntcache);
> -	return special ? do_swapoff(special, quiet, CANONIC) : cannot_find(uuid);
> +	while (tb && mnt_table_find_next_fs(tb, itr, match_swap, NULL, &fs) == 0) {
> +		const char *dev = mnt_fs_get_source(fs);
> +		blkid_probe pr;
> +		const char *data;
> +
> +		pr = get_swap_prober(dev);
> +		blkid_probe_lookup_value(pr, type, &data, NULL);
> +		if (data && !strcmp(request, data)) {
> +			notfound = 0;
> +			ret |= do_swapoff(dev, quiet, CANONIC);
> +		}
> +	}
> +	ret += notfound;
> +	return !ret ? 0 : cannot_find(request);
>  }

You have forced all swapoff to use /proc/swaps to translate
UUID/LABEL to device or file name. It's bad idea because

  * it's expensive, mnt_resolve_* function uses udev symlinks, one
    readlink() is faster than libblkid machinery

  * dependence on /proc/swaps should be optional, the /proc filesystem
    does not have to be mounted

IMHO it would be better to use libblkid and /proc/swaps as fallback
solution only.


>  static void __attribute__ ((__noreturn__)) usage(FILE * out)
> @@ -118,7 +130,7 @@ static int swapoff_all(void)
>  
>  	while (tb && mnt_table_find_next_fs(tb, itr, match_swap, NULL, &fs) == 0) {
>  		if (!is_active_swap(mnt_fs_get_source(fs)))
> -			do_swapoff(mnt_fs_get_source(fs), QUIET, !CANONIC);
> +			do_swapoff(mnt_fs_get_source(fs), QUIET, CANONIC);
>  	}

 this seems like typo (or do you expect that all fstab stuff is
 canonical?)

>  	for (i = 0; i < numof_labels(); i++)
> -		status |= swapoff_by_label(get_label(i), !QUIET);
> +		status |= swapoff_by("LABEL", get_label(i), !QUIET);
>  
>  	for (i = 0; i < numof_uuids(); i++)
> -		status |= swapoff_by_uuid(get_uuid(i), !QUIET);
> +		status |= swapoff_by("UUID", get_uuid(i), !QUIET);
  
 I like the idea to have only one swapoff_by() function.

>  	while (*argv != NULL)
>  		status |= do_swapoff(*argv++, !QUIET, !CANONIC);

 BTW, you have no changed tags resolving in do_swapoff(), so I guess

    swaponff UUID=<uuid> 

does not work with your patch, the patch fixes only -U <uuid> use
case.

I have applied a little different patch to fix the problem.

    Karel


>From 52f2fd9bcc9bbc2a0234114f11870d943de76652 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Fri, 7 Nov 2014 12:08:11 +0100
Subject: [PATCH] swapoff: swapoff swap files by LABEL and UUID

 # swapon --show=NAME,UUID
 NAME                   UUID
 /dev/sda3              8d52fca3-bf48-41d6-b826-2315e518a305
 /home/fs-images/2g.img 6fa72b96-b802-441f-a31c-091d65c0212c

 # swapoff UUID=6fa72b96-b802-441f-a31c-091d65c0212c
 swapoff: cannot find the device for UUID=6fa72b96-b802-441f-a31c-091d65c0212c

Reported-by: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 sys-utils/Makemodule.am | 13 +++++++--
 sys-utils/swapoff.c     | 74 +++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 73 insertions(+), 14 deletions(-)

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index f540d38..12fa632 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -279,9 +279,16 @@ swapon_LDADD = $(LDADD) \
 swapoff_SOURCES = \
 	sys-utils/swapoff.c \
 	sys-utils/swapon-common.c \
-	sys-utils/swapon-common.h
-swapoff_CFLAGS = $(AM_CFLAGS) -I$(ul_libmount_incdir)
-swapoff_LDADD = $(LDADD) libmount.la
+	sys-utils/swapon-common.h \
+	lib/swapprober.c \
+	include/swapprober.h
+swapoff_CFLAGS = $(AM_CFLAGS) \
+	-I$(ul_libblkid_incdir) \
+	-I$(ul_libmount_incdir)
+swapoff_LDADD = $(LDADD) \
+	libmount.la \
+	libblkid.la \
+	libcommon.la
 endif
 
 if BUILD_LSCPU
diff --git a/sys-utils/swapoff.c b/sys-utils/swapoff.c
index 182ce95..b725462 100644
--- a/sys-utils/swapoff.c
+++ b/sys-utils/swapoff.c
@@ -8,8 +8,10 @@
 
 #include "nls.h"
 #include "c.h"
+#include "xalloc.h"
 #include "closestream.h"
 
+#include "swapprober.h"
 #include "swapon-common.h"
 
 #ifndef SWAPON_HAS_TWO_ARGS
@@ -24,6 +26,58 @@ static int all;
 #define QUIET	1
 #define CANONIC	1
 
+/*
+ * This function works like mnt_resolve_tag(), but it's able to read UUiD/LABEL
+ * from regular swap files too (according to entries in /proc/swaps). Note that
+ * mnt_resolve_tag() and mnt_resolve_spec() works with system visible block
+ * devices only.
+ */
+static char *swapoff_resolve_tag(const char *name, const char *value,
+				 struct libmnt_cache *cache)
+{
+	char *path;
+	struct libmnt_table *tb;
+	struct libmnt_iter *itr;
+	struct libmnt_fs *fs;
+
+	/* this is usual case for block devices (and it's really fast as it uses
+	 * udev /dev/disk/by-* symlinks by default */
+	path = mnt_resolve_tag(name, value, cache);
+	if (path)
+		return path;
+
+	/* try regular files from /proc/swaps */
+	tb = get_swaps();
+	if (!tb)
+		return NULL;
+
+	itr = mnt_new_iter(MNT_ITER_BACKWARD);
+	if (!itr)
+		err(EXIT_FAILURE, _("failed to initialize libmount iterator"));
+
+	while (tb && mnt_table_next_fs(tb, itr, &fs) == 0) {
+		blkid_probe pr = NULL;
+		const char *src = mnt_fs_get_source(fs);
+		const char *type = mnt_fs_get_swaptype(fs);
+		const char *data = NULL;
+
+		if (!src || !type || strcmp(type, "file") != 0)
+			continue;
+		pr = get_swap_prober(src);
+		if (!pr)
+			continue;
+		blkid_probe_lookup_value(pr, name, &data, NULL);
+		if (data && strcmp(data, value) == 0)
+			path = xstrdup(src);
+		blkid_free_probe(pr);
+		if (path)
+			break;
+	}
+
+	mnt_free_iter(itr);
+	return path;
+}
+
 static int do_swapoff(const char *orig_special, int quiet, int canonic)
 {
         const char *special = orig_special;
@@ -32,7 +86,11 @@ static int do_swapoff(const char *orig_special, int quiet, int canonic)
 		printf(_("swapoff %s\n"), orig_special);
 
 	if (!canonic) {
+		char *n, *v;
+
 		special = mnt_resolve_spec(orig_special, mntcache);
+		if (!special && blkid_parse_tag_string(orig_special, &n, &v) == 0)
+			special = swapoff_resolve_tag(n, v, mntcache);
 		if (!special)
 			return cannot_find(orig_special);
 	}
@@ -49,16 +107,10 @@ static int do_swapoff(const char *orig_special, int quiet, int canonic)
 	return -1;
 }
 
-static int swapoff_by_label(const char *label, int quiet)
-{
-	const char *special = mnt_resolve_tag("LABEL", label, mntcache);
-	return special ? do_swapoff(special, quiet, CANONIC) : cannot_find(label);
-}
-
-static int swapoff_by_uuid(const char *uuid, int quiet)
+static int swapoff_by(const char *name, const char *value, int quiet)
 {
-	const char *special = mnt_resolve_tag("UUID", uuid, mntcache);
-	return special ? do_swapoff(special, quiet, CANONIC) : cannot_find(uuid);
+	const char *special = swapoff_resolve_tag(name, value, mntcache);
+	return special ? do_swapoff(special, quiet, CANONIC) : cannot_find(value);
 }
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
@@ -178,10 +230,10 @@ int main(int argc, char *argv[])
 	mntcache = mnt_new_cache();
 
 	for (i = 0; i < numof_labels(); i++)
-		status |= swapoff_by_label(get_label(i), !QUIET);
+		status |= swapoff_by("LABEL", get_label(i), !QUIET);
 
 	for (i = 0; i < numof_uuids(); i++)
-		status |= swapoff_by_uuid(get_uuid(i), !QUIET);
+		status |= swapoff_by("UUID", get_uuid(i), !QUIET);
 
 	while (*argv != NULL)
 		status |= do_swapoff(*argv++, !QUIET, !CANONIC);
-- 
1.9.3

