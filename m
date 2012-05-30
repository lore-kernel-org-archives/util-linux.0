Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:54547 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756327Ab2E3SE3 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 30 May 2012 14:04:29 -0400
Received: by weyu7 with SMTP id u7so60493wey.19
        for <util-linux-ng@vger.kernel.org>; Wed, 30 May 2012 11:04:28 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Wed, 30 May 2012 20:04:27 +0200
Message-ID: <CAG27Bk3YrUc4cwpUou5o005S165LOc4C8bPHp-EnkwAz2WsFng@mail.gmail.com>
Subject: [pull] su.1 manual page
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux-ng@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Please find from my git a su(1) manual page candidate.  The text is
almost one to one copy with GNU Coreutils 'su invocation' info page,
so it is questionable if I "wrote" the man page.  To feel a little
less quilty stealing I added few examples, fix to return values, hint
about PAM configuration file and authors sections.

The other patch is a fix to groff macro usage error I spot in howto-man
while writing the su.1 file.


The following changes since commit 71681ee5ecd24ac19747dc692f2350a212e448e9:

  build-sys: move configure login options to one place (2012-05-29
15:24:04 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git su.1

for you to fetch changes up to deb744fbb7f7f5a52630d587691204eccfa48120:

  docs: fix email macro in manual example (2012-05-30 19:49:37 +0200)

----------------------------------------------------------------
Sami Kerola (2):
      docs: add su.1 manual page
      docs: fix email macro in manual example

 Documentation/howto-man-page.txt |    8 +-
 login-utils/su.1                 |  178 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+), 4 deletions(-)
 create mode 100644 login-utils/su.1

diff --git a/Documentation/howto-man-page.txt b/Documentation/howto-man-page.txt
index c217962..5ca4af0 100644
--- a/Documentation/howto-man-page.txt
+++ b/Documentation/howto-man-page.txt
@@ -143,13 +143,13 @@ etc
 .PD
 .RE
 .SH AUTHORS
-.UR rjh@\:example.org
+.MT rjh@\:example.org
 Random J. Hacker
-.UE
+.ME
 .br
-.UR fred@\:example.com
+.MT fred@\:example.com
 Fred Foobar
-.UE
+.ME
 .SH "SEE ALSO"
 .BR groff_man (7),
 .BR foo (1),
diff --git a/login-utils/su.1 b/login-utils/su.1
new file mode 100644
index 0000000..1847325
--- /dev/null
+++ b/login-utils/su.1
@@ -0,0 +1,178 @@
+.\" Contents of this manual page is copied from GNU Coreutils
+.\" info page at end of May 2012, with few additions such as
+.\" examples and see also sections.
+.TH SU "1" "May 2012" "util-linux" "User Commands"
+.SH NAME
+su \- run a shell with substitute user and group IDs
+.SH SYNOPSIS
+.B su
+[options] [\-]
+.I user
+[args]
+.SH DESCRIPTION
+.B su
+allows one user to temporarily become another user.  It runs a
+command (often an interactive shell) with the real and effective user
+ID, group ID, and supplemental groups of a given user.
+.PP
+If no user is given, the default is root, the super-user.  The shell
+to use is taken from user's passwd entry, or /bin/sh if none is
+specified there.  If user has a password,
+.B su
+prompts for the password unless run by a user with effective user ID
+of zero (the super-user).
+.PP
+By default,
+.B su
+does not change the current directory.  It sets the environment
+variables HOME and SHELL from the password entry for user, and if
+user is not the super-user, sets USER and LOGNAME to user.  By
+default, the shell is not a login shell.
+.PP
+Any additional
+.I args
+are passed as additional arguments to the shell.
+.PP
+.B su
+does not treat /bin/sh or any other shells specially (e.g., by
+setting argv[0] to -su, passing -c only to certain shells, etc.).
+.PP
+.B su
+can optionally be compiled to use syslog to report failed, and
+optionally successful,
+.B su
+attempts.  (If the system supports syslog.)  However,
+.B su
+does not check if the user is a member of the wheel group; see
+.BR NOTES .
+.SH OPTIONS
+.TP
+\fB\-c\fR, \fB\-\-command\fR [\fIcommand\fR]
+Pass command, a single command line to run, to the shell with a
+.I \-c
+option instead of starting an interactive shell.
+.TP
+\fB\-f\fR, \fB\-\-fast\fR
+Pass the
+.I \-f
+option to the shell.  This probably only makes sense if the shell run
+is csh or tcsh, for which the
+.I \-f
+option prevents reading the startup file (.cshrc).  With Bourne-like
+shells, the
+.I -f
+option disables file name pattern expansion (globbing), which is not
+likely to be useful.
+.TP
+\fB\-\fR, \fB\-l\fR, \fB\-\-login\fR
+Make the shell a login shell.  This means the following.  Unset all
+environment variables except TERM, HOME, and SHELL (which are set as
+described above), and USER and LOGNAME (which are set, even for the
+super-user, as described above), and set PATH to a compiled-in
+default value.  Change to user's home directory.  Prepend  '\-' to the
+shell's name, intended to make it read its login startup file(s).
+.TP
+\fB\-m\fR, \fB\-p\fR, \fB\-\-preserve\-environment\fR
+Do not change the environment variables HOME, USER, LOGNAME, or
+SHELL.  Run the shell given in the environment variable SHELL instead
+of the shell from user's passwd entry, unless the user running
+.B su
+is not the super-user and user's shell is restricted.  A restricted
+shell is one that is not listed in the file /etc/shells, or in a
+compiled-in list if that file does not exist.  Parts of what this
+option does can be overridden by
+.I \-\-login
+and
+.IR \-\-shell .
+.TP
+\fB\-s\fR, \fB\-\-shell\fR [\fIshell\fR]
+Run shell instead of the shell from user's passwd entry, unless the
+user running
+.B su
+is not the super-user and user's shell is restricted (see
+.I -m
+just above).
+.SH EXAMPLES
+.TP
+.B su \ \-m \ nobody \ \-c 'ls -l'
+Run ls as nobody user.  Notice that \-m is required since user nobody
+does not have a valid shell by default.
+.TP
+.B su \ \-l fred
+.TQ
+.B su \ \- fred
+Simulate a login for user fred.
+.TP
+.B su \ \-
+.br
+Simulate a login for root.
+.SH "EXIT STATUS"
+In common case
+.B su
+will exit with status of the subshell.  See other possibilities
+below.
+.PP
+.RS
+.PD 0
+.TP
+.B 0
+success
+.TP
+.B 1
+system and authentication errors
+.TP
+.B 126
+subshell is found but cannot be invoked
+.TP
+.B 127
+subshell cannot be found
+.PD
+.RE
+.SH FILES
+.TP
+.B /etc/pam.d/su
+PAM configuration for
+.BR su .
+.SH NOTES
+Why
+.B su
+does not support the
+.I wheel
+group by Richard Stallman.
+.PP
+Sometimes a few of the users try to hold total power over all the
+rest.  For example, in 1984, a few users at the MIT AI lab decided to
+seize power by changing the operator password on the Twenex system
+and keeping it secret from everyone else.  (I was able to thwart this
+coup and give power back to the users by patching the kernel, but I
+wouldn't know how to do that in Unix.)
+.PP
+However, occasionally the rulers do tell someone.  Under the usual
+.B su
+mechanism, once someone learns the root password who sympathizes with
+the ordinary users, he or she can tell the rest.  The "wheel group"
+feature would make this impossible, and thus cement the power of the
+rulers.
+.PP
+I'm on the side of the masses, not that of the rulers.  If you are
+used to supporting the bosses and sysadmins in whatever they do, you
+might find this idea strange at first.
+.SH AUTHORS
+.MT djm@gnu.ai.mit.edu
+David MacKenzie
+.ME
+.br
+.MT jim@meyering.net
+Jim Meyering
+.ME
+.SH "SEE ALSO"
+.BR login (1),
+.BR passwd (5),
+.BR sudo (8),
+.BR syslogd (8)
+.SH AVAILABILITY
+The example command is part of the util-linux package and is
+available from
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
