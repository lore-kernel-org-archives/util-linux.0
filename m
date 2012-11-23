Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62743 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756227Ab2KWVOY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 23 Nov 2012 16:14:24 -0500
Message-ID: <50AFE72B.1010908@draigBrady.com>
Date: Fri, 23 Nov 2012 21:14:19 +0000
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Andy Lutomirski <luto@amacapital.net>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] Add no_new_privs
References: <b9e1a13168f41cde97e1fdaa21cdc5354ef535ea.1353702119.git.luto@amacapital.net>
In-Reply-To: <b9e1a13168f41cde97e1fdaa21cdc5354ef535ea.1353702119.git.luto@amacapital.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 11/23/2012 08:23 PM, Andy Lutomirski wrote:
> ---
>
> I'm not 100% sure this is appropriate for util-linux, but it seems useful.
>
> I've never written new programs for util-linux before, and I barely understand
> autotools.  Feedback is welcome :)
>
> +no_new_privs \- run program with new_new_privs set

> +Sets the \fIno_new_privs\fP bit and then executes specified program.  With
> +this bit set,
> +.BR execve (2)
> +will not grant new privileges.  For example, the setuid
> +and setgid bits as well as file capabilities will not function.  This bit
> +is inherited by child processes and cannot be unset.  See
> +.BR prctl (2)
> +and
> +.IR Documentation/prctl/no_new_privs.txt
> +in the Linux kernel source.

Seems very useful but a bit low level for a user command.
How about a prctl(1) command or equivalent, that could
accept that among other options to set.
I also notice the similar capsh(1) program for doing
so with capabilities. Perhaps these could be merged
to a setpriv(1) command or something for tweaking all
these knobs before exec?

cheers,
Pádraig.
