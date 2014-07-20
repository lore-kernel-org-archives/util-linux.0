Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:60258 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750732AbaGTVPx (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 20 Jul 2014 17:15:53 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] docs: bring five more man pages closer to standard formatting
Date: Sun, 20 Jul 2014 23:15:46 +0200
Message-Id: <1405890948-4884-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also, for renice, adapt the descriptions to the behaviour: the -g,
-p and -u options do not actually need to be followed by any ID.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/nsenter.1 |    2 +-
 sys-utils/renice.1  |   18 +++++-----
 sys-utils/setpriv.1 |   92 +++++++++++++++++++++++++++------------------------
 sys-utils/setsid.1  |   12 +++---
 sys-utils/unshare.1 |   24 +++++++-------
 5 files changed, 77 insertions(+), 71 deletions(-)

diff --git a/sys-utils/nsenter.1 b/sys-utils/nsenter.1
index 3964ee5..998fd0c 100644
--- a/sys-utils/nsenter.1
+++ b/sys-utils/nsenter.1
@@ -3,7 +3,7 @@
 nsenter \- run program with namespaces of other processes
 .SH SYNOPSIS
 .B nsenter
-.RI [ options ]
+[options]
 .RI [ program
 .RI [ arguments ]]
 .SH DESCRIPTION
diff --git a/sys-utils/renice.1 b/sys-utils/renice.1
index 8a332e1..5a4fcab 100644
--- a/sys-utils/renice.1
+++ b/sys-utils/renice.1
@@ -31,14 +31,14 @@
 .\"
 .\"     @(#)renice.8   8.1 (Berkeley) 6/9/93
 .\"
-.TH RENICE "1" "September 2011" "util-linux" "User Commands"
+.TH RENICE "1" "July 2014" "util-linux" "User Commands"
 .SH NAME
 renice \- alter priority of running processes
 .SH SYNOPSIS
 .B renice
 .RB [ \-n ]
 .I priority
-.RB [ \-gpu ]
+.RB [ \-g | \-p | \-u ]
 .IR identifier ...
 .SH DESCRIPTION
 .B renice
@@ -62,16 +62,16 @@ to be used for the process, process group, or user.  Use of the option
 .BR \-n " or " \-\-priority
 is optional, but when used it must be the first argument.
 .TP
-.BR \-g , " \-\-pgrp " \fIpgid\fR...
-Force the succeeding arguments to be interpreted as process group IDs.
+.BR \-g , " \-\-pgrp
+Interpret the succeeding arguments as process group IDs.
 .TP
-.BR \-u , " \-\-user " \fIname_or_uid\fR...
-Force the succeeding arguments to be interpreted as usernames or UIDs.
-.TP
-.BR \-p , " \-\-pid " \fIpid\fR...
-Force the succeeding arguments to be interpreted as process IDs
+.BR \-p , " \-\-pid
+Interpret the succeeding arguments as process IDs
 (the default).
 .TP
+.BR \-u , " \-\-user
+Interpret the succeeding arguments as usernames or UIDs.
+.TP
 .BR \-h , " \-\-help"
 Display help text and exit.
 .TP
diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index 62467ad..f627aeb 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -1,10 +1,10 @@
-.TH SETPRIV 1 "January 2013" "util-linux" "User Commands"
+.TH SETPRIV 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 setpriv \- run a program with different Linux privilege settings
 .SH SYNOPSIS
 .B setpriv
-.RI [ options ]
-program
+[options]
+.I program
 .RI [ arguments ]
 .SH DESCRIPTION
 Sets or queries various Linux privilege settings that are inherited across
@@ -12,50 +12,50 @@ Sets or queries various Linux privilege settings that are inherited across
 .SH OPTION
 .TP
 \fB\-d\fR, \fB\-\-dump\fR
-Dumps current privilege state.  Specify more than once to show extra, mostly
-useless, information.  Incompatible with all other options.
+Dump current privilege state.  Can be specified more than once to show extra,
+mostly useless, information.  Incompatible with all other options.
 .TP
 \fB\-\-no\-new\-privs\fR
-Sets the
-.I no_\:new_\:privs
+Set the
+.I no_new_privs
 bit.  With this bit set,
 .BR execve (2)
 will not grant new privileges.  For example, the setuid and setgid bits as well
 as file capabilities will be disabled.  (Executing binaries with these bits set
-will still work, but they will not gain privilege.  Certain LSMs, especially
-AppArmor, may result in failures to execute certain programs.) This bit is
+will still work, but they will not gain privileges.  Certain LSMs, especially
+AppArmor, may result in failures to execute certain programs.)  This bit is
 inherited by child processes and cannot be unset.  See
 .BR prctl (2)
 and
 .IR Documentation/\:prctl/\:no_\:new_\:privs.txt
 in the Linux kernel source.
 .IP
-The no_\:new_\:privs bit is supported since Linux 3.5.
+The no_new_privs bit is supported since Linux 3.5.
 .TP
-\fB\-\-inh\-caps\fR \fI(+|\-)cap\fR,\fI...\fR or \fB\-\-bounding\-set\fR \fI(+|\-)cap\fR,\fI...\fR
-Sets inheritable capabilities or capability bounding set.  See
+.B \-\-inh\-caps \fR(\fB+\fR|\fB\-\fR)\fIcap\fR... or \fB\-\-bounding\-set \fR(\fB+\fR|\fB\-\fR)\fIcap\fR...
+Set the inheritable capabilities or the capability bounding set.  See
 .BR capabilities (7).
 The argument is a comma-separated list of
-.I +cap
+.BI + cap
 and
-.I \-cap
+.BI \- cap
 entries, which add or remove an entry respectively.
-.I +all
+.B +all
 and
-.I \-all
+.B \-all
 can be used to add or remove all caps.  The set of capabilities starts out as
 the current inheritable set for
-.B \-\-\:inh\-\:caps
+.B \-\-inh\-caps
 and the current bounding set for
-.BR \-\-\:bounding\-\:set .
+.BR \-\-bounding\-set .
 If you drop something from the bounding set without also dropping it from the
 inheritable set, you are likely to become confused.  Do not do that.
 .TP
 .BR \-\-list\-caps
-Lists all known capabilities.  Must be specified alone.
+List all known capabilities.  This option must be specified alone.
 .TP
 \fB\-\-ruid\fR \fIuid\fR, \fB\-\-euid\fR \fIuid\fR, \fB\-\-reuid\fR \fIuid\fR
-Sets the real, effective, or both \fIuid\fRs.  The uid argument can be
+Set the real, effective, or both uids.  The \fIuid\fR argument can be
 given as textual login name.
 .IP
 Setting
@@ -66,53 +66,59 @@ does not change capabilities, although the exec call at the end might change
 capabilities.  This means that, if you are root, you probably want to do
 something like:
 .IP
-\-\-reuid=1000 \-\-\:regid=1000 \-\-\:caps=\-\:all
+\-\-reuid=1000 \-\-regid=1000 \-\-caps=\-all
 .TP
 \fB\-\-rgid\fR \fIgid\fR, \fB\-\-egid\fR \fIgid\fR, \fB\-\-regid\fR \fIgid\fR
-Sets the real, effective, or both \fIgid\fRs.  The gid argument can be
+Set the real, effective, or both gids.  The \fIgid\fR argument can be
 given as textual group name.
 .IP
-For safety, you must specify one of \-\-\:keep\-\:groups,
-\-\-\:clear\-\:groups, or \-\-\:groups if you set any primary
+For safety, you must specify one of
+.BR \-\-keep\-groups ,
+.BR \-\-clear\-groups ", or"
+.B \-\-groups
+if you set any primary
 .IR gid .
 .TP
-.BR \-\-clear\-groups
-Clears supplementary groups.
+.B \-\-clear\-groups
+Clear supplementary groups.
 .TP
-\fB\-\-keep\-groups\fR
-Preserves supplementary groups.  Only useful in conjunction with \-\-rgid,
-\-\-egid, or \-\-regid.
+.B \-\-keep\-groups
+Preserve supplementary groups.  Only useful in conjunction with
+.BR \-\-rgid ,
+.BR \-\-egid ", or"
+.BR \-\-regid .
 .TP
-\fB\-\-groups\fR \fIgroup\fR,\fI...\fR
-Sets supplementary groups.
+.B \-\-groups \fIgroup\fR...
+Set supplementary groups.  The argument is a comma-separated list.
 .TP
-\fB\-\-securebits\fR \fI(+|\-)securebit\fR,\fI...\fR
-Sets or clears securebits.  The valid securebits are
+.B \-\-securebits \fR(\fB+\fR|\fB\-\fR)\fIsecurebit\fR...
+Set or clear securebits.  The argument is a comma-separated list.
+The valid securebits are
 .IR noroot ,
-.IR noroot_\:locked ,
-.IR no_\:setuid_\:fixup ,
-.IR no_\:setuid_\:fixup_\:locked ,
+.IR noroot_locked ,
+.IR no_setuid_fixup ,
+.IR no_setuid_fixup_locked ,
 and
-.IR keep_\:caps_\:locked .
-.I keep_\:caps
+.IR keep_caps_locked .
+.I keep_caps
 is cleared by
 .BR execve (2)
 and is therefore not allowed.
 .TP
 \fB\-\-selinux\-label\fR \fIlabel\fR
-Requests a particular SELinux transition (using a transition on exec, not
+Request a particular SELinux transition (using a transition on exec, not
 dyntrans).  This will fail and cause
 .BR setpriv (1)
 to abort if SELinux is not in use, and the transition may be ignored or cause
 .BR execve (2)
 to fail at SELinux's whim.  (In particular, this is unlikely to work in
 conjunction with
-.IR no_\:new_\:privs .)
+.IR no_new_privs .)
 This is similar to
 .BR runcon (1).
 .TP
 \fB\-\-apparmor\-profile\fR \fIprofile\fR
-Requests a particular AppArmor profile (using a transition on exec).  This will
+Request a particular AppArmor profile (using a transition on exec).  This will
 fail and cause
 .BR setpriv (1)
 to abort if AppArmor is not in use, and the transition may be ignored or cause
@@ -132,8 +138,8 @@ will not be run and
 will return with exit code 127.
 .PP
 Be careful with this tool \-\- it may have unexpected security consequences.
-For example, setting no_\:new_\:privs and then execing a program that is
-SELinux\-\:confined (as this tool would do) may prevent the SELinux
+For example, setting no_new_privs and then execing a program that is
+SELinux\-confined (as this tool would do) may prevent the SELinux
 restrictions from taking effect.
 .SH SEE ALSO
 .BR prctl (2),
diff --git a/sys-utils/setsid.1 b/sys-utils/setsid.1
index da8d648..70e5079 100644
--- a/sys-utils/setsid.1
+++ b/sys-utils/setsid.1
@@ -1,24 +1,24 @@
 .\" Rick Sladkey <jrs@world.std.com>
 .\" In the public domain.
 .\" Path modifications by faith@cs.unc.edu
-.TH SETSID 1 "November 1993" "util-linux" "User Commands"
+.TH SETSID 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 setsid \- run a program in a new session
 .SH SYNOPSIS
 .B setsid
 .I program
-.RI [ arg ...]
+.RI [ argument ...]
 .SH DESCRIPTION
 .B setsid
 runs a program in a new session.
 .SH OPTIONS
 .TP
-\fB\-c\fP, \fB\-\-ctty\fP
+.BR \-c , " \-\-ctty"
 Set the controlling terminal to the current one.
 .TP
-\fB\-w\fP, \fB\-\-wait\fP
-Wait the execution of the program to end, and return the exit value of
-the child as return value of the
+.BR \-w , " \-\-wait"
+Wait for the execution of the program to end, and return the exit value of
+this program as the return value of
 .BR setsid .
 .SH "SEE ALSO"
 .BR setsid (2)
diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 41ea2ec..9342262 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -1,17 +1,17 @@
 .\" Process this file with
 .\" groff -man -Tascii lscpu.1
 .\"
-.TH UNSHARE 1 "July 2013" "util-linux" "User Commands"
+.TH UNSHARE 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 unshare \- run program with some namespaces unshared from parent
 .SH SYNOPSIS
 .B unshare
-.RI [ options ]
+[options]
 .I program
 .RI [ arguments ]
 .SH DESCRIPTION
 Unshares the indicated namespaces from the parent process and then executes
-the specified program.  The namespaces to be unshared are indicated via
+the specified \fIprogram\fR.  The namespaces to be unshared are indicated via
 options.  Unshareable namespaces are:
 .TP
 .BR "mount namespace"
@@ -19,10 +19,10 @@ Mounting and unmounting filesystems will not affect the rest of the system
 (\fBCLONE_NEWNS\fP flag), except for filesystems which are explicitly marked as
 shared (with \fBmount --make-shared\fP; see \fI/proc/self/mountinfo\fP for the
 \fBshared\fP flags).
-
+.sp
 It's recommended to use \fBmount --make-rprivate\fP or \fBmount --make-rslave\fP
 after \fBunshare --mount\fP to make sure that mountpoints in the new namespace
-are really unshared from parental namespace.
+are really unshared from the parental namespace.
 .TP
 .BR "UTS namespace"
 Setting hostname or domainname will not affect the rest of the system.
@@ -75,18 +75,18 @@ Fork the specified \fIprogram\fR as a child process of \fBunshare\fR rather than
 running it directly.  This is useful when creating a new pid namespace.
 .TP
 .BR \-\-mount-proc "[=\fImountpoint\fP]"
-Just before running the program, mount the proc filesystem at the \fImountpoint\fP
+Just before running the program, mount the proc filesystem at \fImountpoint\fP
 (default is /proc).  This is useful when creating a new pid namespace.  It also
 implies creating a new mount namespace since the /proc mount would otherwise
-mess up existing programs on the system. The new proc filesystem is explicitly
+mess up existing programs on the system.  The new proc filesystem is explicitly
 mounted as private (by MS_PRIVATE|MS_REC).
 .TP
 .BR \-r , " \-\-map-root-user"
-Run the program only after current effective user and group ID have been mapped to
-superuser UID and GID in newly created user namespace. This makes it possible to
-conveniently gain capabilities needed to manage various aspects of newly created
-namespaces (such as configure interfaces in network namespace or mount filesystems in
-mount) even when run unprivileged. As a convenience feature, it does not support
+Run the program only after the current effective user and group IDs have been mapped to
+the superuser UID and GID in the newly created user namespace.  This makes it possible to
+conveniently gain capabilities needed to manage various aspects of the newly created
+namespaces (such as configuring interfaces in the network namespace or mounting filesystems in
+the mount namespace) even when run unprivileged.  As a mere convenience feature, it does not support
 more sophisticated use cases, such as mapping multiple ranges of UIDs and GIDs.
 .SH SEE ALSO
 .BR unshare (2),
-- 
1.7.0.4

