Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45048 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753852Ab2LIWY5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 9 Dec 2012 17:24:57 -0500
Message-ID: <50C50FB3.7080903@draigBrady.com>
Date: Sun, 09 Dec 2012 22:24:51 +0000
From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Andy Lutomirski <luto@amacapital.net>
CC: util-linux@vger.kernel.org,
        =?ISO-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>,
        Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] Add setpriv, a tool to set privileges and such
References: <b9e1a13168f41cde97e1fdaa21cdc5354ef535ea.1353702119.git.luto@amacapital.net> <5a4bb50baed87dbe00be9003dad7cc1ba59ca571.1354954632.git.luto@amacapital.net>
In-Reply-To: <5a4bb50baed87dbe00be9003dad7cc1ba59ca571.1354954632.git.luto@amacapital.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 12/08/2012 08:19 AM, Andy Lutomirski wrote:
> This can set no_new_privs, uid, gid, groups, securebits, inheritable caps, the cap
> bounding set, securebits, and selinux and apparmor labels.

Thanks a lot for doing this.

> +.BR \--securebits=(+|-)securebit,...
> +Sets or clears securebits.  The valid securebits are \fInoroot\fP, \fInoroot_locked\fP,
> +\fIno_setuid_fixup\fP, \fIno_setuid_fixup_locked\fP, and \fIkeep_caps_locked\fP.
> +\fIkeep_caps\fP is cleared by
> +.BR execve (2)
> +and is therefore not allowed.

It might be good to at least mention this is in relation to
capabilities and add a cross reference to cap_ng(3)

> +
> +.TP
> +.BR \--selinux-label
> +Requests a particular SELinux transition (using a transition on exec, not dyntrans).
> +This will fail and cause
> +.BR setpriv (1)
> +to abort if SELinux is not in use, and the transition may be ignored or cause
> +.BR execve (2)
> +to fail at SELinux's whim.  (In particular, this is unlikely to work in conjunction
> +with \fIno_new_privs\fP.)

In general it could be good to reference specific tools
that can do the same thing. runcon(1) in this case.

> +.TP
> +.BR \-h , " \-\-help"
> +Print a help message,
> +.SH NOTES
> +If applying any specified option fails, \fIprogram\fP will not be run and
> +\fIsetpriv\fP will return with exit code 127.

It seems worth standardising on error.
Most commands that exec on behalf of another use something like
the following, which I snarfed from timeout(1):

      EXIT_CANCELED      125      internal error
      EXIT_CANNOT_INVOKE 126      error executing job
      EXIT_ENOENT        127      couldn't find job to exec

So I suppose you could use 125 if there was an error setting an option,
so that an exec wasn't even tried.

thanks again!
Pádraig.
