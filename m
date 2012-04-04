Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56060 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932366Ab2DDSeP convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 4 Apr 2012 14:34:15 -0400
Received: by lahj13 with SMTP id j13so585681lah.19
        for <util-linux@vger.kernel.org>; Wed, 04 Apr 2012 11:34:14 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20120404110917.GN1084@x2.net.home>
References: <CAG27Bk2cNH-x6D=H4C6+NiHJDp4-_dWuU9BJuubTWFOcr-Bu9Q@mail.gmail.com>
	<20120404110917.GN1084@x2.net.home>
Date: Wed, 4 Apr 2012 20:34:13 +0200
Message-ID: <CAG27Bk3rdYbvq3LP6KFz4f3zwBPse0=MUdrFoYjpt3b9MQHwMQ@mail.gmail.com>
Subject: Re: [pull] check stream status
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 4, 2012 at 13:09, Karel Zak <kzak@redhat.com> wrote:
> On Thu, Mar 29, 2012 at 10:28:59PM +0200, Sami Kerola wrote:
>>  include/fileutils.h |    2 ++
>>  lib/fileutils.c     |   37 ++++++++++++++++++++++++++++++++++++-
>
>  I don't like the idea that we need to modify all Makefiles and always
>  compile fileutils.c.
>
>  It would be better to add close_{stream,stdout} functions to a
>  separate include/closestream.h file as static inline functions.

I first thought doing inline function, and add it to c.h but it did
not feel right. Somehow I ended up thinking lib/ functions would be
better, but now when you told about adding header everything falls in
place nice looking way. It's strange how obvious solutions are obvious
only after hearing about them.

>> +     if (close_stream(stdout) != 0 && !(errno == EPIPE)) {
>> +             char const *write_error = _("write error");
>> +             error(0, errno, "%s", write_error);
>
>  Is error() really portable? We already have alternatives for err.h
>  stuff, maybe it would be better to use:
>
>  if (errno)
>    warn(_("write error"));
>  else
>    warnx(_("write error"));
>
>  or add alternative for error() to c.h.

Gnulib is using error() here and there, which to me is pretty good
sign something being portable. But I don't really care if that segment
uses warn*() or error() so I put your version in place.

Here's the critical patch again, for public review, and the trivial
adding #include "closestream.h" && atexit(close_stdout); are in my
renewed remote branch mentioned after the patch.


>From 302e423dc1a6dd8f72e126ec3279a14938da625a Mon Sep 17 00:00:00 2001
From: Sami Kerola <kerolasa@iki.fi>
Date: Wed, 4 Apr 2012 19:22:08 +0200
Subject: [PATCH 01/13] include: add stream error checking facility

The close_stream() is copied from GNU lib.  Inspiration to do this is
talk by Jim Meyering - Goodbye World! The perils of relying on output
streams in C.

Reference: http://www.irill.org/events/ghm-gnu-hackers-meeting/videos/jim-meyering-goodbye-world-the-perils-of-relying-on-output-streams-in-c
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/Makefile.am   |    1 +
 include/closestream.h |   41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)
 create mode 100644 include/closestream.h

diff --git a/include/Makefile.am b/include/Makefile.am
index b939f89..f6934ec 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -7,6 +7,7 @@ dist_noinst_HEADERS = \
 	c.h \
 	canonicalize.h \
 	carefulputc.h \
+	closestream.h \
 	cpuset.h \
 	crc32.h \
 	env.h \
diff --git a/include/closestream.h b/include/closestream.h
new file mode 100644
index 0000000..fb507ea
--- /dev/null
+++ b/include/closestream.h
@@ -0,0 +1,41 @@
+#ifndef UTIL_LINUX_CLOSESTREAM_H
+#define UTIL_LINUX_CLOSESTREAM_H
+
+#include <stdio.h>
+#include <stdio_ext.h>
+#include <unistd.h>
+
+#include "c.h"
+#include "nls.h"
+
+static inline int
+close_stream(FILE * stream)
+{
+	const int some_pending = (__fpending(stream) != 0);
+	const int prev_fail = (ferror(stream) != 0);
+	const int fclose_fail = (fclose(stream) != 0);
+	if (prev_fail || (fclose_fail && (some_pending || errno != EBADF))) {
+		if (!fclose_fail)
+			errno = 0;
+		return EOF;
+	}
+	return 0;
+}
+
+/* Meant to be used atexit(close_stdout); */
+static inline void
+close_stdout(void)
+{
+	if (close_stream(stdout) != 0 && !(errno == EPIPE)) {
+		if (errno)
+			warn(_("write error"));
+		else
+			warnx(_("write error"));
+		_exit(EXIT_FAILURE);
+	}
+
+	if (close_stream(stderr) != 0)
+		_exit(EXIT_FAILURE);
+}
+
+#endif /* UTIL_LINUX_CLOSESTREAM_H */
-- 
1.7.9.5


The following changes since commit 8265242b22a672d592025ec66365d32d60429557:

  lsblk: count with terminating character, man page -s entry
(2012-04-04 13:32:25 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git close_stream

for you to fetch changes up to 45ca68ece78dd5d0f83863e33bfad2cc88fc2d1e:

  disk-utils: verify writing to streams was successful (2012-04-04
20:04:39 +0200)

----------------------------------------------------------------
Sami Kerola (13):
      include: add stream error checking facility
      text-utils: verify writing to streams was successful
      term-utils: verify writing to streams was successful
      sys-utils: verify writing to streams was successful
      schedutils: verify writing to streams was successful
      partx: verify writing to streams was successful
      mount: verify writing to streams was successful
      misc-utils: verify writing to streams was successful
      login-utils: verify writing to streams was successful
      hwclock: verify writing to streams was successful
      getopt: verify writing to streams was successful
      fdisk: verify writing to streams was successful
      disk-utils: verify writing to streams was successful

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
