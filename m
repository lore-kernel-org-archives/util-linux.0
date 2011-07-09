Return-Path: util-linux-owner@vger.kernel.org
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:11611 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753428Ab1GINUy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 9 Jul 2011 09:20:54 -0400
From: Daniel Drake <dsd@laptop.org>
To: util-linux@vger.kernel.org
Cc: pgf@laptop.org
Cc: dmitry.torokhov@gmail.com
Subject: [PATCH] evstate: new utility for querying evdev key/switch/event state
Message-Id: <20110709132046.90A119D401C@zog.reactivated.net>
Date: Sat,  9 Jul 2011 14:20:46 +0100 (BST)
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

evstate is a small utility that queries evdev state of a specific
key, switch, button, LED or sound event. This is useful in programs
such as powerd (http://wiki.laptop.org/go/Powerd) which need to query
things like the state of the laptop lid switch from shell code.

Our earlier non-upstream approach to this was to add sysfs nodes that
would indicate button state, but Dmitry Torokhov is against seeing those
in the upstream kernel as it is duplicating info from the input layer:

http://article.gmane.org/gmane.linux.drivers.platform.x86.devel/1089

	No, instead of adding yet another kernel attribute just use ioctl
	to get current switch state. Or write a general purpose utility to
	query switch/key state - many people have asked for it ;)

Here is that general purpose utility that many people are asking for :)

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 configure.ac           |    7 +++
 misc-utils/.gitignore  |    1 +
 misc-utils/Makefile.am |    5 ++
 misc-utils/evstate.1   |   43 +++++++++++++++++
 misc-utils/evstate.c   |  123 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 179 insertions(+), 0 deletions(-)
 create mode 100644 misc-utils/evstate.1
 create mode 100644 misc-utils/evstate.c

diff --git a/configure.ac b/configure.ac
index a02b5e3..a031369 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1027,6 +1027,13 @@ AC_ARG_ENABLE([reset],
 AM_CONDITIONAL(BUILD_RESET, test "x$enable_reset" = xyes)
 
 
+AC_ARG_ENABLE([evstate],
+  AS_HELP_STRING([--enable-evstate], [build evstate]),
+  [], enable_evstate=yes
+)
+AM_CONDITIONAL(BUILD_EVSTATE, test "x$enable_evstate" = xyes)
+
+
 AC_ARG_ENABLE([login-utils],
   AS_HELP_STRING([--enable-login-utils], [build chfn, chsh, login, newgrp, vipw]),
   [], enable_login_utils=no
diff --git a/misc-utils/.gitignore b/misc-utils/.gitignore
index 897e6d1..13f0fdd 100644
--- a/misc-utils/.gitignore
+++ b/misc-utils/.gitignore
@@ -17,3 +17,4 @@ blkid
 wipefs
 findmnt
 lsblk
+evstate
diff --git a/misc-utils/Makefile.am b/misc-utils/Makefile.am
index 0644373..28cb034 100644
--- a/misc-utils/Makefile.am
+++ b/misc-utils/Makefile.am
@@ -115,3 +115,8 @@ if BUILD_RENAME
 usrbin_exec_PROGRAMS += rename
 dist_man_MANS += rename.1
 endif
+
+if BUILD_EVSTATE
+usrbin_exec_PROGRAMS += evstate
+dist_man_MANS += evstate.1
+endif
diff --git a/misc-utils/evstate.1 b/misc-utils/evstate.1
new file mode 100644
index 0000000..664b3b5
--- /dev/null
+++ b/misc-utils/evstate.1
@@ -0,0 +1,43 @@
+.\" -*- nroff -*-
+.TH EVSTATE 1 "Jul 2011" "Version 1.0"
+.SH NAME
+evstate \- query evdev key/LED/switch/sound state
+.SH SYNOPSIS
+.B evstate
+.IR device
+.IR mode
+.IR key
+.SH DESCRIPTION
+.B evstate
+queries the state of a Linux evdev key/button, LED, switch or sound status.
+.PP
+Ordinarily, no textual output is produced.
+.B evstate
+returns exit code 1 if the state bit is set (key pressed, LED on, etc.),
+or exit code 0 if the state bit is unset.
+.PP
+.I device
+is the evdev device node of the input device you wish to query, such
+as /dev/input/event0.
+.PP
+.I mode
+is one of key, led, snd, or sw.
+.PP
+.I key
+is the index of the key/switch/event you wish to query in integer form
+(see <linux/input.h> for values).
+.SH EXAMPLE
+Given /dev/input/event0 as the input device of my laptop dock switch, the
+following command will determine if the laptop is plugged into dock (SW_DOCK).
+.RS
+.PP
+.nf
+evstate /dev/input/event0 sw 5
+.fi
+.SH AUTHOR
+.nf
+Daniel Drake <dsd@laptop.org>
+.fi
+.SH AVAILABILITY
+The evstate command is part of the util-linux package and is available from
+ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/misc-utils/evstate.c b/misc-utils/evstate.c
new file mode 100644
index 0000000..b42019e
--- /dev/null
+++ b/misc-utils/evstate.c
@@ -0,0 +1,123 @@
+/*
+ * evstate: query evdev key/led/sw/snd state
+ * Returns exit code 1 if the state bit is set (key pressed, LED on, etc.),
+ * and 0 if the state bit is unset.
+ *
+ * Copyright (C) 2011 One Laptop per Child
+ * Written by Daniel Drake <dsd@laptop.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ * 
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ * 
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <linux/input.h>
+
+#include "nls.h"
+
+#define BITS_PER_LONG (sizeof(long) * 8)
+
+static int test_bit(unsigned int nr, void *addr)
+{
+	return ((1UL << (nr % BITS_PER_LONG)) &
+		(((unsigned long *) addr)[nr / BITS_PER_LONG])) != 0;
+}
+
+static void __attribute__((noreturn)) usage(void)
+{
+	fprintf(stderr, _("Usage: %s <device> <mode> <key>\n"),
+			program_invocation_short_name);
+	fprintf(stderr, _("Valid modes: key, led, snd, sw\n"));
+	exit(2);
+}
+
+static const struct mode {
+	const char *name;
+	int max;
+	int rq;
+} requests[] = {
+	{ "key", KEY_MAX, EVIOCGKEY(KEY_MAX) },
+	{ "led", LED_MAX, EVIOCGLED(LED_MAX) },
+	{ "snd", SND_MAX, EVIOCGSND(SND_MAX) },
+	{ "sw",  SW_MAX, EVIOCGSW(SW_MAX) },
+};
+
+static const struct mode *find_mode(const char *name)
+{
+	int i;
+	for (i = 0; i < sizeof(requests) / sizeof(*requests); i++) {
+		const struct mode *mode = &requests[i];
+		if (strcmp(mode->name, name) == 0)
+			return mode;
+	}
+	return NULL;
+}
+
+static int query_state(const char *device, long int keyno,
+		       const struct mode *mode)
+{
+	uint8_t state[(mode->max / 8) + 1];
+	int fd;
+	int r;
+
+	if (keyno < 0 || keyno > mode->max) {
+		fprintf(stderr, _("Unrecognised key %d\n"), keyno);
+		exit(3);
+	}
+
+	fd = open(device, O_RDONLY);
+	if (fd == -1) {
+		perror("open");
+		exit(3);
+	}
+
+	memset(state, 0, sizeof(state));
+	r = ioctl(fd, mode->rq, state);
+	close(fd);
+
+	if (r == -1) {
+		perror("ioctl");
+		exit(3);
+	}
+
+	return test_bit(keyno, state);
+}
+
+int main(int argc, char **argv)
+{
+	const struct mode *mode;
+	long int keyno;
+
+	if (argc != 4)
+		usage();
+
+	mode = find_mode(argv[2]);
+	if (!mode) {
+		fprintf(stderr, _("Unrecognised mode.\n"));
+		usage();
+	}
+
+	keyno = strtol(argv[3], NULL, 10);
+	return query_state(argv[1], keyno, mode);
+}
+
-- 
1.7.5.4

