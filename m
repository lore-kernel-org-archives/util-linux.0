Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:32935 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaEXLIe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 24 May 2014 07:08:34 -0400
Received: by mail-wi0-f175.google.com with SMTP id f8so1998576wiw.2
        for <util-linux@vger.kernel.org>; Sat, 24 May 2014 04:08:33 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/4] docs: setterm.1 clean up manual page groff style
Date: Sat, 24 May 2014 12:08:16 +0100
Message-Id: <1400929696-12548-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Underline option arguments, and use bold for options.  Avoid use of \f
font style change in paragraphs, but use them when describing options.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.1 | 265 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 163 insertions(+), 102 deletions(-)

diff --git a/term-utils/setterm.1 b/term-utils/setterm.1
index 995e1c9..b3c8d6a 100644
--- a/term-utils/setterm.1
+++ b/term-utils/setterm.1
@@ -1,4 +1,4 @@
-\" Copyright 1990 Gordon Irlam (gordoni@cs.ua.oz.au)
+.\" Copyright 1990 Gordon Irlam (gordoni@cs.ua.oz.au)
 .\" Copyright 1992 Rickard E. Faith (faith@cs.unc.edu)
 .\" Most of this was copied from the source code.
 .\" Do not restrict distribution.
@@ -16,185 +16,244 @@ setterm \- set terminal attributes
 .RI [ options ]
 .SH DESCRIPTION
 .B setterm
-writes to standard output a character string that will invoke the
-specified terminal capabilities.  Where possible
+writes to standard output a character string that will invoke the specified
+terminal capabilities.  Where possible
 .I terminfo
-is consulted to find the string to use.  Some options however (marked
-"virtual consoles only" below) do not correspond to a
+is consulted to find the string to use.  Some options however (marked "virtual
+consoles only" below) do not correspond to a
 .BR terminfo (5)
-capability.  In this case, if the terminal type is "con" or "linux" the
-string that invokes the specified capabilities on the PC Minix virtual
-console driver is output.  Options that are not implemented by the terminal
-are ignored.
+capability.  In this case, if the terminal type is "con" or "linux" the string
+that invokes the specified capabilities on the PC Minix virtual console driver
+is output.  Options that are not implemented by the terminal are ignored.
 .SH OPTIONS
-For boolean options (\fBon\fP or \fBoff\fP), the default is \fBon\fP.
+For boolean options
+.RI ( on
+or
+.IR off ),
+the default is
+.IR on .
 .P
-For conciseness, an \fI8-color\fP below is \fBblack\fP, \fBred\fP,
-\fBgreen\fP, \fByellow\fP, \fBblue\fP, \fBmagenta\fP, \fBcyan\fP, or
-\fBwhite\fP.
+For conciseness, an
+.I 8-color
+below is
+.IR  black ,
+.IR  red ,
+.IR green ,
+.IR yellow ,
+.IR blue ,
+.IR magenta ,
+.IR cyan ,
+or
+.IR white .
 .P
-A \fI16-color\fP is an \fI8-color\fP, \fBgrey\fP, or \fBbright\fP followed
-by \fBred\fP, \fBgreen\fP, \fByellow\fP, \fBblue\fP, \fBmagenta\fP,
-\fBcyan\fP, or \fBwhite\fP.
+A
+.I 16-color
+is an
+.IR 8-color ,
+.IR grey ,
+or
+.IR bright
+followed
+by
+.IR red ,
+.IR green ,
+.IR yellow ,
+.IR blue ,
+.IR magenta ,
+.IR cyan ,
+or
+.IR white .
 .P
 The various color options may be set independently, at least at virtual
 consoles, though the results of setting multiple modes (for example,
-.BR \-\-underline " and " \-\-half-bright )
+.B \-\-underline
+and
+.BR \-\-half-bright )
 are hardware-dependent.
 .TP
-.BR \-\-appcursorkeys " [" on | off "] (virtual consoles only)"
-Sets Cursor Key Application Mode on or off. When on, ESC O A, ESC O B, etc.
+\fB\-\-appcursorkeys\fP \fIon\fP|\fIoff\fP (virtual consoles only)
+Sets Cursor Key Application Mode on or off.  When on, ESC O A, ESC O B, etc.
 will be sent for the cursor keys instead of ESC [ A, ESC [ B, etc.  See the
-"vi and Cursor-Keys" section of the Text-Terminal-HOWTO for how this can
-cause problems for vi users.
-.TP
-.BR \-\-append " [\fI1-NR_CONS\fP]"
-Like \fB\-\-dump\fP, but appends to the snapshot file instead of overwriting
-it.  Only works if no \fB\-\-dump\fP options are given.
-.TP
-\fB\-\-foreground\fP \fI8-color\fP|\fBdefault\fP (virtual consoles only)
+.I vi and Cursor-Keys
+section of the
+.I Text-Terminal-HOWTO
+for how this can cause problems for vi users.
+.TP
+\fB\-\-append\fP [\fI1-NR_CONS\fP]
+Like
+.BR \-\-dump ,
+but appends to the snapshot file instead of overwriting it.  Only works if no
+.B \-\-dump
+options are given.
+.TP
+\fB\-\-foreground\fP \fI8-color\fP|\fIdefault\fP (virtual consoles only)
 Sets the foreground text color.
 .TP
-\fB\-\-background\fP \fI8-color\fP|\fBdefault\fP (virtual consoles only)
+\fB\-\-background\fP \fI8-color\fP|\fIdefault\fP (virtual consoles only)
 Sets the background text color.
 .TP
-.BR \-\-blank " [\fI0-60\fP|\fBforce\fP|\fBpoke\fP] (virtual consoles only)"
+\fB\-\-blank\fP [\fI0-60\fP|\fIforce\fP|\fIpoke\fP] (virtual consoles only)
 Sets the interval of inactivity, in minutes, after which the screen will be
 automatically blanked (using APM if available).  Without an argument, gets the
 blank status (returns which vt was blanked or zero for unblanked vt).
-
+.IP
 The
-.B force
+.I force
 option keeps screen blank even if a key is pressed.
-
+.IP
 The
-.B poke
+.I poke
 option unblank the screen.
 .TP
-.BR \-\-bfreq " [\fIfreqnumber\fP]"
-Sets the bell frequency in Hz.  Without an argument, defaults to 0.
+\fB\-\-bfreq\fP [\fIfreqnumber\fP]
+Sets the bell frequency in Hertz.  Without an argument, defaults to
+.IR 0 .
 .TP
-.BR \-\-blength " [\fI0-2000\fP]"
-Sets the bell duration in milliseconds.  Without an argument, defaults to 0.
+\fB\-\-blength\fP [\fI0-2000\fP]
+Sets the bell duration in milliseconds.  Without an argument, defaults to
+.IR 0 .
 .TP
-.BR \-\-blink " [" on | off ]
-Turns blink mode on or off.  Except at a virtual console, \fB\-\-blink off\fP
+\fB\-\-blink\fP \fIon\fP|\fIoff\fP
+Turns blink mode on or off.  Except at a virtual console,
+.B \-\-blink off
 turns off all attributes (bold, half-brightness, blink, reverse).
 .TP
-.BR \-\-bold " [" on | off ]
-Turns bold (extra bright) mode on or off.  Except at a virtual console,
-\fB\-\-bold off\fP turns off all attributes (bold, half-brightness, blink,
-reverse).
-.TP
-.BR \-\-clear " [" all ]
-Clears the screen and "homes" the cursor, as
-.BR clear (1).
+\fB\-\-bold\fP \fIon\fP|\fIoff\fP
+Turns bold (extra bright) mode on or off. Except at a virtual console,
+.B \-\-bold off
+turns off all attributes (bold, half-brightness, blink, reverse).
 .TP
-.B \-\-clear rest
-Clears from the current cursor position to the end of the screen.
+\fB\-\-clear\fP \fIall\fP|\fIrest\fP
+With argument
+.I all
+the cursor is set to home position, and all output is removed from screen,
+.BR clear (1)
+does.  The argument
+.I rest
+clears from the current cursor position to the end of the screen.
 .TP
-.BR \-\-clrtabs " [\fItab1 tab2 tab3\fP ...] (virtual consoles only)"
+\fB\-\-clrtabs\fP [\fItab1 tab2 tab3\fP ...] (virtual consoles only)
 Clears tab stops from the given horizontal cursor positions, in the range
-1-160.  Without arguments, clears all tab stops.
+.IR 1-160 .
+Without arguments, clears all tab stops.
 .TP
-.BR \-\-cursor " [" on | off ]
+\fB\-\-cursor\fP \fIon\fP|\fIoff\fP
 Turns the terminal's cursor on or off.
 .TP
-.B \-\-default
+\fB\-\-default\fP
 Sets the terminal's rendering options to the default values.
 .TP
-.BR \-\-dump " [\fI1-NR_CONS\fP]"
-Writes a snapshot of the given virtual console to the file
-specified in the \fB\-\-file\fP option, overwriting its contents; the default
-is screen.dump.  Without an argument, dumps the current virtual console.
-Overrides \fB\-\-append\fP.
-.TP
-.BI \-\-file " dumpfilename"
-Sets the snapshot file name for any \fB\-\-dump\fP or \fB\-\-append\fP options
-on the same command line.  If this option is not present, the default is
-screen.dump in the current directory.  A path name that exceeds system
-maximum will be truncated, see PATH_MAX from linux/limits.h for the value.
+\fB\-\-dump\fP [\fI1-NR_CONS\fP]
+Writes a snapshot of the given virtual console to the file specified in the
+.B \-\-file
+option, overwriting its contents; the default is
+.IR screen.dump .
+Without an argument, dumps the current virtual console.  Overrides
+.BR \-\-append .
+.TP
+\fB\-\-file\fP \fIdumpfilename\fP
+Sets the snapshot file name for any
+.B \-\-dump
+or
+.B \-\-append
+options on the same command line.  If this option is not present, the default
+is
+.I screen.dump
+in the current directory.  A path name that exceeds system maximum will be
+truncated, see PATH_MAX from linux/limits.h for the value.
 .TP
 \fB\-\-hbcolor\fP \fI16-color\fP (virtual consoles only)
 Sets the color for bold characters.
 .TP
-.B \-\-initialize
+\fB\-\-initialize\fP
 Displays the terminal initialization string, which typically sets the
 terminal's rendering options, and other attributes to the default values.
 .TP
-.BR \-\-inversescreen " [" on | off "]"
+\fB\-\-inversescreen\fP \fIon\fP|\fIoff\fP
 Invert foreground and background color.
 .TP
-.BR \-\-linewrap " [" on | off "]"
+\fB\-\-linewrap\fP \fIon\fP|\fIoff\fP
 Continue on a new line when a line is full.
 .TP
-.BR \-\-msg " [" on | off "] (virtual consoles only)"
-Enables or disables the sending of kernel \fBprintk()\fP messages to the
-console.
-.TP
-.BR \-\-msglevel " \fI1-8\fP (virtual consoles only)"
-Sets the console logging level for kernel \fBprintk()\fP messages.  All
-messages strictly more important than this will be printed, so a logging
-level of 0 has the same effect as \fB\-\-msg on\fP and a logging level of 8
+\fB\-\-msg\fP \fIon\fP|\fIoff\fP (virtual consoles only)
+Enables or disables the sending of kernel
+.BR printk()
+messages to the console.
+.TP
+\fB\-\-msglevel\fP \fI0-8\fP (virtual consoles only)
+Sets the console logging level for kernel
+.B printk()
+messages.  All messages strictly more important than this will be printed, so a
+logging level of
+.I 0
+has the same effect as
+.B \-\-msg on
+and a logging level of
+.I 8
 will print all kernel messages.
 .BR klogd (8)
 may be a more convenient interface to the logging of kernel messages.
 .TP
-.BR \-\-powerdown " [\fI0-60\fP]"
+\fB\-\-powerdown\fP [\fI0-60\fP]
 Sets the VESA powerdown interval in minutes.  Without an argument, defaults
-to 0 (disable powerdown).  If the console is blanked or the monitor is in
-suspend mode, then the monitor will go into vsync suspend mode or powerdown
-mode respectively after this period of time has elapsed.
+to
+.I 0
+(disable powerdown).  If the console is blanked or the monitor is in suspend
+mode, then the monitor will go into vsync suspend mode or powerdown mode
+respectively after this period of time has elapsed.
 .TP
-.BR \-\-underline " [" on | off ]
-Turns underline mode on or off (see \fB\-\-ulcolor\fP).
+\fB\-\-underline\fP \fIon\fP|\fIoff\fP
+Turns underline mode on or off (see
+.BR \-\-ulcolor .
 .TP
-.BR \-\-powersave " [" off "]"
+\fB\-\-powersave\fP \fIoff\fP
 Turns off monitor VESA powersaving features.
 .TP
-.BR "\-\-powersave on" | vsync
+\fB\-\-powersave\fP \fIon\fP|\fIvsync\fP
 Puts the monitor into VESA vsync suspend mode.
 .TP
-.B \-\-powersave powerdown
+\fB\-\-powersave\fP \fIpowerdown\fP
 Puts the monitor into VESA powerdown mode.
 .TP
-.B \-\-powersave hsync
+\fB\-\-powersave\fP \fIhsync\fP
 Puts the monitor into VESA hsync suspend mode.
 .TP
-.BR \-\-regtabs " [\fI1-160\fP] (virtual consoles only)"
-Clears all tab stops, then sets a regular tab stop pattern, with one tab
-every specified number of positions.  Without an argument, defaults to 8.
+\fB\-\-regtabs\fP [\fI1-160\fP] (virtual consoles only)
+Clears all tab stops, then sets a regular tab stop pattern, with one tab every
+specified number of positions.  Without an argument, defaults to
+.IR 8 .
 .TP
-.BR \-\-repeat " [" on | off "] (virtual consoles only)"
+\fB\-\-repeat\fP \fIon\fP|\fIoff\fP (virtual consoles only)
 Turns keyboard repeat on or off.
 .TP
-.B \-\-reset
+\fB\-\-reset\fP
 Displays the terminal reset string, which typically resets the terminal to
 its power on state.
 .TP
-.BR \-\-reverse " [" on | off ]
+\fB\-\-reverse\fP \fIon\fP|\fIoff\fP
 Turns reverse video mode on or off.  Except at a virtual console,
-\fB\-\-reverse off\fP turns off all attributes (bold, half-brightness, blink,
-reverse).
+.B \-\-reverse off
+turns off all attributes (bold, half-brightness, blink, reverse).
 .TP
-.BR \-\-store " (virtual consoles only)"
-Stores the terminal's current rendering options (foreground and
-background colors) as the values to be used at reset-to-default.
+\fB\-\-store\fP (virtual consoles only)
+Stores the terminal's current rendering options (foreground and background
+colors) as the values to be used at reset-to-default.
 .TP
-.BR \-\-tabs " [\fItab1 tab2 tab3\fP ...] (virtual consoles only)"
-Sets tab stops at the given horizontal cursor positions, in the range 1-160.
+\fB\-\-tabs\fP [\fItab1 tab2 tab3\fP ...] (virtual consoles only)
+Sets tab stops at the given horizontal cursor positions, in the range
+.IR 1-160 .
 Without arguments, shows the current tab stop settings.
 .TP
-.BR \-\-term " terminal_name"
+\fB\-\-term\fP \fIterminal_name\fP
 Overrides the TERM environment variable.
 .TP
 \fB\-\-ulcolor\fP \fI16-color\fP (virtual consoles only)
 Sets the color for underlined characters.
 .TP
-.BR \-\-version
+\fB\-\-version\fP
 Display version information and exit.
 .TP
-.BR \-\-help
+\fB\-\-help\fP
 Display help text and exit.
 .SH COMPATIBILITY
 Since version 2.25 the
@@ -215,4 +274,6 @@ discontinue single hyphen compatibility.
 Differences between the Minix and Linux versions are not documented.
 .SH AVAILABILITY
 The setterm command is part of the util-linux package and is available from
-ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
-- 
1.9.3

