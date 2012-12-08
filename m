Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-da0-f46.google.com ([209.85.210.46]:52822 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297Ab2LHIT1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Dec 2012 03:19:27 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so517904dak.19
        for <util-linux@vger.kernel.org>; Sat, 08 Dec 2012 00:19:26 -0800 (PST)
From: Andy Lutomirski <luto@amacapital.net>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?P=C3=A1draig=20Brady?= <P@draigbrady.com>,
        =?UTF-8?q?=C3=81ngel=20Gonz=C3=A1lez?= <ingenit@zoho.com>,
        Karel Zak <kzak@redhat.com>, Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH] Add setpriv, a tool to set privileges and such
Date: Sat,  8 Dec 2012 00:19:12 -0800
Message-Id: <5a4bb50baed87dbe00be9003dad7cc1ba59ca571.1354954632.git.luto@amacapital.net>
In-Reply-To: <b9e1a13168f41cde97e1fdaa21cdc5354ef535ea.1353702119.git.luto@amacapital.net>
References: <b9e1a13168f41cde97e1fdaa21cdc5354ef535ea.1353702119.git.luto@amacapital.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This can set no_new_privs, uid, gid, groups, securebits, inheritable caps, the cap
bounding set, securebits, and selinux and apparmor labels.

Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---

This is like my no_new_privs tool, but way more fun :)

 .gitignore              |   1 +
 configure.ac            |   9 +
 sys-utils/Makemodule.am |   7 +
 sys-utils/setpriv.1     | 132 +++++++++
 sys-utils/setpriv.c     | 751 ++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 900 insertions(+)
 create mode 100644 sys-utils/setpriv.1
 create mode 100644 sys-utils/setpriv.c

diff --git a/.gitignore b/.gitignore
index e85eb07..b3ed077 100644
--- a/.gitignore
+++ b/.gitignore
@@ -146,6 +146,7 @@ tests/run.sh.trs
 /script
 /scriptreplay
 /setarch
+/setpriv
 /setsid
 /setterm
 /sfdisk
diff --git a/configure.ac b/configure.ac
index 727113a..18a8f43 100644
--- a/configure.ac
+++ b/configure.ac
@@ -866,6 +866,15 @@ if test "x$build_unshare" = xyes; then
 fi
 
 
+AC_ARG_ENABLE([setpriv],
+  AS_HELP_STRING([--disable-setpriv], [do not build setpriv]),
+  [], enable_setpriv=check
+)
+UL_BUILD_INIT([setpriv])
+UL_REQUIRES_LINUX([setpriv])
+AM_CONDITIONAL(BUILD_SETPRIV, test "x$build_setpriv" = xyes)
+
+
 AC_ARG_ENABLE([arch],
   AS_HELP_STRING([--enable-arch], [do build arch]),
   [], enable_arch=no
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index c7b1eb3..329dd95 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -309,3 +309,10 @@ if HAVE_AUDIT
 hwclock_LDADD += -laudit
 endif
 endif # BUILD_HWCLOCK
+
+if BUILD_SETPRIV
+usrbin_exec_PROGRAMS += setpriv
+dist_man_MANS += sys-utils/setpriv.1
+setpriv_SOURCES = sys-utils/setpriv.c
+setpriv_LDADD = -lcap-ng
+endif
diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
new file mode 100644
index 0000000..b76c4f1
--- /dev/null
+++ b/sys-utils/setpriv.1
@@ -0,0 +1,132 @@
+.\" Process this file with
+.\" groff -man -Tascii no_new_privs.1
+.\"
+.TH SETPRIV 1 "December 2012" "util-linux" "User Commands"
+.SH NAME
+setpriv \- run program with different Linux privilege settings
+.SH SYNOPSIS
+.B setpriv
+.RI [ options ]
+program
+.RI [ arguments ]
+.SH DESCRIPTION
+Sets or queries various Linux privilege settings that are inherited across
+.BR execve (2)
+.
+.SH OPTION
+
+.TP
+.BR \-d,\ --dump
+Dumps current privilege state.  Specify more than once to show extra, mostly useless,
+information.  Incompatible with all other options.
+
+.TP
+.BR \--nnp
+Sets the \fIno_new_privs\fP bit.  With this bit set,
+.BR execve (2)
+will not grant new privileges.  For example, the setuid and setgid bits as
+well as file capabilities will be disabled.  (Executing binaries with these
+bits set will still work, but they will not gain privilege.  Certain LSMs,
+especially AppArmor, may result in failures to execute certain programs.)
+This bit is inherited by child processes and cannot be unset.  See
+.BR prctl (2)
+and
+.IR Documentation/prctl/no_new_privs.txt
+in the Linux kernel source.
+
+The no_new_privs bit is supported since Linux 3.5.
+
+.TP
+.BR \--inh-caps=(+|-)cap,...\ or\ --bounding-set=(+|-)cap,...
+Sets inheritable capabilities or capability bounding set.  See
+.BR capabilities (7).
+The argument is a comma-separated list of +cap and -cap entries,
+which add or remove an entry respectively.  +all and -all can be used
+to add or remove all caps.  The set of capabilities starts out as
+the current inheritable set for --inh-caps and the current bounding set
+for --bounding-set.  If you drop something from the bounding set
+without also dropping it from the inheritable set, you are likely
+to become confused.  Don't do that.
+
+.TP
+.BR \--list-caps
+Lists all known capabilities.  Must be specified alone.
+
+.TP
+.BR \--ruid,\ --euid,\ --reuid
+Sets the real, effective, or both UIDs.
+
+Setting uid or gid does not change capabilities, although the exec
+call at the end might change capabilities.  This means that, if you
+are root, you probably want to do something like:
+
+--reuid=1000 --regid=1000 --caps=-all
+
+.TP
+.BR \--rgid,\ --egid,\ --regid
+Sets the real, effective, or both GIDs.
+
+For safety, you must specify one of --keep-groups, --clear-groups, or --groups if you
+set any primary GID.
+
+.TP
+.BR \--clear-groups
+Clears supplementary groups.
+
+.TP
+.BR \--keep-groups
+Preserves supplementary groups.  Only useful in conjunction with --rgid, --egid,
+or --regid.
+
+.TP
+.BR \--groups=group,...
+Sets supplementary groups.
+
+.TP
+.BR \--securebits=(+|-)securebit,...
+Sets or clears securebits.  The valid securebits are \fInoroot\fP, \fInoroot_locked\fP,
+\fIno_setuid_fixup\fP, \fIno_setuid_fixup_locked\fP, and \fIkeep_caps_locked\fP.
+\fIkeep_caps\fP is cleared by
+.BR execve (2)
+and is therefore not allowed.
+
+.TP
+.BR \--selinux-label
+Requests a particular SELinux transition (using a transition on exec, not dyntrans).
+This will fail and cause
+.BR setpriv (1)
+to abort if SELinux is not in use, and the transition may be ignored or cause
+.BR execve (2)
+to fail at SELinux's whim.  (In particular, this is unlikely to work in conjunction
+with \fIno_new_privs\fP.)
+
+.TP
+.BR \--apparmor-profile
+Requests a particular AppArmor profile (using a transition on exec).
+This will fail and cause
+.BR setpriv (1)
+to abort if AppArmor is not in use, and the transition may be ignored or cause
+.BR execve (2)
+to fail at AppArmor's whim.
+
+.TP
+.BR \-h , " \-\-help"
+Print a help message,
+.SH NOTES
+If applying any specified option fails, \fIprogram\fP will not be run and
+\fIsetpriv\fP will return with exit code 127.
+
+Be careful with this tool -- it may have unexpected security consequences.
+For example, setting no_new_privs and then execing a program that is
+SELinux-confined (as this tool would do) may prevent the SELinux
+restrictions from taking effect.
+.SH SEE ALSO
+.BR prctl (2)
+.BR capability (7)
+.SH BUS
+None known so far.
+.SH AUTHOR
+Andy Lutomirski <luto@amacapital.net>
+.SH AVAILABILITY
+The \fIsetpriv\fP command is part of the util-linux package and is available from
+ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/sys-utils/setpriv.c b/sys-utils/setpriv.c
new file mode 100644
index 0000000..16d0262
--- /dev/null
+++ b/sys-utils/setpriv.c
@@ -0,0 +1,751 @@
+/*
+ * setpriv(1) - set various kernel privilege bits and run something
+ *
+ * Copyright (C) 2012 Andy Lutomirski <luto@amacapital.net>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2, or (at your option) any
+ * later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <errno.h>
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+#include <linux/securebits.h>
+#include <grp.h>
+#include <stdbool.h>
+#include <stdarg.h>
+#include <cap-ng.h>
+
+#include "nls.h"
+#include "c.h"
+#include "closestream.h"
+
+#ifndef PR_SET_NO_NEW_PRIVS
+# define PR_SET_NO_NEW_PRIVS 38
+#endif
+#ifndef PR_GET_NO_NEW_PRIVS
+# define PR_GET_NO_NEW_PRIVS 39
+#endif
+
+static void usage(int status)
+{
+	FILE *out = status == EXIT_SUCCESS ? stdout : stderr;
+
+	fputs(USAGE_HEADER, out);
+	fprintf(out,
+	      _(" %s [options] <program> [args...]\n"), program_invocation_short_name);
+	fputs(_(" -d, --dump           show current state (and don't exec anything)\n"
+	        " --nnp                set no_new_privs\n"
+		" --inh-caps=caps      set inheritable capabilities\n"
+		" --bounding-set=caps  set capability bounding set\n"
+		" --ruid, --euid       set real or effective uid respectively\n"
+		" --rgid, --egid       set real or effective gid respectively\n"
+		" --reuid, --regid     set real and effective uid or gid\n"
+	        " --clear-groups       clear supplementary groups\n"
+	        " --keep-groups        keep supplementary groups\n"
+	        " --groups=group,...   set supplementary groups\n"
+	        " --securebits=bits    set securebits\n"
+		" --selinux-label      set SELinux label (requires process:transition)\n"
+		" --apparmor-profile   set AppArmor profile (requires onexec permission)\n"
+		"\n"
+		" This tool can be dangerous.  Be careful and read the manpage."), out);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("setpriv(1)"));
+
+	exit(status);
+}
+
+static void complain(const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+	fputc('\n', stderr);
+	usage(EXIT_FAILURE);
+}
+
+// Returns the number of capabilities printed
+static int print_caps(FILE *f, capng_type_t which)
+{
+	int n = 0;
+	for (int i = 0; i <= CAP_LAST_CAP; i++) {
+		if (capng_have_capability(which, i)) {
+			if (n)
+				fputc(',', f);
+			fputs(capng_capability_to_name(i), f);
+			n++;
+		}
+	}
+	return n;
+}
+
+static void stdout_perror(const char *prefix)
+{
+	if (errno < 0 || errno >= sys_nerr)
+		printf(_("%s: error %d\n"), prefix, errno);
+	else
+		printf(_("%s: %s\n"), prefix, sys_errlist[errno]);
+}
+
+static void dump_one_secbit(bool *first, int *bits, int bit, const char *name)
+{
+	if (*bits & bit) {
+		if (!*first)
+			printf(",");
+		else
+			*first = false;
+		fputs(name, stdout);
+		*bits &= ~bit;
+	}
+}
+
+static void dump_securebits(void)
+{
+	int bits = prctl(PR_GET_SECUREBITS, 0, 0, 0, 0);
+	if (bits < 0) {
+		stdout_perror("PR_GET_SECUREBITS");
+		return;
+	}
+
+	printf("Securebits: ");
+
+	bool first = true;
+	dump_one_secbit(&first, &bits, SECBIT_NOROOT, "noroot");
+	dump_one_secbit(&first, &bits, SECBIT_NOROOT_LOCKED, "noroot_locked");
+	dump_one_secbit(&first, &bits, SECBIT_NO_SETUID_FIXUP, "no_setuid_fixup");
+	dump_one_secbit(&first, &bits,
+		SECBIT_NO_SETUID_FIXUP_LOCKED, "no_setuid_fixup_locked");
+	bits &= ~SECBIT_KEEP_CAPS;
+	dump_one_secbit(&first, &bits, SECBIT_KEEP_CAPS_LOCKED, "keep_caps_locked");
+	if (bits) {
+		if (!first)
+			printf(",");
+		else
+			first = false;
+		printf("0x%x", (unsigned)bits);
+	}
+
+	if (first)
+		printf("[none]\n");
+	else
+		printf("\n");
+}
+
+static void dump_label(const char *name)
+{
+	int fd = open("/proc/self/attr/current", O_RDONLY);
+	if (fd == -1) {
+		stdout_perror(name);
+		return;
+	}
+
+	char buf[4097];
+	ssize_t len = read(fd, buf, sizeof(buf));
+	int e = errno;
+	close(fd);
+	errno = e;
+	if (len < 0) {
+		stdout_perror(name);
+		return;
+	}
+	if ((size_t)len >= sizeof(buf) - 1) {
+		printf(_("%s: too long\n"), name);
+		return;
+	}
+
+	buf[len] = 0;
+	if (len > 0 && buf[len-1] == '\n')
+		buf[len-1] = 0;
+	printf(_("%s: %s\n"), name, buf);
+}
+
+static void dump_groups(void)
+{
+	int n = getgroups(0, 0);
+	if (n < 0) {
+		stdout_perror("getgroups");
+		return;
+	}
+
+	gid_t *groups = alloca(n * sizeof(gid_t));
+	n = getgroups(n, groups);
+	if (n < 0) {
+		stdout_perror("getgroups");
+		return;
+	}
+
+	printf("Supplementary groups: ");
+	if (n == 0) {
+		printf("[none]");
+	} else {
+		for (int i = 0; i < n; i++) {
+			if (i > 0)
+				printf(",");
+			printf("%ld", (long)groups[i]);
+		}
+	}
+	printf("\n");
+}
+
+static void dump(int dumplevel)
+{
+	int x;
+
+	uid_t ru, eu, su;
+	if (getresuid(&ru, &eu, &su) == 0) {
+		printf("uid: %ld\n", (long)ru);
+		printf("euid: %ld\n", (long)eu);
+		/* Saved and fs uids always equal euid. */
+		if (dumplevel >= 3)
+			printf("suid: %ld\n", (long)su);
+	} else {
+		stdout_perror("getresuid");
+	}
+
+	gid_t rg, eg, sg;
+	if (getresgid(&rg, &eg, &sg) == 0) {
+		printf("gid: %ld\n", (long)rg);
+		printf("egid: %ld\n", (long)eg);
+		/* Saved and fs gids always equal egid. */
+		if (dumplevel >= 3)
+			printf("sgid: %ld\n", (long)sg);
+	} else {
+		stdout_perror("getresgid");
+	}
+
+	dump_groups();
+
+	x = prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0);
+	if (x >= 0)
+		printf("no_new_privs: %d\n", x);
+	else
+		stdout_perror("no_new_privs");
+
+	if (dumplevel >= 2) {
+		printf(_("Effective capabilities: "));
+		if (print_caps(stdout, CAPNG_EFFECTIVE) == 0)
+			printf("[none]");
+		printf("\n");
+
+		printf(_("Permitted capabilities: "));
+		if (print_caps(stdout, CAPNG_PERMITTED) == 0)
+			printf("[none]");
+		printf("\n");
+	}
+
+	printf(_("Inheritable capabilities: "));
+	if (print_caps(stdout, CAPNG_INHERITABLE) == 0)
+		printf("[none]");
+	printf("\n");
+
+	printf(_("Capability bounding set: "));
+	if (print_caps(stdout, CAPNG_BOUNDING_SET) == 0)
+		printf("[none]");
+	printf("\n");
+
+	dump_securebits();
+
+	if (access("/sys/fs/selinux", F_OK) == 0)
+		dump_label("SELinux label");
+
+	if (access("/sys/kernel/security/apparmor", F_OK) == 0) {
+		dump_label("AppArmor profile");
+	}
+}
+
+static void list_known_caps(void)
+{
+	for (int i = 0; i <= CAP_LAST_CAP; i++)
+		printf("%s\n", capng_capability_to_name(i));
+}
+
+struct options {
+	bool nnp;
+
+	// real and effective (in that order)
+	bool have_uid[2];
+	uid_t uid[2];
+	bool have_gid[2];
+	gid_t gid[2];
+
+	// supplementary groups
+	bool have_groups, keep_groups, clear_groups;
+	size_t num_groups;
+	gid_t *groups;
+
+	// caps
+	const char *caps_to_inherit;
+	const char *bounding_set;
+
+	// securebits
+	bool have_securebits;
+	int securebits;
+
+	// LSMs
+	const char *selinux_label;
+	const char *apparmor_profile;
+};
+
+static void priverr(const char *str)
+{
+	perror(str);
+	exit(127);
+}
+
+static void parse_groups(struct options *opts, const char *str)
+{
+	char *groups = strdup(str);
+	char *buf = groups;  /* We'll reuse it */
+	char *c;
+
+	opts->have_groups = true;
+	opts->num_groups = 0;
+	while ((c = strsep(&groups, ",")) != 0)
+		opts->num_groups++;
+
+	// Start again
+	strcpy(buf, str);  // It's exactly the right length
+	groups = buf;
+
+	opts->groups = calloc(opts->num_groups, sizeof(gid_t));
+	size_t i = 0;
+	while ((c = strsep(&groups, ",")) != 0) {
+		char *end;
+		errno = 0;
+		long val = strtol(c, &end, 10);
+		if (!*c || *end || errno || val != (long long)(gid_t)val)
+			complain(_("Invalid supplementary group id"));
+		opts->groups[i++] = (gid_t)val;
+	}
+
+	free(groups);;
+}
+
+static void do_setresuid(const struct options *opts)
+{
+	uid_t id[3];
+	if (getresuid(&id[0], &id[1], &id[2]) != 0)
+		priverr("getresuid failed");
+	for (int i = 0; i < 2; i++)
+		if (opts->have_uid[i])
+			id[i] = opts->uid[i];
+
+	/* Also copy effective to saved (for paranoia). */
+	if (setresuid(id[0], id[1], id[1]) != 0)
+		priverr("setresuid failed");
+}
+
+static void do_setresgid(const struct options *opts)
+{
+	gid_t id[3];
+	if (getresgid(&id[0], &id[1], &id[2]) != 0)
+		priverr("getresgid failed");
+	for (int i = 0; i < 2; i++)
+		if (opts->have_gid[i])
+			id[i] = opts->gid[i];
+
+	/* Also copy effective to saved (for paranoia). */
+	if (setresgid(id[0], id[1], id[1]) != 0)
+		priverr("setresgid failed");
+}
+
+static void bump_cap(unsigned int cap)
+{
+	if (capng_have_capability(CAPNG_PERMITTED, cap))
+		capng_update(CAPNG_ADD, CAPNG_EFFECTIVE, cap);
+}
+
+static void do_caps(capng_type_t type, const char *caps)
+{
+	char *my_caps = strdup(caps);  /* Don't bother checking for error */
+
+	char *c;
+	while ((c = strsep(&my_caps, ",")) != 0) {
+		capng_act_t action;
+		if (*c == '+')
+			action = CAPNG_ADD;
+		else if (*c == '-')
+			action = CAPNG_DROP;
+		else
+			complain(_("Bad capability string"));
+
+		if (!strcmp(c+1, "all")) {
+			for (int i = 0; i <= CAP_LAST_CAP; i++)
+				capng_update(action, type, i);
+		} else {
+			int cap = capng_name_to_capability(c+1);
+			if (cap >= 0)
+				capng_update(action, type, cap);
+			else
+				complain(_("Unknown capability \"%s\""), c+1);
+		}
+	}
+
+	free(my_caps);
+}
+
+static void parse_securebits(struct options *opts, const char *arg)
+{
+	opts->have_securebits = true;
+	opts->securebits = prctl(PR_GET_SECUREBITS, 0, 0, 0, 0);
+	if (opts->securebits < 0)
+		priverr("PR_GET_SECUREBITS");
+
+	if (opts->securebits & ~(int)(SECBIT_NOROOT | SECBIT_NOROOT_LOCKED |
+		SECBIT_NO_SETUID_FIXUP | SECBIT_NO_SETUID_FIXUP_LOCKED |
+		SECBIT_KEEP_CAPS | SECBIT_KEEP_CAPS_LOCKED))
+	{
+		priverr(_("Unrecognized securebit is set -- refusing to adjust"));
+	}
+
+	char *buf = strdup(arg);
+
+	char *c;
+	while ((c = strsep(&buf, ",")) != 0) {
+		if (*c != '+' && *c != '-')
+			complain(_("Bad securebits string"));
+
+		if (!strcmp(c+1, "all")) {
+			if (*c == '-')
+				opts->securebits = 0;
+			else
+				complain(_("+all securebits is not allowed"));
+		} else {
+			int bit;
+			if (!strcmp(c+1, "noroot"))
+				bit = SECBIT_NOROOT;
+			else if (!strcmp(c+1, "noroot_locked"))
+				bit = SECBIT_NOROOT_LOCKED;
+			else if (!strcmp(c+1, "no_setuid_fixup"))
+				bit = SECBIT_NO_SETUID_FIXUP;
+			else if (!strcmp(c+1, "no_setuid_fixup_locked"))
+				bit = SECBIT_NO_SETUID_FIXUP_LOCKED;
+			else if (!strcmp(c+1, "keep_caps"))
+				complain(_("Adjusting keep_caps makes no sense"));
+			else if (!strcmp(c+1, "keep_caps_locked"))
+				bit = SECBIT_KEEP_CAPS_LOCKED;  /* sigh */
+			else
+				complain(_("Unrecognized securebit"));
+
+			if (*c == '+')
+				opts->securebits |= bit;
+			else
+				opts->securebits &= ~bit;
+		}
+	}
+
+	opts->securebits |= SECBIT_KEEP_CAPS;  /* We need it, and it's reset on exec */
+
+	free(buf);	                              
+}
+
+static void do_selinux_label(const char *label)
+{
+	if (access("/sys/fs/selinux", F_OK) != 0) {
+		fputs("SELinux is not running\n", stderr);
+		exit(127);
+	}
+
+	int fd = open("/proc/self/attr/exec", O_RDWR);
+	if (fd == -1)
+		priverr("open /proc/self/attr/exec for selinux");
+
+	size_t len = strlen(label);
+	errno = 0;
+	if (write(fd, label, len) != (ssize_t)len)
+		priverr("write /proc/self/attr/exec for selinux");
+
+	close(fd);
+}
+
+static void do_apparmor_profile(const char *label)
+{
+	if (access("/sys/kernel/security/apparmor", F_OK) != 0) {
+		fputs("AppArmor is not running\n", stderr);
+		exit(127);
+	}
+
+	FILE *f = fopen("/proc/self/attr/exec", "wx");
+	if (!f)
+		priverr("open /proc/self/attr/exec for apparmor");
+
+	if (fprintf(f, "changeprofile %s", label) < 0 || fflush(f) != 0 || fclose(f) != 0)
+		priverr("write /proc/self/attr/exec for apparmor");
+}
+
+int main(int argc, char *argv[])
+{
+	enum {
+		NNP = 256,
+		RUID = 256,
+		EUID,
+		RGID,
+		EGID,
+		REUID,
+		REGID,
+		CLEAR_GROUPS,
+		KEEP_GROUPS,
+		GROUPS,
+		INHCAPS,
+		LISTCAPS,
+		CAPBSET,
+		SECUREBITS,
+		SELINUX_LABEL,
+		APPARMOR_PROFILE
+	};
+		
+	static const struct option longopts[] = {
+		{ "dump", no_argument, 0, 'd' },
+		{ "nnp", no_argument, 0, NNP },
+		{ "inh-caps", required_argument, 0, INHCAPS },
+		{ "list-caps", no_argument, 0, LISTCAPS },
+		{ "ruid", required_argument, 0, RUID },
+		{ "euid", required_argument, 0, EUID },
+		{ "rgid", required_argument, 0, RGID },
+		{ "egid", required_argument, 0, EGID },
+		{ "reuid", required_argument, 0, REUID },
+		{ "regid", required_argument, 0, REGID },
+		{ "clear-groups", no_argument, 0, CLEAR_GROUPS },
+		{ "keep-groups", no_argument, 0, KEEP_GROUPS },
+		{ "groups", required_argument, 0, GROUPS },
+		{ "bounding-set", required_argument, 0, CAPBSET },
+		{ "securebits", required_argument, 0, SECUREBITS },
+		{ "selinux-label", required_argument, 0, SELINUX_LABEL },
+		{ "apparmor-profile", required_argument, 0, APPARMOR_PROFILE },
+		{ "help", no_argument, 0, 'h' },
+		{ "version", no_argument, 0, 'V'},
+		{ NULL, 0, 0, 0 }
+	};
+
+	int c;
+	struct options opts;
+	int dumplevel = 0, total_opts = 0;
+	bool list_caps = false;
+
+	setlocale(LC_MESSAGES, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	memset(&opts, 0, sizeof(opts));
+
+	while((c = getopt_long(argc, argv, "+dhV", longopts, NULL)) != -1) {
+		total_opts++;
+
+		if (RUID <= c && c <= REGID) {
+			/* This is easier than six independent cases. */
+			char *end;
+			errno = 0;
+			long val = strtol(optarg, &end, 10);
+			if (!*optarg || errno || *end)
+				complain(_("Failed to parse uid or gid"));
+
+			if (c == REUID) {
+				for (int i = 0; i < 2; i++) {
+					if (opts.have_uid[i])
+						complain(_("Duplicate uid"));
+					opts.have_uid[i] = true;
+					opts.uid[i] = val;
+					if (opts.uid[i] != val)
+						complain(_("uid out of range"));
+				}
+			} else if (c == REGID) {
+				for (int i = 0; i < 2; i++) {
+					if (opts.have_gid[i])
+						complain(_("Duplicate gid"));
+					opts.have_gid[i] = true;
+					opts.gid[i] = val;
+					if (opts.gid[i] != val)
+						complain(_("gid out of range"));
+				}
+			} else {
+				bool *have = (c <= EUID ? &opts.have_uid[c-RUID]
+					      : &opts.have_gid[c-RGID]);
+				if (*have)
+					complain(_("Duplicate uid or gid"));
+				*have = true;
+				if (c <= EUID)
+					opts.uid[c-RUID] = val;
+				else
+					opts.gid[c-RGID] = val;
+				if ((c <= EUID ? opts.uid[c-RUID] : opts.gid[c-RGID]) !=
+				    val)
+					complain(_("uid or gid out of range"));
+			}
+
+			continue;
+		}
+
+		switch(c) {
+		case 'd':
+			dumplevel++;
+			break;
+		case NNP:
+			if (opts.nnp)
+				complain(_("Duplicate --nnp option"));
+			opts.nnp = true;
+			break;
+		case CLEAR_GROUPS:
+			if (opts.clear_groups)
+				complain(_("Duplicate --clear-groups option"));
+			opts.clear_groups = true;
+			break;
+		case KEEP_GROUPS:
+			if (opts.keep_groups)
+				complain(_("Duplicate --keep-groups option"));
+			opts.keep_groups = true;
+			break;
+		case GROUPS:
+			if (opts.have_groups)
+				complain(_("Duplicate --groups option"));
+			parse_groups(&opts, optarg);
+			break;
+		case LISTCAPS:
+			list_caps = true;
+			break;
+		case INHCAPS:
+			if (opts.caps_to_inherit)
+				complain(_("Duplicate --caps option"));
+			opts.caps_to_inherit = optarg;
+			break;
+		case CAPBSET:
+			if (opts.bounding_set)
+				complain(_("Duplicate --bounding-set option"));
+			opts.bounding_set = optarg;
+			break;
+		case SECUREBITS:
+			if (opts.have_securebits)
+				complain(_("Duplicate --securebits option"));
+			parse_securebits(&opts, optarg);
+			break;
+		case SELINUX_LABEL:
+			if (opts.selinux_label)
+				complain(_("Duplicate --selinux-label option"));
+			opts.selinux_label = optarg;
+			break;
+		case APPARMOR_PROFILE:
+			if (opts.apparmor_profile)
+				complain(_("Duplicate --apparmor-profile option"));
+			opts.apparmor_profile = optarg;
+			break;
+		case 'h':
+			usage(EXIT_SUCCESS);
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		default:
+			complain(_("Unrecognized option '%c'\n"), c);
+		}
+	}
+
+	if (dumplevel) {
+		if (total_opts != dumplevel || optind < argc)
+			complain(_("--dump is incompatible with all other options"));
+		dump(dumplevel);
+		return 0;
+	}
+
+	if (list_caps) {
+		if (total_opts != 1 || optind < argc)
+			complain(_("--list-caps must be specified alone"));
+		list_known_caps();
+		return 0;
+	}
+
+	if (optind >= argc)
+		complain(_("No program specified"));
+
+	if ((opts.have_gid[0] || opts.have_gid[1])
+	    && !opts.keep_groups && !opts.clear_groups && !opts.have_groups)
+		complain(_("--[re]gid requires --keep-groups, --clear-groups, or --groups"));
+
+	if ((int)opts.keep_groups + (int)opts.clear_groups + (int)opts.have_groups > 1)
+		complain(_("Too many of --keep-groups, --clear-groups, or --groups"));
+
+	if (opts.nnp) {
+		if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) == -1)
+			err(EXIT_FAILURE, _("PR_SET_NO_NEW_PRIVS failed"));
+	}
+
+	if (opts.selinux_label)
+		do_selinux_label(opts.selinux_label);
+	if (opts.apparmor_profile)
+		do_apparmor_profile(opts.apparmor_profile);
+
+	if (prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0) == -1)
+		err(EXIT_FAILURE, _("PR_SET_KEEPCAPS failed"));
+
+	// We're going to want CAP_SETPCAP, CAP_SETUID, and CAP_SETGID if possible.
+	bump_cap(CAP_SETPCAP);
+	bump_cap(CAP_SETUID);
+	bump_cap(CAP_SETGID);
+	if (capng_apply(CAPNG_SELECT_CAPS) != 0)
+		priverr("activate capabilities");
+
+	for (int i = 0; i < 2; i++) {
+		if (opts.have_uid[i]) {
+			do_setresuid(&opts);
+
+			/* KEEPCAPS doesn't work for the effective mask. */
+			if (capng_apply(CAPNG_SELECT_CAPS) != 0)
+				priverr("reactivate capabilities");
+			break;
+		}
+	}
+
+	for (int i = 0; i < 2; i++) {
+		if (opts.have_gid[i]) {
+			do_setresgid(&opts);
+			break;
+		}
+	}
+
+	if (opts.have_groups) {
+		if (setgroups(opts.num_groups, opts.groups) != 0)
+			priverr("setgroups");
+	} else if (opts.clear_groups) {
+		gid_t x = 0;
+		if (setgroups(0, &x) != 0)
+			priverr("setgroups");
+	}
+
+	if (opts.have_securebits) {
+		if (prctl(PR_SET_SECUREBITS, opts.securebits, 0, 0, 0) != 0)
+			priverr("PR_SET_SECUREBITS");
+	}
+
+	if (opts.bounding_set) {
+		do_caps(CAPNG_BOUNDING_SET, opts.bounding_set);
+		errno = EPERM;  /* capng doesn't set errno if we're missing CAP_SETPCAP */
+		if (capng_apply(CAPNG_SELECT_BOUNDS) != 0)
+			priverr("apply bounding set");
+	}
+
+	if (opts.caps_to_inherit) {
+		do_caps(CAPNG_INHERITABLE, opts.caps_to_inherit);
+		if (capng_apply(CAPNG_SELECT_CAPS) != 0)
+			priverr("apply capabilities");
+	}
+
+	execvp(argv[optind], argv + optind);
+
+	err(127, _("exec %s failed"), argv[optind]);
+}
-- 
1.7.11.7

