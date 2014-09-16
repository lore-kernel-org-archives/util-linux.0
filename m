Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34436 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbaIPUgr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 16 Sep 2014 16:36:47 -0400
Received: by mail-wg0-f51.google.com with SMTP id k14so410291wgh.10
        for <util-linux@vger.kernel.org>; Tue, 16 Sep 2014 13:36:46 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
Date: Tue, 16 Sep 2014 21:36:43 +0100 (BST)
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 09/17] mountpoint: add struct mountpoint_control
In-Reply-To: <20140912091411.GU21325@x2.net.home>
Message-ID: <alpine.LNX.2.03.1409162134140.3712@kerolasa-home>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi> <1410093785-17537-10-git-send-email-kerolasa@iki.fi> <20140912091411.GU21325@x2.net.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 12 Sep 2014, Karel Zak wrote:

> On Sun, Sep 07, 2014 at 01:42:57PM +0100, Sami Kerola wrote:
>> This unifies variable names in different functions, and removes redundant
>> stat() calls.
>>
>> Signed-off-by: Sami Kerola <kerolasa@iki.fi>
>> ---
>>  sys-utils/mountpoint.c | 86 ++++++++++++++++++++++++--------------------------
>>  1 file changed, 41 insertions(+), 45 deletions(-)
>>
>> diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
>> index 3919ab7..3392cdd 100644
>> --- a/sys-utils/mountpoint.c
>> +++ b/sys-utils/mountpoint.c
>> @@ -40,9 +40,17 @@
>>  #include "closestream.h"
>>  #include "pathnames.h"
>>
>> -static int quiet;
>> +struct mountpoint_control {
>> +	char *devname;
>
> This member name makes the code difficult to read, on many places it's
> not device at all. Please, use "path" or "spec" rather then "devname".

Done.

>> +	dev_t dev;
>> +	struct stat st;
>> +	uint8_t
>> +		dev_devno:1,
>> +		fs_devno:1,
>> +		quiet:1;
>> +};
>
> Use "unsigned int" for bit fields, it's compiler business to optimize
> how the bits are packed in the struct.
>
>
> C99, 6.7.2.1 Structure and union specifiers
>
> A bit-field shall have a type that is a qualified or unqualified
> version of _Bool, signed int, unsigned int, or some other
> implementation-defined type.

Thanks Karel. I'll stick to unsigned ints in future when doing bit fields.

--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Fri, 22 Aug 2014 13:25:48 +0300
Subject: [PATCH 07/17] mountpoint: add struct mountpoint_control

This unifies variable names in different functions, and removes redundant
stat() calls.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
  sys-utils/mountpoint.c | 86 ++++++++++++++++++++++++--------------------------
  1 file changed, 41 insertions(+), 45 deletions(-)

diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
index 3919ab7..4161d20 100644
--- a/sys-utils/mountpoint.c
+++ b/sys-utils/mountpoint.c
@@ -40,9 +40,17 @@
  #include "closestream.h"
  #include "pathnames.h"

-static int quiet;
+struct mountpoint_control {
+	char *path;
+	dev_t dev;
+	struct stat st;
+	unsigned int
+		dev_devno:1,
+		fs_devno:1,
+		quiet:1;
+};

-static int dir_to_device(const char *spec, dev_t *dev)
+static int dir_to_device(struct mountpoint_control *ctl)
  {
  	struct libmnt_table *tb = mnt_new_table_from_file(_PATH_PROC_MOUNTINFO);
  	struct libmnt_fs *fs;
@@ -54,16 +62,13 @@ static int dir_to_device(const char *spec, dev_t *dev)
  		 * Fallback. Traditional way to detect mountpoints. This way
  		 * is independent on /proc, but not able to detect bind mounts.
  		 */
-		struct stat pst, st;
+		struct stat pst;
  		char buf[PATH_MAX], *cn;
  		int len;

-		if (stat(spec, &st) != 0)
-			return -1;
-
-		cn = mnt_resolve_path(spec, NULL);	/* canonicalize */
+		cn = mnt_resolve_path(ctl->path, NULL);	/* canonicalize */

-		len = snprintf(buf, sizeof(buf), "%s/..", cn ? cn : spec);
+		len = snprintf(buf, sizeof(buf), "%s/..", cn ? cn : ctl->path);
  		free(cn);

  		if (len < 0 || (size_t) len + 1 > sizeof(buf))
@@ -71,9 +76,9 @@ static int dir_to_device(const char *spec, dev_t *dev)
  		if (stat(buf, &pst) !=0)
  			return -1;

-		if ((st.st_dev != pst.st_dev) ||
-		    (st.st_dev == pst.st_dev && st.st_ino == pst.st_ino)) {
-			*dev = st.st_dev;
+		if ((ctl->st.st_dev != pst.st_dev) ||
+		    (ctl->st.st_dev == pst.st_dev && ctl->st.st_ino == pst.st_ino)) {
+			ctl->dev = ctl->st.st_dev;
  			return 0;
  		}

@@ -85,9 +90,9 @@ static int dir_to_device(const char *spec, dev_t *dev)
  	mnt_table_set_cache(tb, cache);
  	mnt_unref_cache(cache);

-	fs = mnt_table_find_target(tb, spec, MNT_ITER_BACKWARD);
+	fs = mnt_table_find_target(tb, ctl->path, MNT_ITER_BACKWARD);
  	if (fs && mnt_fs_get_target(fs)) {
-		*dev = mnt_fs_get_devno(fs);
+		ctl->dev = mnt_fs_get_devno(fs);
  		rc = 0;
  	}

@@ -95,20 +100,14 @@ static int dir_to_device(const char *spec, dev_t *dev)
  	return rc;
  }

-static int print_devno(const char *devname, struct stat *st)
+static int print_devno(const struct mountpoint_control *ctl)
  {
-	struct stat stbuf;
-
-	if (!st && stat(devname, &stbuf) == 0)
-		st = &stbuf;
-	if (!st)
-		return -1;
-	if (!S_ISBLK(st->st_mode)) {
-		if (!quiet)
-			warnx(_("%s: not a block device"), devname);
+	if (!S_ISBLK(ctl->st.st_mode)) {
+		if (!ctl->quiet)
+			warnx(_("%s: not a block device"), ctl->path);
  		return -1;
  	}
-	printf("%u:%u\n", major(st->st_rdev), minor(st->st_rdev));
+	printf("%u:%u\n", major(ctl->st.st_rdev), minor(ctl->st.st_rdev));
  	return 0;
  }

@@ -133,9 +132,8 @@ static void __attribute__((__noreturn__)) usage(FILE *out)

  int main(int argc, char **argv)
  {
-	int c, fs_devno = 0, dev_devno = 0, rc = 0;
-	char *spec;
-	struct stat st;
+	int c, rc = 0;
+	struct mountpoint_control ctl = { 0 };

  	static const struct option longopts[] = {
  		{ "quiet", 0, 0, 'q' },
@@ -157,13 +155,13 @@ int main(int argc, char **argv)

  		switch(c) {
  		case 'q':
-			quiet = 1;
+			ctl.quiet = 1;
  			break;
  		case 'd':
-			fs_devno = 1;
+			ctl.fs_devno = 1;
  			break;
  		case 'x':
-			dev_devno = 1;
+			ctl.dev_devno = 1;
  			break;
  		case 'h':
  			usage(stdout);
@@ -180,27 +178,25 @@ int main(int argc, char **argv)
  	if (optind + 1 != argc)
  		usage(stderr);

-	spec = argv[optind++];
+	ctl.path = argv[optind];

-	if (stat(spec, &st)) {
-		if (!quiet)
-			err(EXIT_FAILURE, "%s", spec);
+	if (stat(ctl.path, &ctl.st)) {
+		if (!ctl.quiet)
+			err(EXIT_FAILURE, "%s", ctl.path);
  		return EXIT_FAILURE;
  	}
-	if (dev_devno)
-		rc = print_devno(spec, &st);
+	if (ctl.dev_devno)
+		rc = print_devno(&ctl);
  	else {
-		dev_t src;
-
-		if ( dir_to_device(spec, &src)) {
-			if (!quiet)
-				printf(_("%s is not a mountpoint\n"), spec);
+		if (dir_to_device(&ctl)) {
+			if (!ctl.quiet)
+				printf(_("%s is not a mountpoint\n"), ctl.path);
  			return EXIT_FAILURE;
  		}
-		if (fs_devno)
-			printf("%u:%u\n", major(src), minor(src));
-		else if (!quiet)
-			printf(_("%s is a mountpoint\n"), spec);
+		if (ctl.fs_devno)
+			printf("%u:%u\n", major(ctl.dev), minor(ctl.dev));
+		else if (!ctl.quiet)
+			printf(_("%s is a mountpoint\n"), ctl.path);
  	}

  	return rc ? EXIT_FAILURE : EXIT_SUCCESS;
-- 
2.1.0

