Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:48243 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758669Ab2FAJXR (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 1 Jun 2012 05:23:17 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id DE0F09B53E
	for <util-linux-ng@vger.kernel.org>; Fri,  1 Jun 2012 11:23:15 +0200 (CEST)
Message-ID: <4FC88A00.90004@suse.de>
Date: Fri, 01 Jun 2012 11:23:12 +0200
From: Ludwig Nussel <ludwig.nussel@suse.de>
MIME-Version: 1.0
To: util-linux-ng@vger.kernel.org
Subject: Re: [pull] su.1 manual page
References: <CAG27Bk3YrUc4cwpUou5o005S165LOc4C8bPHp-EnkwAz2WsFng@mail.gmail.com> <4FC72679.7050307@suse.de> <CAG27Bk0E79L9Tb7zi0M6ditsxr46LKJcy6Rn1KqFi5wrxTB4pw@mail.gmail.com>
In-Reply-To: <CAG27Bk0E79L9Tb7zi0M6ditsxr46LKJcy6Rn1KqFi5wrxTB4pw@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------050702040304020205010809"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050702040304020205010809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

Sami Kerola wrote:
> On Thu, May 31, 2012 at 10:06 AM, Ludwig Nussel <ludwig.nussel@suse.de> wrote:
>>> Please find from my git a su(1) manual page candidate.  The text is
>>> almost one to one copy with GNU Coreutils 'su invocation' info page,
>>> so it is questionable if I "wrote" the man page.  To feel a little
>>
>> Hmm, I was about to write a man page from scratch. Should I continue or
>> do we use the coreutils man page?
> 
> 1. Continue writing from scratch, and propose your own man page candidate.

I've attached my suggestion

cu
Ludwig

-- 
 (o_   Ludwig Nussel
 //\
 V_/_  http://www.suse.de/
SUSE LINUX Products GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer, HRB 16746 (AG Nürnberg) 

--------------050702040304020205010809
Content-Type: text/plain; charset=UTF-8;
 name="su.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="su.1"

.TH SU 1 "May 2012" "util-linux" "User Commands"
.SH NAME
su \- Run a command with substitute user and group ID
.SH SYNOPSIS
.B su
[OPTIONS...] [\-] [USER [ARGS...]]
.SH DESCRIPTION
.B su
allows to run commands with substitute user and group ID.

When called without arguments \fBsu\fR defaults to running an interactive shell
as \fIroot\fR.

For backward compatibilty \fBsu\fR defaults to not change the
current directory and to only set the enviroment variables
\fBHOME\fR and \fBSHELL\fR (plus \fBUSER\fR and \fBLOGNAME\fR if the
target user is not root). It's recommended to always use the
\fB\-\-login\fR option (resp it's shortcut \fB-\fR) to avoid side
effects caused by mixing environments.

This version of \fBsu\fR uses PAM for authentication, account and
session management. Some configuration options found in other
\fBsu\fR implementations such as e.g. support of a wheel group have
to be configured via PAM.


.SH OPTIONS
.TP
\fB\-c\fR \fICOMMAND\fR, \fB\-\-command\fR=\fICOMMAND\fR
Pass COMMAND to the shell with the
.B -c
option

.TP
\fB\-\-session\-command\fR=\fICOMMAND\fR
Same as \fB-c\fR but do not create a new session (discouraged)

.TP
\fB\-f\fR, \fB\-\-fast\fR
Pass \fB\-f\fR to the shell which may or may not be useful depending
on the shell.

.TP
\fB\-\fR, \fB\-l\fR, \fB\-\-login\fR
Starts the shell as login shell with an environment similar to a
real login:

\- clears all environment variables except for \fBTERM\fR

\- initializes the environment variables \fBHOME\fR, \fBSHELL\fR,
\fBUSER\fR, \fBLOGNAME\fR, \fBPATH\fR

\- changes to the target user's home directory

\- sets argv[0] of the shell to \fB\-\fR in order to make the shell
a login shell

.TP
\fB\-m\fR, \fB\-p\fR, \fB\-\-preserve-environment\fR
Preserves the whole environment, ie does not set \fBHOME\fR,
\fBSHELL\fR, \fBUSER\fR nor \fBLOGNAME\fR.

.TP
\fB\-s\fR \fISHELL\fR, \fB\-\-shell\fR=\fISHELL\fR
Runs the specified shell instead of the default. The shell to run is
selected according to the following rules in order:

\- the shell specified with \fB\-\-shell\fR

\- The shell specified in the environment variable \fBSHELL\fR if
the \fB\-\-preserve-environment\fR option is used.

\- the shell listed in the passwd entry of the target user

\- /bin/sh

If the target user has a restricted shell (ie not listed in
/etc/shells) the \fB\-\-shell\fR option and the \fBSHELL\fR
environment variables are ignored unless the calling user is root.

.TP
\fB\-\-help\fR
Display help text and exit

.TP
\fB\-\-version\fR
Display version information and exit

.SH CONFIG FILES
.B su
reads the
.IR /etc/default/su
and
.IR /etc/login.defs
configuration files.
The following configuration items are relevant for
.BR su (1):
.PP
\fBFAIL_DELAY\fR (number)
.RS 4
Delay in seconds in case of authentication failure.
.RE
.PP
\fBENV_PATH\fR (string)
.RS 4
Defines the PATH environment variable for a regular
user. The default value is "/usr/local/bin:/bin:/usr/bin".
.RE
.PP
\fBENV_ROOTPATH\fR (string), \fBENV_SUPATH\fR (string)
.RS 4
Defines the PATH environment variable for root. The default value is
"/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin".
.RE
.PP
\fBALWAYS_SET_PATH\fR (boolean)
.RS 4
If set to "yes" and \-\-login and \-\-preserve\-environment were
not specified initializes \fBPATH\fR
.RE
.SH EXIT STATUS
\fBsu\fR normall returns the exit status of the command it executed.
If the command was killed by a signal, \fBsu\fR returns the number
of the signal plus 128.

Exit status generated by \fBsu\fR itself:
.TP
1
Generic error before executing the requested command
.TP
126
The requested command could not be executed
.TP
127
The requested command could was not found
.SH FILES
.nf
/etc/pam.d/su   \- default PAM configuration file
/etc/pam.d/su-l \- PAM configuration file if \-\-login is specified
/etc/default/su
/etc/login.defs
.fi
.SH "SEE ALSO"
.BR pam (8),
.BR shells (5),
.BR login.defs (5),
.SH AUTHOR
Derived from coreutils' su which was based on an implemenation from David MacKenzie
.SH AVAILABILITY
The su command is part of the util-linux package and is available from
ftp://ftp.kernel.org/pub/linux/utils/util-linux/.

--------------050702040304020205010809--
