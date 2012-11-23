Return-Path: util-linux-owner@vger.kernel.org
Received: from sender1.zohomail.com ([72.5.230.103]:33375 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932202Ab2KWXLw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 23 Nov 2012 18:11:52 -0500
Message-ID: <50AFFE46.4090309@zoho.com>
Date: Fri, 23 Nov 2012 23:52:54 +0100
From: =?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
MIME-Version: 1.0
To: Andy Lutomirski <luto@amacapital.net>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] Add no_new_privs
References: <b9e1a13168f41cde97e1fdaa21cdc5354ef535ea.1353702119.git.luto@amacapital.net>
In-Reply-To: <b9e1a13168f41cde97e1fdaa21cdc5354ef535ea.1353702119.git.luto@amacapital.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 23/11/12 21:23, Andy Lutomirski wrote:
> ---
> 
> I'm not 100% sure this is appropriate for util-linux, but it seems useful.
> 
> I've never written new programs for util-linux before, and I barely understand
> autotools.  Feedback is welcome :)
(...)

> --- /dev/null
> +++ b/sys-utils/no_new_privs.1
> @@ -0,0 +1,37 @@
> +.\" Process this file with
> +.\" groff -man -Tascii no_new_privs.1
> +.\"
> +.TH NO_NEW_PRIVS 1 "December 2012" "util-linux" "User Commands"
> +.SH NAME
> +no_new_privs \- run program with new_new_privs set
s/new_new_privs/no_new_privs/

> +.SH SYNOPSIS
> +.B no_new_privs
> +.RI [ options ]
> +program
> +.RI [ arguments ]
> +.SH DESCRIPTION
> +Sets the \fIno_new_privs\fP bit and then executes specified program.  With
> +this bit set,
> +.BR execve (2)
> +will not grant new privileges.  For example, the setuid
> +and setgid bits as well as file capabilities will not function.  This bit
"will not be granted" instead of "will not function"?
It's not clear from the description if a privileged program would run
without setuid or if it wouldn't run at all (although to be fair,
no_new_privs.txt doesn't clarify that, either).

> +is inherited by child processes and cannot be unset.  See
> +.BR prctl (2)
> +and
> +.IR Documentation/prctl/no_new_privs.txt
> +in the Linux kernel source.
> +.SH OPTIONS
> +.TP
> +.BR \-h , " \-\-help"
> +Print a help message,
> +.SH NOTES
> +If setting the no_new_privs bit fails, \fIprogram\fP will not be run.

Also document that it will return 1 ?
It is possible that something like 127 would be more appropiate, though.


> +.SH SEE ALSO
> +.BR prctl (2)
> +.SH BUGS
> +None known so far.
> +.SH AUTHOR
> +Andy Lutomirski <luto@amacapital.net>
> +.SH AVAILABILITY
> +The no_new_privs command is part of the util-linux package and is available from
> +ftp://ftp.kernel.org/pub/linux/utils/util-linux/.

IMHO it should mention that PR_SET_NO_NEW_PRIVS is available since Linux
3.5

(...)


