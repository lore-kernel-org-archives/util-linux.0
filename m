Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:59027 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932244AbcCHJVd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 8 Mar 2016 04:21:33 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/9] agetty: tweak formatting and some wordings in the man page
Date: Tue,  8 Mar 2016 10:07:46 +0100
Message-Id: <1457428072-2619-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1457428072-2619-1-git-send-email-bensberg@justemail.net>
References: <1457428072-2619-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 term-utils/agetty.8 |  105 ++++++++++++++++++++++++++-------------------------
 1 files changed, 53 insertions(+), 52 deletions(-)

diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index 02bf219..0d8e1f0 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -1,4 +1,4 @@
-.TH AGETTY 8 "May 2011" "util-linux" "System Administration"
+.TH AGETTY 8 "February 2016" "util-linux" "System Administration"
 .SH NAME
 agetty \- alternative Linux getty
 
@@ -19,7 +19,7 @@ for hardwired and for dial-in lines:
 Adapts the tty settings to parity bits and to erase, kill,
 end-of-line and uppercase characters when it reads a login name.
 The program can handle 7-bit characters with even, odd, none or space
-parity, and 8-bit characters with no parity. The following special
+parity, and 8-bit characters with no parity.  The following special
 characters are recognized: Control-U (kill); DEL and
 backspace (erase); carriage return and line feed (end of line).
 See also the \fB\-\-erase\-chars\fP and \fB\-\-kill\-chars\fP options.
@@ -39,7 +39,7 @@ Optionally does not ask for a login name.
 Optionally invokes a non-standard login program instead of
 \fI/bin/login\fP.
 .IP \(bu
-Optionally turns on hardware flow control
+Optionally turns on hardware flow control.
 .IP \(bu
 Optionally forces the line to be local with no need for carrier detect.
 .PP
@@ -51,8 +51,8 @@ This program does not use the \fI/etc/gettydefs\fP (System V) or
 .fi
 .ad
 .TP
-port
-A path name relative to the \fI/dev\fP directory. If a "\-" is
+.I port
+A path name relative to the \fI/dev\fP directory.  If a "\-" is
 specified, \fBagetty\fP assumes that its standard input is
 already connected to a tty port and that a connection to a
 remote user has already been established.
@@ -60,8 +60,8 @@ remote user has already been established.
 Under System V, a "\-" \fIport\fP argument should be preceded
 by a "\-\-".
 .TP
-baud_rate,...
-A comma-separated list of one or more baud rates. Each time
+.IR baud_rate ,...
+A comma-separated list of one or more baud rates.  Each time
 \fBagetty\fP receives a BREAK character it advances through
 the list, which is treated as if it were circular.
 .sp
@@ -73,8 +73,8 @@ This argument is optional and unnecessary for \fBvirtual terminals\fP.
 The default for \fBserial terminals\fP is keep the current baud rate
 (see \fB\-\-keep\-baud\fP) and if unsuccessful then default to '9600'.
 .TP
-term
-The value to be used for the TERM environment variable. This overrides
+.I term
+The value to be used for the TERM environment variable.  This overrides
 whatever init(8) may have set, and is inherited by login and the shell.
 .sp
 The default is 'vt100', or 'linux' for Linux on a virtual terminal,
@@ -90,8 +90,8 @@ Assume that the tty is 8-bit clean, hence disable parity detection.
 .TP
 \-a, \-\-autologin \fIusername\fP
 Log the specified user automatically in without asking for a login name and
-password. The \-f \fIusername\fP option is added to the \fB/bin/login\fP
-command line by default. The \-\-login\-options option changes this default
+password.  The \-f \fIusername\fP option is added to the \fB/bin/login\fP
+command line by default.  The \-\-login\-options option changes this default
 behavior and then only \\u is replaced by the \fIusername\fP and no other
 option is added to the login command line.
 .TP
@@ -109,19 +109,19 @@ This allows custom messages to be displayed on different terminals.
 The \-i option will override this option.
 .TP
 \-h, \-\-flow\-control
-Enable hardware (RTS/CTS) flow control. It is left up to the
+Enable hardware (RTS/CTS) flow control.  It is left up to the
 application to disable software (XON/XOFF) flow protocol where
 appropriate.
 .TP
 \-H, \-\-host \fIlogin_host\fP
 Write the specified \fIlogin_host\fP into the utmp file.  (Normally,
 no login host is given, since \fBagetty\fP is used for local hardwired
-connections and consoles. However, this option can be useful for
+connections and consoles.  However, this option can be useful for
 identifying terminal concentrators and the like.)
 .TP
 \-i, \-\-noissue
 Do not display the contents of \fI/etc/issue\fP (or other) before writing the
-login prompt. Terminals or communications hardware may become confused
+login prompt.  Terminals or communications hardware may become confused
 when receiving lots of text at the wrong baud rate; dial-up scripts
 may fail if the login prompt is preceded by too much text.
 .TP
@@ -132,7 +132,7 @@ characters may be sent by writing their octal code preceded by a
 backslash (\\).  For example, to send a linefeed character (ASCII 10,
 octal 012), write \\012.
 .TP
-\-J,\-\-noclear
+\-J, \-\-noclear
 Do not clear the screen before prompting for the login name
 (the screen is normally cleared).
 .TP
@@ -159,7 +159,7 @@ and follows the setting enabled by the kernel.
 .TP
 \-m, \-\-extract\-baud
 Try to extract the baud rate from the CONNECT status message
-produced by Hayes(tm)\-compatible modems. These status
+produced by Hayes(tm)\-compatible modems.  These status
 messages are of the form: "<junk><speed><junk>".
 \fBagetty\fP assumes that the modem emits its status message at
 the same speed as specified with (the first) \fIbaud_rate\fP value
@@ -168,13 +168,13 @@ on the command line.
 Since the \fB\-m\fP feature may fail on heavily-loaded systems,
 you still should enable BREAK processing by enumerating all
 expected baud rates on the command line.
-.TP 
+.TP
 \-n, \-\-skip\-login
-Do not prompt the user for a login name. This can be used in
+Do not prompt the user for a login name.  This can be used in
 connection with the \fB\-l\fP option to invoke a non-standard login process such
-as a BBS system. Note that with the \-n option, \fBagetty\fR gets no input from
+as a BBS system.  Note that with the \-n option, \fBagetty\fR gets no input from
 the user who logs in and therefore won't be able to figure out parity,
-character size, and newline processing of the connection. It defaults to 
+character size, and newline processing of the connection.  It defaults to
 space parity, 7 bit characters, and ASCII CR (13) end-of-line character.
 Beware that the program that \fBagetty\fR starts (usually /bin/login)
 is run as root.
@@ -184,7 +184,7 @@ Do not print a newline before writing out /etc/issue.
 .TP
 \-o, \-\-login\-options "\fIlogin_options\fP"
 Options  that  are passed to the login program.  \\u is replaced
-by the login name. The default \fB/bin/login\fP command line
+by the login name.  The default \fB/bin/login\fP command line
 is "/bin/login -- <username>".
 
 Please read the SECURITY NOTICE below if you want to use this.
@@ -200,7 +200,7 @@ Change root to the specified directory.
 Call vhangup() to do a virtual hangup of the specified terminal.
 .TP
 \-s, \-\-keep\-baud
-Try to keep the existing baud rate. The baud rates from
+Try to keep the existing baud rate.  The baud rates from
 the command line are used when agetty receives a BREAK character.
 .TP
 \-t, \-\-timeout \fItimeout\fP
@@ -217,7 +217,7 @@ Note that this has no support for any Unicode characters.
 \-w, \-\-wait\-cr
 Wait for the user or the modem to send a carriage-return or a
 linefeed character before sending the \fI/etc/issue\fP (or other) file
-and the login prompt. Very useful in connection with the \-I option.
+and the login prompt.  Very useful in connection with the \-I option.
 .TP
 \-\-nohints
 Do not print hints about Num, Caps and Scroll Locks.
@@ -254,8 +254,8 @@ Run login with this priority.
 .TP
 \-\-reload
 Ask all running agetty instances to reload and update their displayed prompts,
-if the user has not yet commenced logging in. After doing so the command will
-exit. This feature might be unsupported on systems without Linux
+if the user has not yet commenced logging in.  After doing so the command will
+exit.  This feature might be unsupported on systems without Linux
 .BR inotify (7).
 .TP
 \-\-version
@@ -291,7 +291,7 @@ For an old-style dial-in line with a 9600/2400/1200 baud modem:
 
 For a Hayes modem with a fixed 115200 bps interface to the machine
 (the example init string turns off modem echo and result codes, makes
-modem/computer DCD track modem/modem DCD, makes a DTR drop cause a 
+modem/computer DCD track modem/modem DCD, makes a DTR drop cause a
 disconnection, and turns on auto-answer after 1 ring):
 
 .RS
@@ -301,30 +301,30 @@ disconnection, and turns on auto-answer after 1 ring):
 .SH SECURITY NOTICE
 If you use the \fB\-\-login\-program\fP and \fB\-\-login\-options\fP options,
 be aware that a malicious user may try to enter lognames with embedded options,
-which then get passed to the used login program. Agetty does check
+which then get passed to the used login program.  Agetty does check
 for a leading "\-" and makes sure the logname gets passed as one parameter
 (so embedded spaces will not create yet another parameter), but depending
 on how the login binary parses the command line that might not be sufficient.
 Check that the used login program can not be abused this way.
 .PP
 Some  programs use "\-\-" to indicate that the rest of the commandline should
-not be interpreted as options. Use this feature if available by passing "\-\-"
+not be interpreted as options.  Use this feature if available by passing "\-\-"
 before the username gets passed by \\u.
 
 .SH ISSUE ESCAPES
-The issue-file (\fI/etc/issue\fP or the file set with the \fB\-f\fP option)
+The issue-file (\fI/etc/issue\fP, or the file set with the \fB\-f\fP option)
 may contain certain escape codes to display the system name, date, time
 etcetera.  All escape codes consist of a backslash (\\) immediately
-followed by one of the letters explained below.
+followed by one of the characters listed below.
 
 .TP
-4 or 4{interface}
-Insert the IPv4 address the specified network interface (e.g. \\4{eth0})
-and if the interface argument is not specified then select the first fully 
-configured (UP, non-LOCALBACK, RUNNING) interface. If not found any 
-configured interface fall back to IP address of the machine hostname.
+4 or 4{\fIinterface\fR}
+Insert the IPv4 address of the specified network interface (for example: \\4{eth0}).
+If the \fIinterface\fR argument is not specified, then select the first fully
+configured (UP, non-LOCALBACK, RUNNING) interface.  If not any configured
+interface is found, fall back to the IP address of the machine's hostname.
 .TP
-6 or 6{interface}
+6 or 6{\fIinterface\fR}
 The same as \\4 but for IPv6.
 .TP
 b
@@ -333,22 +333,23 @@ Insert the baudrate of the current line.
 d
 Insert the current date.
 .TP
-e or e{name}
-Translate the human readable \fIname\fP to esc sequence and insert the sequence
-(e.g. \\e{red}Alert text.\\e{reset}).  If the name argument is not specified then
-insert \\033. The currently supported names are: black, blink, blue, bold, brown, cyan,
+e or e{\fIname\fR}
+Translate the human-readable \fIname\fP to an escape sequence and insert it
+(for example: \\e{red}Alert text.\\e{reset}).  If the \fIname\fR argument is
+not specified, then insert \\033.  The currently supported names are: black,
+blink, blue, bold, brown, cyan,
 darkgray, gray, green, halfbright, lightblue, lightcyan, lightgray, lightgreen,
 lightmagenta, lightred, magenta, red, reset, reverse, and yellow.  All unknown
 names are silently ignored.
 .TP
 s
-Insert the system name, the name of the operating system. Same as `uname \-s'.
-See also \\S escape code.
+Insert the system name (the name of the operating system).  Same as `uname \-s'.
+See also the \\S escape code.
 .TP
 S or S{VARIABLE}
-Insert the VARIABLE data from \fI/etc/os-release\fP, if the file does not exist
-then fallback to \fI/usr/lib/os-release\fP.  If the VARIABLE argument is not
-specified then use PRETTY_NAME from the file or the system name (see \\s).
+Insert the VARIABLE data from \fI/etc/os-release\fP.  If this file does not exist
+then fall back to \fI/usr/lib/os-release\fP.  If the VARIABLE argument is not
+specified, then use PRETTY_NAME from the file or the system name (see \\s).
 This escape code allows to keep \fI/etc/issue\fP distribution and release
 independent.  Note that \\S{ANSI_COLOR} is converted to the real terminal
 escape sequence.
@@ -357,19 +358,19 @@ l
 Insert the name of the current tty line.
 .TP
 m
-Insert the architecture identifier of the machine. Same as `uname \-m'.
+Insert the architecture identifier of the machine.  Same as `uname \-m'.
 .TP
 n
-Insert the nodename of the machine, also known as the hostname. Same as `uname \-n'.
+Insert the nodename of the machine, also known as the hostname.  Same as `uname \-n'.
 .TP
 o
-Insert the NIS domainname of the machine. Same as `hostname \-d'.
+Insert the NIS domainname of the machine.  Same as `hostname \-d'.
 .TP
 O
 Insert the DNS domainname of the machine.
 .TP
 r
-Insert the release number of the OS. Same as `uname \-r'.
+Insert the release number of the OS.  Same as `uname \-r'.
 .TP
 t
 Insert the current time.
@@ -382,9 +383,9 @@ Insert the string "1 user" or "<n> users" where <n> is the number of current
 users logged in.
 .TP
 v
-Insert the version of the OS, eg. the build-date etc.
+Insert the version of the OS, e.g. the build-date etc.
 .PP
-Example: On my system, the following \fI/etc/issue\fP file:
+An example.  On my system, the following \fI/etc/issue\fP file:
 .sp
 .na
 .RS
@@ -423,7 +424,7 @@ problem reports (if syslog(3) is not used).
 .fi
 The baud-rate detection feature (the \fB\-m\fP option) requires that
 \fBagetty\fP be scheduled soon enough after completion of a dial-in
-call (within 30 ms with modems that talk at 2400 baud). For robustness,
+call (within 30 ms with modems that talk at 2400 baud).  For robustness,
 always use the \fB\-m\fP option in combination with a multiple baud
 rate command-line argument, so that BREAK processing is enabled.
 
-- 
1.7.0.4

