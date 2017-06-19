Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:59303 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753830AbdFSLgR (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Jun 2017 07:36:17 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx101 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MOjMY-1dPe0H0z8o-0064WI for <util-linux@vger.kernel.org>; Mon, 19 Jun 2017
 13:36:15 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/4] toos: add checkusage.sh
Date: Mon, 19 Jun 2017 13:36:11 +0200
Message-Id: <1497872174-9852-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1497872174-9852-1-git-send-email-sweet_f_a@gmx.de>
References: <1497872174-9852-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Just some simple generic tests for our UL commands, regarding options --help,
--version and --unknownopt.

For the record here are the current candidates with possible problems:

$ make checkusage
agetty: --unknownopt, stderr too long: 45
blockdev: --unknownopt, stderr too long: 28
flock: --help, no stdout
flock: --help, non-empty stderr
fsck: --help, returns error
fsck: --version, returns error
fsck: --unknownopt, non-empty stdout
fsck: --unknownopt, stderr too long: 18
getopt: --help, returns error
kill: --unknownopt, stderr too short: 1
login: --help, returns error
login: --version, returns error
login: --unknownopt, stderr too long: 4
lsipc: --unknownopt, stderr too long: 77
mkfs: --unknownopt, stderr too long: 8
mkfs.cramfs: --help, returns error
mkfs.cramfs: --version, returns error
more: --help, returns error
more: --version, returns error
more: --unknownopt, stderr too long: 21
nologin: --help, returns error
nologin: --version, returns error
pg: --unknownopt, stderr too long: 23
renice: --unknownopt, stderr too long: 18
rtcwake: --unknownopt, non-empty stdout
rtcwake: --unknownopt, stderr too long: 21
sulogin: --unknownopt, stderr too long: 17
whereis: --help, returns error
whereis: --version, returns error
whereis: --unknownopt, stderr too long: 18
write: --unknownopt, stderr too long: 12

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 Makefile.am         |  5 ++++
 tools/checkusage.sh | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)
 create mode 100755 tools/checkusage.sh

diff --git a/Makefile.am b/Makefile.am
index 0bfc27f..325d1f4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -183,6 +183,11 @@ checkdecl:
 checkcompletion:
 	@ $(top_srcdir)/tools/checkcompletion.sh $(top_srcdir)
 
+checkusage:
+	@ $(top_srcdir)/tools/checkusage.sh \
+		$(bin_PROGRAMS) $(sbin_PROGRAMS) \
+		$(usrbin_exec_PROGRAMS) $(usrsbin_exec_PROGRAMS)
+
 DISTCHECK_CONFIGURE_FLAGS = \
 	--disable-use-tty-group \
 	--disable-silent-rules \
diff --git a/tools/checkusage.sh b/tools/checkusage.sh
new file mode 100755
index 0000000..3f8cc0f
--- /dev/null
+++ b/tools/checkusage.sh
@@ -0,0 +1,74 @@
+#!/bin/bash
+
+export LC_ALL=C
+
+if [ "$#" -lt 1 ]; then
+	echo "usage: $0 program..." >&2
+	echo "       or try 'make checkusage' to check all built programs" >&2
+	exit 1
+fi
+
+builddir="."
+cmds=$(echo $@ | tr ' ' '\n' | sort)
+
+function exec_option {
+	local cmd=$1
+	shift
+
+	opt=$@
+	out=$("$cmd" "$@" 2>/dev/null)
+	err=$("$cmd" "$@" 2>&1 >/dev/null)
+	ret=$?
+}
+
+for c in $cmds; do
+	cc="$builddir/$c"
+	if ! type "$cc" &>/dev/null; then
+		echo "$c: does not exist"
+		continue
+	fi
+
+	exec_option "$cc" --help
+	if test $ret != 0; then
+		echo "$c: $opt, returns error"
+	else
+		if test -z "$out"; then
+			echo "$c: $opt, no stdout"
+		fi
+		if test -n "$err"; then
+			echo "$c: $opt, non-empty stderr"
+		fi
+	fi
+
+	exec_option "$cc" --version
+	if test $ret != 0; then
+		echo "$c: $opt, returns error"
+	else
+		if test -z "$out"; then
+			echo "$c: $opt, no stdout"
+		fi
+		if test -n "$err"; then
+			echo "$c: $opt, non-empty stderr"
+		fi
+	fi
+
+	exec_option "$cc" --unknownopt
+	if test $ret = 0; then
+		echo "$c: $opt, returns no error"
+	fi
+	if test -n "$out"; then
+		echo "$c: $opt, non-empty stdout"
+	fi
+	if test -z "$err"; then
+		echo "$c: $opt, no stderr"
+	else
+		out_len=$(echo "$out" | wc -l)
+		err_len=$(echo "$err" | wc -l)
+		if test "$err_len" -gt 2; then
+			echo "$c: $opt, stderr too long: $err_len"
+		elif test "$err_len" -lt 2; then
+			echo "$c: $opt, stderr too short: $err_len"
+		fi
+	fi
+done
+
-- 
1.8.5.6

