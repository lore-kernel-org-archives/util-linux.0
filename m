Return-Path: elseifthen@gmx.com
Subject: [PATCH] agetty: various man-page fixes
To: Karel Zak <kzak@redhat.com>
References: <20170402081436.861-1-kerolasa@iki.fi>
 <20170402081436.861-3-kerolasa@iki.fi>
 <bb07f30a-74e6-0961-758a-67383ae417bf@gmx.com>
 <CAG27Bk36WxLCGDtWk+WHrK4eDqsjoQcNdc1sKxhpN4BmAEFmWA@mail.gmail.com>
 <CAG27Bk2_YT8jEOrxb4ANwH59CAw-ramfZkpCBDHbAqkkDHOfwQ@mail.gmail.com>
 <aac8c8b6-1c10-9645-3538-2f5944fbfcb1@gmx.com>
 <20170406084119.fpjzutu73sc4bdbg@ws.net.home>
From: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Message-ID: <41e41871-d255-9551-8fae-2edfe7205da9@gmx.com>
Date: Thu, 6 Apr 2017 10:21:07 -0400
MIME-Version: 1.0
In-Reply-To: <20170406084119.fpjzutu73sc4bdbg@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


term-utils/agetty.8

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---

On 04/06/2017 04:41 AM, Karel Zak wrote:
> 
>  Can you use master branch? Sami's patches are already merged and I
>  did some changes to the man page too.
> 
>     Karel
>

Sorry, I didn't know you merged it already.

 term-utils/agetty.8 | 60 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index 9560c1f..23adff3 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -89,22 +89,29 @@ or 'hurd' for GNU Hurd on a virtual terminal.
 Assume that the tty is 8-bit clean, hence disable parity detection.
 .TP
 \-a, \-\-autologin \fIusername\fP
-Automatically log in the specified user without asking username or password.
-Use of this option causes \fB\-f \fIusername\fR option and argument to be
-added to the \fB/bin/login\fP command line.  This option can combined with
-\fB\-\-login\-options\fR, and then \\u is replaced by the \fIusername\fR.
+Automatically log in the specified user without asking for a username or password.
+Using this option causes an \fB\-f \fIusername\fR option and argument to be
+added to the \fB/bin/login\fP command line.  See \fB\-\-login\-options\fR, which
+can be used to modify this option's behavior.
 .TP
 \-c, \-\-noreset
 Do not reset terminal cflags (control modes).  See \fBtermios\fP(3) for more
 details.
 .TP
 \-E, \-\-remote
+Typically the \fBlogin\fP(1) command is given a remote hostname when
+called by something such as \fBtelnetd\fP(8).  This option allows \fBagetty\fP
+to pass what it is using for a hostname to \fBlogin\fP(1) for use
+in \fButmp\fP(5).  See \fB\-\-host\fP, \fBlogin\fP(1), and \fButmp\fP(5).
+.IP
 If the \fB\-\-host\fP \fIfakehost\fP option is given, then an \fB\-h\fP
 \fIfakehost\fP option and argument are added to the \fB/bin/login\fP
 command line.
 .IP
-If an \fB\-\-nohostname\fR option is given, then an \fB\-H\fP option
+If the \fB\-\-nohostname\fR option is given, then an \fB\-H\fP option
 is added to the \fB/bin/login\fP command line.
+.IP
+See \fB\-\-login\-options\fR.
 .TP
 \-f, \-\-issue\-file \fIissue_file\fP
 Display the contents of \fIissue_file\fP instead of \fI/etc/issue\fP.
@@ -116,8 +123,8 @@ Enable hardware (RTS/CTS) flow control.  It is left up to the
 application to disable software (XON/XOFF) flow protocol where
 appropriate.
 .TP
-\-H, \-\-host \fIlogin_host\fP
-Write the specified \fIlogin_host\fP into the utmp file.  Normally,
+\-H, \-\-host \fIfakehost\fP
+Write the specified \fIfakehost\fP into the utmp file.  Normally,
 no login host is given, since \fBagetty\fP is used for local hardwired
 connections and consoles.  However, this option can be useful for
 identifying terminal concentrators and the like.
@@ -137,12 +144,13 @@ octal 012), write \\012.
 .TP
 \-J, \-\-noclear
 Do not clear the screen before prompting for the login name.
-By default screen is cleared.
+By default the screen is cleared.
 .TP
 \-l, \-\-login\-program \fIlogin_program\fP
 Invoke the specified \fIlogin_program\fP instead of /bin/login.  This allows
-the use of a non-standard login program.  Such program could for example
-ask for a dial-up password or use a different password file.
+the use of a non-standard login program.  Such a program could, for example,
+ask for a dial-up password or use a different password file. See
+\fB\-\-login\-options\fP.
 .TP
 \-L, \-\-local\-line[=\fImode\fP]
 Control the CLOCAL line flag.  The optional \fImode\fP argument is 'auto', 'always' or 'never'.
@@ -192,13 +200,17 @@ program that \fBagetty\fR starts (usually /bin/login) is run as root.
 \-N, \-\-nonewline
 Do not print a newline before writing out /etc/issue.
 .TP
-\-o, \-\-login\-options \fIoptions\fP
-Options  that  are passed to the login program.  \\u is replaced
-by the user name.  The default is "-- \\u".
-.IP
-Also see the \fB\-\-login\-program\fR, \fB\-\-autologin\fR and \fB\-\-remote\fR options.
-.IP
-Please, read the SECURITY NOTICE below before using this option.
+\-o, \-\-login\-options "\fIlogin_options\fP"
+Options  and arguments that  are passed to \fBlogin\fP(1). Where \\u is
+replaced by the login name. For example:
+.RS
+.IP "" 4
+.B "\-\-login\-options '-h darkstar -- \\\u'"
+.PP
+See \fB\-\-autologin\fR, \fB\-\-login\-program\fR and \fB\-\-remote\fR.
+.PP
+Please read the SECURITY NOTICE below before using this option.
+.RE
 .TP
 \-p, \-\-login\-pause
 Wait for any key before dropping to the login prompt.  Can be combined
@@ -226,8 +238,8 @@ Note that this has no support for any Unicode characters.
 .TP
 \-w, \-\-wait\-cr
 Wait for the user or the modem to send a carriage-return or a
-linefeed character before sending the \fI/etc/issue\fP (or other) file
-and the login prompt.  This is useful with the \-\-init\-string
+linefeed character before sending the \fI/etc/issue\fP file (or others)
+and the login prompt.  This is useful with the \fB\-\-init\-string\fP
 option.
 .TP
 \-\-nohints
@@ -283,7 +295,7 @@ for the other fields.  See \fIinittab(5)\fP for more details.
 For a hardwired line or a console tty:
 
 .RS
-/sbin/agetty 9600 ttyS1
+.B /sbin/agetty\ 9600\ ttyS1
 .RE
 
 For a directly connected terminal without proper carrier-detect wiring
@@ -291,13 +303,13 @@ For a directly connected terminal without proper carrier-detect wiring
 prompt):
 
 .RS
-/sbin/agetty \-\-local\-line 9600 ttyS1 vt100
+.B /sbin/agetty\ \-\-local\-line\ 9600\ ttyS1\ vt100
 .RE
 
 For an old-style dial-in line with a 9600/2400/1200 baud modem:
 
 .RS
-/sbin/agetty \-\-extract\-baud \-\-timeout 60 ttyS1 9600,2400,1200
+.B /sbin/agetty\ \-\-extract\-baud\ \-\-timeout\ 60\ ttyS1\ 9600,2400,1200
 .RE
 
 For a Hayes modem with a fixed 115200 bps interface to the machine
@@ -306,7 +318,7 @@ modem/computer DCD track modem/modem DCD, makes a DTR drop cause a
 disconnection, and turns on auto-answer after 1 ring):
 
 .RS
-/sbin/agetty \-\-wait\-cr \-\-init\-string 'ATE0Q1&D2&C1S0=1\\015' 115200 ttyS1
+.B /sbin/agetty\ \-\-wait\-cr\ \-\-init\-string\ 'ATE0Q1&D2&C1S0=1\\015'\ 115200\ ttyS1
 .RE
 
 .SH SECURITY NOTICE
@@ -394,7 +406,7 @@ Insert the string "1 user" or "<n> users" where <n> is the number of current
 users logged in.
 .TP
 v
-Insert the version of the OS, that is the build-date and such.
+Insert the version of the OS, that is, the build-date and such.
 .PP
 An example.  On my system, the following \fI/etc/issue\fP file:
 .sp
