Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f181.google.com ([209.85.217.181]:39133 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624AbaHUVem (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 21 Aug 2014 17:34:42 -0400
Received: by mail-lb0-f181.google.com with SMTP id 10so8541034lbg.40
        for <util-linux@vger.kernel.org>; Thu, 21 Aug 2014 14:34:40 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Bernhard Voelker <mail@bernhard-voelker.de>
Subject: Re: [PATCH] mountpoint: symlinks are not mount points
Date: Fri, 22 Aug 2014 00:34:27 +0300
Message-Id: <1408656867-20472-1-git-send-email-kerolasa@iki.fi>
References: <1408644191-13523-1-git-send-email-kerolasa@iki.fi> <53F64865.4090706@bernhard-voelker.de>
In-Reply-To: <53F64865.4090706@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 21 August 2014 22:28, Bernhard Voelker <mail@bernhard-voelker.de> wrote:
> On 08/21/2014 08:03 PM, Sami Kerola wrote:
>> Earlier the mountpoint(1) followed symlinks
>
> IMO this is correct as symlinks only have to be treated
> as such when explicitly not de-referencing.
> As mountpoint(1) does not have a --no-dereference option,
> symlinks should always be transparent for this tool.
>
> Furthermore, the patch would break scripts relying on existing
> behavior:
>
>   $ ln -s / slink
>
>   $ /usr/bin/mountpoint slink
>   slink is a mountpoint
>
>   $ # ~berny/util-linux/mountpoint slink
>   slink is not a mountpoint

Hi Berny,

I don't share view symlinks are mount points.  In my mind they are
pointers, much like street signs, giving a direction to somewhere without
understanding what is there if anything at all.  But not breaking
existing behavior is good point, so I changed the patch and added
--no-dereference.


--->8----
From: Sami Kerola <kerolasa@iki.fi>
Date: Fri, 22 Aug 2014 00:16:57 +0300
Subject: [PATCH] mountpoint: add --no-dereference option

By default the mountpoint follows symlinks.

$ ls -l /tmp/this-is-symlink
lrwxrwxrwx 1 kerolasa kerolasa 1 Aug 21 19:54 /tmp/this-is-symlink -> /
$ mountpoint /tmp/this-is-symlink
/tmp/this-is-symlink is a mountpoint

When use --no-dereference is used symlinks will not be reported as mount
points, even when they are pointing to such.

CC: Bernhard Voelker <mail@bernhard-voelker.de>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/mountpoint.1 |  3 +++
 sys-utils/mountpoint.c | 14 +++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/sys-utils/mountpoint.1 b/sys-utils/mountpoint.1
index 29c153c..c99ba41 100644
--- a/sys-utils/mountpoint.1
+++ b/sys-utils/mountpoint.1
@@ -28,6 +28,9 @@ Be quiet - don't print anything.
 .BR \-x , " \-\-devno"
 Show the major/minor numbers of the given blockdevice on standard output.
 .TP
+.BR \-\-no\-dereference
+Do not follow symbolic links.
+.TP
 .BR \-V , " \-\-version"
 Display version information and exit.
 .TP
diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
index 3919ab7..c34fbee 100644
--- a/sys-utils/mountpoint.c
+++ b/sys-utils/mountpoint.c
@@ -123,6 +123,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -q, --quiet        quiet mode - don't print anything\n"
 		" -d, --fs-devno     print maj:min device number of the filesystem\n"
 		" -x, --devno        print maj:min device number of the block device\n"), out);
+	fputs(_("     --no-dereference  never follow symbolic links\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
@@ -133,14 +134,18 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 
 int main(int argc, char **argv)
 {
-	int c, fs_devno = 0, dev_devno = 0, rc = 0;
+	int c, fs_devno = 0, dev_devno = 0, no_dereference = 0, rc = 0;
 	char *spec;
 	struct stat st;
 
+	enum {
+		OPT_NO_DEREFERENCE = CHAR_MAX + 1
+	};
 	static const struct option longopts[] = {
 		{ "quiet", 0, 0, 'q' },
 		{ "fs-devno", 0, 0, 'd' },
 		{ "devno", 0, 0, 'x' },
+		{ "no-dereference", 0, 0, OPT_NO_DEREFERENCE},
 		{ "help", 0, 0, 'h' },
 		{ "version", 0, 0, 'V' },
 		{ NULL, 0, 0, 0 }
@@ -165,6 +170,9 @@ int main(int argc, char **argv)
 		case 'x':
 			dev_devno = 1;
 			break;
+		case OPT_NO_DEREFERENCE:
+			no_dereference = 1;
+			break;
 		case 'h':
 			usage(stdout);
 			break;
@@ -182,7 +190,7 @@ int main(int argc, char **argv)
 
 	spec = argv[optind++];
 
-	if (stat(spec, &st)) {
+	if (lstat(spec, &st)) {
 		if (!quiet)
 			err(EXIT_FAILURE, "%s", spec);
 		return EXIT_FAILURE;
@@ -192,7 +200,7 @@ int main(int argc, char **argv)
 	else {
 		dev_t src;
 
-		if ( dir_to_device(spec, &src)) {
+		if (dir_to_device(spec, &src) || (no_dereference && S_ISLNK(st.st_mode))) {
 			if (!quiet)
 				printf(_("%s is not a mountpoint\n"), spec);
 			return EXIT_FAILURE;
-- 
2.1.0

