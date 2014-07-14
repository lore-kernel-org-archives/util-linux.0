Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:64194 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753305AbaGNJDU (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jul 2014 05:03:20 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/5] docs: improve formatting and wording of a few man pages
Date: Mon, 14 Jul 2014 11:02:58 +0200
Message-Id: <1405328581-2202-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1405328581-2202-1-git-send-email-bensberg@justemail.net>
References: <1405328581-2202-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 lib/terminal-colors.d.5 |   64 ++++++++++++++--------------
 sys-utils/prlimit.1     |  108 +++++++++++++++++++++++------------------------
 sys-utils/swapon.8      |   72 ++++++++++++++++---------------
 text-utils/hexdump.1    |   23 +++++-----
 4 files changed, 134 insertions(+), 133 deletions(-)

diff --git a/lib/terminal-colors.d.5 b/lib/terminal-colors.d.5
index ab0a349..019282c 100644
--- a/lib/terminal-colors.d.5
+++ b/lib/terminal-colors.d.5
@@ -7,70 +7,70 @@
 .SH "NAME"
 terminal-colors.d \- Configure output colorization for various utilities
 .SH "SYNOPSIS"
-/etc/terminal-colors\&.d/[[name][@term]\&.][type]
+/etc/terminal-colors\&.d/[[\fIname\fR][@\fIterm\fR]\&.][\fItype\fR]
 .SH "DESCRIPTION"
 Files in this directory determine the default behavior for utilities
 when coloring output.
 
 The
-.B name
-is an utility name. The name is optional and when no specified than the
+.I name
+is a utility name.  The name is optional and when none is specified then the
 file is used for all unspecified utilities.
 
 The
-.B term
+.I term
 is a terminal identifier (the TERM environment variable).
-The terminal identifier is optional and when no specified than the file
+The terminal identifier is optional and when none is specified then the file
 is used for all unspecified terminals.
 
 The
-.B type
-is a file type. Supported file types:
+.I type
+is a file type.  Supported file types are:
 .TP
 .B disable
 Turns off output colorization for all compatible utilities.
 .TP
 .B enable
-Turns on output colorization, all another
+Turns on output colorization; any matching
 .B disable
 files are ignored.
 .TP
 .B scheme
-Specifies colors used for output. The file format may be specific to the utility,
+Specifies colors used for output.  The file format may be specific to the utility,
 the default format is described below.
 .PP
-If there is more files that match for the utility then the file with more
-specific filename wins. For example filename "@xterm.scheme" has less
-priority than "dmesg@xterm.scheme". The lowest priority have files without
+If there are more files that match for a utility, then the file with the more
+specific filename wins.  For example, the filename "@xterm.scheme" has less
+priority than "dmesg@xterm.scheme".  The lowest priority are those files without a
 utility name and terminal identifier (e.g. "disable").
 
-The user specific
-.IR  $XDG_CONFIG_HOME/terminal-colors.d
+The user-specific
+.I $XDG_CONFIG_HOME/terminal-colors.d
 or
-.IR $HOME/.config/terminal-colors.d
+.I $HOME/.config/terminal-colors.d
 overrides the global setting.
 
 .SH EXAMPLES
 Disable colors for all compatible utilities:
 .RS
 .br
-.BI "touch /etc/terminal-colors.d/disable"
+.B "touch /etc/terminal-colors.d/disable"
 .br
 .RE
 
-Disable colors for all compatible utils on vt100 terminal:
+Disable colors for all compatible utils on a vt100 terminal:
 .RS
 .br
-.BI "touch /etc/terminal-colors.d/@vt100.disable"
+.B "touch /etc/terminal-colors.d/@vt100.disable"
 .br
 .RE
 
 Disable colors for all compatible utils except dmesg(1):
 .RS
 .br
-.BI "touch /etc/terminal-colors.d/disable"
+.B "touch /etc/terminal-colors.d/disable"
 .sp
-.BI "touch /etc/terminal-colors.d/dmesg.enable"
+.B "touch /etc/terminal-colors.d/dmesg.enable"
 .br
 .RE
 
@@ -79,14 +79,14 @@ The following statement is recognized:
 
 .RS
 .br
-.BI "name color-sequence"
+.B "name color-sequence"
 .br
 .RE
 
 The
 .B name
-is a logical name of color sequence (for example "error"). The names are
-specific to the utilities. For more details always see the COLORS section
+is a logical name of color sequence (for example "error").  The names are
+specific to the utilities.  For more details always see the COLORS section
 in the man page for the utility.
 
 The
@@ -98,7 +98,7 @@ black, blue, brown, cyan, darkgray, gray, green, lightblue, lightcyan
 lightgray, lightgreen, lightmagenta, lightred, magenta, red and yellow
 .SS ANSI color sequences
 The color sequences are composed of sequences of numbers
-separated by semicolons. The most common codes are:
+separated by semicolons.  The most common codes are:
 .sp
 .RS
 .TS
@@ -126,7 +126,7 @@ l l.
 .TE
 .RE
 .SS Escape sequences
-To specify control or blank characters in the color sequences
+To specify control or blank characters in the color sequences,
 C-style \e-escaped notation can be used:
 .sp
 .RS
@@ -152,22 +152,22 @@ Please note that escapes are necessary to enter a space, backslash,
 caret, or any control character anywhere in the string, as well as a
 hash mark as the first character.
 
-For example to use red background for alert messages in
-.BR dmesg (1) 
-output use:
+For example, to use a red background for alert messages in the output of
+.BR dmesg (1),
+use:
 
 .RS
 .br
-.BI "echo 'alert 37;41' >> /etc/terminal-colors.d/dmesg.scheme"
+.B "echo 'alert 37;41' >> /etc/terminal-colors.d/dmesg.scheme"
 .br
 .RE
 
 .SH FILES
-.IR $XDG_CONFIG_HOME/terminal-colors.d
+.B $XDG_CONFIG_HOME/terminal-colors.d
 .br
-.IR $HOME/.config/terminal-colors.d
+.B $HOME/.config/terminal-colors.d
 .br
-.IR /etc/terminal-colors.d
+.B /etc/terminal-colors.d
 
 .SH COMPATIBILITY
 The terminal-colors.d functionality is currently supported by all util-linux
diff --git a/sys-utils/prlimit.1 b/sys-utils/prlimit.1
index 95bc876..164f472 100644
--- a/sys-utils/prlimit.1
+++ b/sys-utils/prlimit.1
@@ -2,20 +2,18 @@
 .\" Copyright 2011 Davidlohr Bueso <dave@gnu.org>
 .\" May be distributed under the GNU General Public License
 
-.TH PRLIMIT 1 "October 2011" "util-linux" "User Commands"
+.TH PRLIMIT 1 "July 2014" "util-linux" "User Commands"
 .SH NAME
 prlimit \-
-get and set a process resource limits.
+get and set process resource limits
 .SH SYNOPSIS
-.B prlimit
-.RB [options]
-.RB [ \-\-{resource_name}[=limits]
-.RB [ \-\-pid\ PID]
+.BR prlimit " [options]"
+.RB [ \-\-\fIresource\fR [ =\fIlimits\fR]
+.RB [ \-\-pid\ \fIPID\fR]
 
-.B prlimit
-.RB [options]
-.RB [ \-\-{resource_name}[=limits]]
-.RB "command " [ argument ...]
+.BR prlimit " [options]"
+.RB [ \-\-\fIresource\fR [ =\fIlimits\fR]
+.IR "command " [ argument ...]
 
 .SH DESCRIPTION
 Given a process id and one or more resources, \fBprlimit\fP tries to retrieve
@@ -25,70 +23,71 @@ When \fIcommand\fR is given,
 .B prlimit
 will run this command with the given arguments.
 
-The \fIlimits\fP format is composed by a soft and a hard (ceiling) value, separated
-by a semicolon (:), in order to modify the existing value(s). If no limits are
-used, \fBprlimit\fP will only display the current values. If one of the values
-is not used, then the existing one will be used. To specify the unlimited or
+The \fIlimits\fP parameter is composed of a soft and a hard value, separated
+by a colon (:), in order to modify the existing values.  If no \fIlimits\fR are
+given, \fBprlimit\fP will display the current values.  If one of the values
+is not given, then the existing one will be used.  To specify the unlimited or
 infinity limit (RLIM_INFINITY), the -1 or 'unlimited' string can be passed.
 
-Because of the nature of limits, the soft value must be lower or equal to the
-high limit. To see all the available resource limits, refer to the RESOURCE
-OPTIONS section.
+Because of the nature of limits, the soft limit must be lower or equal to the
+high limit (also called the ceiling).  To see all available resource limits,
+refer to the RESOURCE OPTIONS section.
 
-.IP "\fB<soft>:<hard>\fP  Specify both limits"
-.IP "\fB<soft>:\fP        Specify only the soft limit"
-.IP "\fB:<hard>\fP        Specify only the hard limit"
-.IP "\fB<value>\fP        Specify both soft and hard limits to the same value"
+.IP "\fIsoft\fP:\fIhard\fP    Specify both limits."
+.IP "\fIsoft\fP:        Specify only the soft limit."
+.IP ":\fIhard\fP        Specify only the hard limit."
+.IP "\fIvalue\fP        Specify both both limits to the same value."
 
 .SH GENERAL OPTIONS
-.IP "\fB\-p, \-\-pid\fP"
-Specify the process id, if none is given, it will use the running process.
+.IP "\fB\-h, \-\-help\fP"
+Display help text and exit.
+.IP "\fB\-\-noheadings\fP"
+Do not print a header line.
 .IP "\fB\-o, \-\-output \fIlist\fP"
-Define the output columns to use. If no output arrangement is specified, then a default set is used.
-Use \fB\-\-help\fP to  get list of all supported columns.
-.IP "\fB\-V, \-\-version\fP"
-Display version information and exit.
-.IP "\fB\-\-verbose\fP"
-Verbose mode.
+Define the output columns to use.  If no output arrangement is specified,
+then a default set is used.
+Use \fB\-\-help\fP to get a list of all supported columns.
+.IP "\fB\-p, \-\-pid\fP"
+Specify the process id; if none is given, the running process will be used.
 .IP "\fB\-\-raw\fP"
 Use the raw output format.
-.IP "\fB\-\-noheadings\fP"
-Do not print a header line.
-.IP "\fB\-h, \-\-help\fP"
-Display help text and exit.
+.IP "\fB\-\-verbose\fP"
+Verbose mode.
+.IP "\fB\-V, \-\-version\fP"
+Display version information and exit.
 
 .SH RESOURCE OPTIONS
-.IP "\fB\-c, \-\-core\fP[=limits]"
+.IP "\fB\-c, \-\-core\fP[=\fIlimits\fR]"
 Maximum size of a core file.
-.IP "\fB\-d, \-\-data\fP[=limits]"
+.IP "\fB\-d, \-\-data\fP[=\fIlimits\fR]"
 Maximum data size.
-.IP "\fB\-e, \-\-nice\fP[=limits]"
+.IP "\fB\-e, \-\-nice\fP[=\fIlimits\fR]"
 Maximum nice priority allowed to raise.
-.IP "\fB\-f, \-\-fsize\fP[=limits]"
+.IP "\fB\-f, \-\-fsize\fP[=\fIlimits\fR]"
 Maximum file size.
-.IP "\fB\-i, \-\-sigpending\fP[=limits]"
+.IP "\fB\-i, \-\-sigpending\fP[=\fIlimits\fR]"
 Maximum number of pending signals.
-.IP "\fB\-l, \-\-memlock\fP[=limits]"
+.IP "\fB\-l, \-\-memlock\fP[=\fIlimits\fR]"
 Maximum locked-in-memory address space.
-.IP "\fB\-m, \-\-rss\fP[=limits]"
+.IP "\fB\-m, \-\-rss\fP[=\fIlimits\fR]"
 Maximum Resident Set Size (RSS).
-.IP "\fB\-n, \-\-nofile\fP[=limits]"
+.IP "\fB\-n, \-\-nofile\fP[=\fIlimits\fR]"
 Maximum number of open files.
-.IP "\fB\-q, \-\-msgqueue\fP[=limits]"
+.IP "\fB\-q, \-\-msgqueue\fP[=\fIlimits\fR]"
 Maximum number of bytes in POSIX message queues.
-.IP "\fB\-r, \-\-rtprio\fP[=limits]"
+.IP "\fB\-r, \-\-rtprio\fP[=\fIlimits\fR]"
 Maximum real-time priority.
-.IP "\fB\-s, \-\-stack\fP[=limits]"
+.IP "\fB\-s, \-\-stack\fP[=\fIlimits\fR]"
 Maximum size of the stack.
-.IP "\fB\-t, \-\-cpu\fP[=limits]"
+.IP "\fB\-t, \-\-cpu\fP[=\fIlimits\fR]"
 CPU time, in seconds.
-.IP "\fB\-u, \-\-nproc\fP[=limits]"
+.IP "\fB\-u, \-\-nproc\fP[=\fIlimits\fR]"
 Maximum number of processes.
-.IP "\fB\-v, \-\-as\fP[=limits]"
+.IP "\fB\-v, \-\-as\fP[=\fIlimits\fR]"
 Address space limit.
-.IP "\fB\-x, \-\-locks\fP[=limits]"
+.IP "\fB\-x, \-\-locks\fP[=\fIlimits\fR]"
 Maximum number of file locks held.
-.IP "\fB\-y, \-\-rttime\fP[=limits]"
+.IP "\fB\-y, \-\-rttime\fP[=\fIlimits\fR]"
 Timeout for real-time tasks.
 
 .RE
@@ -96,24 +95,23 @@ Timeout for real-time tasks.
 .IP "\fBprlimit \-\-pid 13134\fP"
 Display limit values for all current resources.
 .IP "\fBprlimit \-\-pid 13134 \--rss --nofile=1024:4095\fP"
-Display the limits of the RSS and set the soft and hard limits for the number
+Display the limits of the RSS, and set the soft and hard limits for the number
 of open files to 1024 and 4095, respectively.
 .IP "\fBprlimit \-\-pid 13134 --nproc=512:\fP"
 Modify only the soft limit for the number of processes.
 .IP "\fBprlimit \-\-pid $$ --nproc=unlimited\fP"
-Set the number of processes for both soft and ceiling values to unlimited.
+Set for the current process both the soft and ceiling values for the number of
+processes to umlimited.
 .IP "\fBprlimit --cpu=10 sort -u hugefile\fP"
-Set the soft and hard CPU time limit and run 'sort'.
+Set both the soft and hard CPU time limit to ten seconds and and run 'sort'.
 
 .SH "SEE ALSO"
 .BR prlimit (2),
 .BR ulimit (1)
 
 .SH NOTES
-.nf
-The prlimit system call is supported since Linux 2.6.36, previous kernels will
+The prlimit system call is supported since Linux 2.6.36, older kernels will
 break this program.
-.fi
 
 .SH AUTHORS
 .nf
diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index 2b9ed03..34118fb 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -38,24 +38,24 @@
 .\" Mon Sep 25 14:12:38 1995: Added -v and -p information
 .\" Tue Apr 30 03:32:07 1996: Added some text from A. Koppenhoefer
 .\"
-.TH SWAPON 8 "September 1995" "util-linux" "System Administration"
+.TH SWAPON 8 "July 2014" "util-linux" "System Administration"
 .SH NAME
 swapon, swapoff \- enable/disable devices and files for paging and swapping
 .SH SYNOPSIS
-.B swapon
-[ options ]
-.RI [ specialfile... ]
+.BR swapon
+[options]
+.RI [ specialfile ...]
 .br
 .B swapoff
 .RB [ \-va ]
-.RI [ specialfile... ]
+.RI [ specialfile ...]
 .SH DESCRIPTION
 .B swapon
 is used to specify devices on which paging and swapping are to take place.
 
 The device or file used is given by the
 .I specialfile
-parameter. It may be of the form
+parameter.  It may be of the form
 .BI \-L " label"
 or
 .BI \-U " uuid"
@@ -77,17 +77,18 @@ flag is given, swapping is disabled on all known swap devices and files
 or
 .IR /etc/fstab ).
 
+.SH OPTIONS
 .TP
-.B "\-a, \-\-all"
+.BR \-a , " \-\-all"
 All devices marked as ``swap'' in
 .I /etc/fstab
 are made available, except for those with the ``noauto'' option.
 Devices that are already being used as swap are silently skipped.
 .TP
-.B "\-d, \-\-discard\fR [=\fIpolicy\fR]"
+.BR \-d , " \-\-discard" [ =\fIpolicy\fR]
 Enable swap discards, if the swap backing device supports the discard or
-trim operation. This may improve performance on some Solid State Devices,
-but often it does not. The option allows one to select between two
+trim operation.  This may improve performance on some Solid State Devices,
+but often it does not.  The option allows one to select between two
 available swap discard policies:
 .BI \-\-discard=once
 to perform a single-time discard operation for the whole swap area at swapon;
@@ -98,44 +99,44 @@ If no policy is selected, the default behavior is to enable both discard types.
 The
 .I /etc/fstab
 mount options
-.BI discard,
-.BI discard=once,
+.BR discard ,
+.BR discard=once ,
 or
-.BI discard=pages
-may be also used to enable discard flags.
+.B discard=pages
+may also be used to enable discard flags.
 .TP
-.B "\-e, \-\-ifexists"
+.BR \-e , " \-\-ifexists"
 Silently skip devices that do not exist.
 The
 .I /etc/fstab
 mount option
-.BI nofail
-may be also used to skip non-existing device.
+.B nofail
+may also be used to skip non-existing device.
 
 .TP
-.B "\-f, \-\-fixpgsz"
+.BR \-f , " \-\-fixpgsz"
 Reinitialize (exec /sbin/mkswap) the swap space if its page size does not
 match that of the current running kernel.
 .BR mkswap (2)
 initializes the whole device and does not check for bad blocks.
 .TP
-.B \-h, \-\-help
+.BR \-h , " \-\-help"
 Display help text and exit.
 .TP
-.B "\-L \fIlabel\fP"
+.BI \-L " label"
 Use the partition that has the specified
 .IR label .
 (For this, access to
 .I /proc/partitions
 is needed.)
 .TP
-.B "\-p, \-\-priority \fIpriority\fP"
+.BR \-p , " \-\-priority " \fIpriority\fP
 Specify the priority of the swap device.
 .I priority
 is a value between \-1 and 32767.  Higher numbers indicate
 higher priority.  See
 .BR swapon (2)
-for a full description of swap priorities. Add
+for a full description of swap priorities.  Add
 .BI pri= value
 to the option field of
 .I /etc/fstab
@@ -143,17 +144,17 @@ for use with
 .BR "swapon -a" .
 When priority is not defined it defaults to \-1.
 .TP
-.B "\-s, \-\-summary"
-Display swap usage summary by device. Equivalent to "cat /proc/swaps".
-Not available before Linux 2.1.25. This output format is DEPRECATED in favour
+.BR \-s , " \-\-summary"
+Display swap usage summary by device.  Equivalent to "cat /proc/swaps".
+Not available before Linux 2.1.25.  This output format is DEPRECATED in favour
 of \fB\-\-show\fR that provides better control on output data.
 .TP
-\fB\-\-show\fR [\fIcolumn\fR, ...]
+.BR \-\-show " [\fIcolumn\fR, ...]"
 Display definable device table similar to
 .B \-\-summary
-output.  See \-\-help output for
-.I column
-list.
+output.  See
+.B \-\-help
+output for a list of available columns.
 .TP
 .B \-\-noheadings
 Do not print headings when displaying
@@ -168,8 +169,9 @@ output without aligning table columns.
 .B \-\-bytes
 Display swap size in bytes in
 .B \-\-show
-output instead of user friendly size and unit.
-.B "\-U \fIuuid\fP"
+output instead of in user-friendly units.
+.TP
+.BI \-U  " uuid"
 Use the partition that has the specified
 .IR uuid .
 .TP
@@ -195,10 +197,10 @@ may not work correctly when using a swap file with some versions of btrfs.
 This is due to the swap file implementation in the kernel expecting to be able
 to write to the file directly, without the assistance of the file system.
 Since btrfs is a copy-on-write file system, the file location may not be
-static and corruption can result. Btrfs actively disallows the use of files
-on its file systems by refusing to map the file. This can be seen in the system
-log as "swapon: swapfile has holes." One possible workaround is to map the
-file to a loopback device. This will allow the file system to determine the
+static and corruption can result.  Btrfs actively disallows the use of files
+on its file systems by refusing to map the file.  This can be seen in the system
+log as "swapon: swapfile has holes."  One possible workaround is to map the
+file to a loopback device.  This will allow the file system to determine the
 mapping properly but may come with a performance impact.
 
 .SH ENVIRONMENT
diff --git a/text-utils/hexdump.1 b/text-utils/hexdump.1
index f8ee8ef..8f11103 100644
--- a/text-utils/hexdump.1
+++ b/text-utils/hexdump.1
@@ -36,7 +36,7 @@
 hexdump \- display file contents in ascii, decimal, hexadecimal, or octal
 .SH SYNOPSIS
 .B hexdump
-.RI [options] file ...
+.RI [options] " file" ...
 .SH DESCRIPTION
 The
 .B hexdump
@@ -44,10 +44,10 @@ utility is a filter which displays the specified files, or
 standard input if no files are specified, in a user-specified
 format.
 .SH OPTIONS
-The \fIlength\fR and \fIoffset\fR arguments may be followed by the multiplicative
-suffixes KiB=1024, MiB=1024*1024, and so on for GiB, TiB, PiB, EiB, ZiB and YiB
-(the "iB" is optional, e.g. "K" has the same meaning as "KiB") or the suffixes
-KB=1000, MB=1000*1000, and so on for GB, TB, PB, EB, ZB and YB.
+Below, the \fIlength\fR and \fIoffset\fR arguments may be followed by the multiplicative
+suffixes KiB (=1024), MiB (=1024*1024), and so on for GiB, TiB, PiB, EiB, ZiB and YiB
+(the "iB" is optional, e.g. "K" has the same meaning as "KiB"), or the suffixes
+KB (=1000), MB (=1000*1000), and so on for GB, TB, PB, EB, ZB and YB.
 .TP
 \fB\-b\fR, \fB\-\-one\-byte\-octal\fR
 \fIOne-byte octal display\fR.  Display the input offset in hexadecimal,
@@ -67,10 +67,6 @@ by the same sixteen bytes in
 format enclosed in
 .RB ' | '
 characters.
-.IP "\fB\-L\fR, \fB\-\-color\fR[=\fIwhen\fR]"
-Accept color units for the output  (enabled by default). The optional argument \fIwhen\fP
-can be \fBauto\fR, \fBnever\fR or \fBalways\fR.  If the \fIwhen\fR argument is omitted,
-then it defaults to \fBauto\fR.
 .TP
 \fB\-d\fR, \fB\-\-two\-bytes\-decimal\fR
 \fITwo-byte decimal display\fR.  Display the input offset in hexadecimal,
@@ -80,11 +76,16 @@ of input data, in unsigned decimal, per line.
 \fB\-e\fR, \fB\-\-format\fR \fIformat_string\fR
 Specify a format string to be used for displaying data.
 .TP
-\fB\-r\fR, \fB\-\-format\-file\fR \fIfile\fR
-Specify a file that contains one or more newline separated format strings.
+\fB\-f\fR, \fB\-\-format\-file\fR \fIfile\fR
+Specify a file that contains one or more newline-separated format strings.
 Empty lines and lines whose first non-blank character is a hash mark (\&#)
 are ignored.
 .TP
+\fB\-L\fR, \fB\-\-color\fR[=\fIwhen\fR]
+Accept color units for the output (enabled by default).  The optional argument \fIwhen\fP
+can be \fBauto\fR, \fBnever\fR or \fBalways\fR.  If the \fIwhen\fR argument is omitted,
+then it defaults to \fBauto\fR.
+.TP
 \fB\-n\fR, \fB\-\-length\fR \fIlength\fR
 Interpret only
 .I length
-- 
1.7.0.4

