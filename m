Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:58280 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361AbcCBTf4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Mar 2016 14:35:56 -0500
To: util-linux@vger.kernel.org,
        Federico Bento <up201407890@alunos.dcc.fc.up.pt>
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: Fixing su + runuser vulnerability CVE-2016-2779
Message-ID: <56D7409A.6050407@suse.cz>
Date: Wed, 2 Mar 2016 20:35:54 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

As you may know, there are reported vulnerabilities for several Linux
utilities using TIOCSTI ioctl terminal injection.

I am just thinking about a best fix for them. However possible fixes
are easy (see below), all of user space fixes have side effects.

There is also questionable, whether it is issue of util-linux at all,
and whether it should be restricted in the kernel.

For now, I am attaching a simple reproduced from the Debian bug.
It also contains references.

To Federico Bento: Could you confirm that you are author and approve
the license in the test_tiocsti.c, please?


In following examples, I never entered "id -u -n" manually. They were
injected.

Bad:
util-linux # ./runuser -u nobody ./test_tiocsti
id -u -n
util-linux # id -u -n
root

OK:
util-linux # su nobody -c ./test_tiocsti
util-linux #

Bad:
util-linux # su - nobody -s $PWD/test_tiocsti
id -u -n
util-linux # id -u -n
root
util-linux # 

Bad:
util-linux # su - nobody --session-command $PWD/test_tiocsti
id -u -n
util-linux # id -u -n
root
util-linux #

Not only util-linux is affected:
util-linux # cp -a test_tiocsti /openSUSE-root/
util-linux # chroot /openSUSE-root /test_tiocsti
id -u -n
util-linux # id -u -n
root
util-linux # sudo -u nobody ./test_tiocsti
id -u -n
util-linux # id -u -n
root


There are some controversial things with the straightforward fix:

setsid() prevents TIOCSTI attack described in the report (easy to
reproduce), but it has side effects: It disconnects the task from job
control. With setsid(), ^Z cannot be used for sending the application
to background any more (easy to reproduce by calling setsid()
unconditionally in the same place).

su-common.c now calls setsid() only if new session is requested.


Another possible fixes would be:

- Request redirection of all I/O channels. (I. e. documentation fix
  plus possible command line option to make it simpler.)

- Or create custom pty container (like script does).

- Or create a kernel level fix restricting TIOCSTI and let utilities as
  they are.

First two will have side effects, third seems to be a right way to me.


Additionally, https://bugzilla.redhat.com/show_bug.cgi?id=173008 says,
that even it does not handle all possible attacks, because attacker can
still read and write to the terminal:

==== steal.sh ====
#!/bin/sh
(
sleep 3
exec 0>&1
echo "Hallo" >/dev/stdout
cat >/tmp/nobody-savefile
) &
==================

~/util-linux # ./runuser -u nobody ./steal.sh
~/util-linux # Hallo

To prevent unwanted reading from a terminal, one would:

- Either request redirection of all I/O channels. (I. e. documentation
  fix plus possible command line option to make it simpler.)

- Or kill slave processes holding the terminal after exiting. It
  prevents it in 100%, but it has important side effects.

- Or create custom pty container (like script does).

- Or, finally introduce some type of revoke() syscall in the kernel.

First is de facto not a fix, second has side effects, third would be a
bit fragile, and fourth does not exist yet.


I don't have a test case yet. The test environment inside a test suite
needs a custom pty with shell. I tries to use script for it but failed:
$TS_CMD_SCRIPT" -c "$TS_CMD_RUNUSER -u nobody $TS_HELPER_TIOCSTI" $TS_OUTDIR/${TS_TESTNAME}-typescript


>From ce590b57ac1c54011a007839ac939afefec942a3 Mon Sep 17 00:00:00 2001
From: Stanislav Brabec <sbrabec@suse.cz>
Date: Wed, 2 Mar 2016 19:46:34 +0100
Subject: [PATCH] Add helper for TIOCSTI exploit

This helper/exploit injects "id -u -n\n" to the vulnerable calling terminal.

Use id -u -n to get a reproducible output of test cases based on it.

What can happen:

Nothing, no exploit: pty is not accessible, sedsid() disconnected the task from
pty, TIOCSTI failed.

The command is injected to the unprivileged environment pty, and you see e. g.
"nobody": This is acceptable.

The command is injected to the caller (privileged) pty, and you see "root" (or
caller uid name): This is not acceptable and has security implications.

References:

CVE-2016-2779
http://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2016-2779
http://seclists.org/oss-sec/2016/q1/448
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=815922
https://bugzilla.redhat.com/show_bug.cgi?id=173008
https://bugzilla.suse.com/show_bug.cgi?id=968674
https://bugzilla.suse.com/show_bug.cgi?id=968675

CVE-2016-2781
http://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2016-2781
http://seclists.org/oss-sec/2016/q1/452

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
Cc: Federico Bento <up201407890@alunos.dcc.fc.up.pt>
---
 tests/commands.sh            |  2 ++
 tests/helpers/Makemodule.am  |  3 +++
 tests/helpers/test_tiocsti.c | 27 +++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 tests/helpers/test_tiocsti.c

diff --git a/tests/commands.sh b/tests/commands.sh
index 5518dc3..3327f66 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -30,6 +30,7 @@ TS_HELPER_SCRIPT="$top_builddir/test_script"
 TS_HELPER_SIGRECEIVE="$top_builddir/test_sigreceive"
 TS_HELPER_STRUTILS="$top_builddir/test_strutils"
 TS_HELPER_SYSINFO="$top_builddir/test_sysinfo"
+TS_HELPER_TIOCSTI="$top_builddir/test_tiocsti"
 TS_HELPER_UUID_PARSER="$top_builddir/test_uuid_parser"
 
 # paths to commands
@@ -73,6 +74,7 @@ TS_CMD_MOUNTPOINT=${TS_CMD_MOUNTPOINT:-"$top_builddir/mountpoint"}
 TS_CMD_NAMEI=${TS_CMD_NAMEI-"$top_builddir/namei"}
 TS_CMD_PARTX=${TS_CMD_PARTX-"$top_builddir/partx"}
 TS_CMD_RENAME=${TS_CMD_RENAME-"$top_builddir/rename"}
+TS_CMD_RUNUSER=${TS_CMD_RUNUSER-"$top_builddir/runuser"}
 TS_CMD_REV=${TS_CMD_REV:-"$top_builddir/rev"}
 TS_CMD_SCRIPT=${TS_CMD_SCRIPT-"$top_builddir/script"}
 TS_CMD_SCRIPTREPLAY=${TS_CMD_SCRIPTREPLAY-"$top_builddir/scriptreplay"}
diff --git a/tests/helpers/Makemodule.am b/tests/helpers/Makemodule.am
index 0618e75..3070a8b 100644
--- a/tests/helpers/Makemodule.am
+++ b/tests/helpers/Makemodule.am
@@ -15,3 +15,6 @@ check_PROGRAMS += test_sigreceive
 test_sigreceive_SOURCES = tests/helpers/test_sigreceive.c
 test_sigreceive_LDADD = $(LDADD) libcommon.la
 
+check_PROGRAMS += test_tiocsti
+test_tiocsti_SOURCES = tests/helpers/test_tiocsti.c
+
diff --git a/tests/helpers/test_tiocsti.c b/tests/helpers/test_tiocsti.c
new file mode 100644
index 0000000..c269dc0
--- /dev/null
+++ b/tests/helpers/test_tiocsti.c
@@ -0,0 +1,27 @@
+/*
+ * test_tiocsti - test security of TIOCSTI
+ *
+ * Written by Federico Bento <up201407890@alunos.dcc.fc.up.pt>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <sys/ioctl.h>
+
+int main(void)
+{
+  char *cmd = "id -u -n\n";
+  while(*cmd)
+   ioctl(0, TIOCSTI, cmd++);
+}
-- 
2.7.2

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
