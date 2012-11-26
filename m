Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:42742 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199Ab2KZTEJ convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 26 Nov 2012 14:04:09 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so4673054eek.19
        for <util-linux@vger.kernel.org>; Mon, 26 Nov 2012 11:04:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20121126100822.GA4224@x2.net.home>
References: <b9e1a13168f41cde97e1fdaa21cdc5354ef535ea.1353702119.git.luto@amacapital.net>
 <50AFE72B.1010908@draigBrady.com> <20121126100822.GA4224@x2.net.home>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 26 Nov 2012 11:03:47 -0800
Message-ID: <CALCETrVrmkzGgLniSc8JdR7_Xtus61vR169EOzi=Ue-r7TqwUw@mail.gmail.com>
Subject: Re: [PATCH] Add no_new_privs
To: Karel Zak <kzak@redhat.com>
Cc: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>,
        util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 26, 2012 at 2:08 AM, Karel Zak <kzak@redhat.com> wrote:
> On Fri, Nov 23, 2012 at 09:14:19PM +0000, Pádraig Brady wrote:
>> On 11/23/2012 08:23 PM, Andy Lutomirski wrote:
>> >---
>> >
>> >I'm not 100% sure this is appropriate for util-linux, but it seems useful.
>> >
>> >I've never written new programs for util-linux before, and I barely understand
>> >autotools.  Feedback is welcome :)
>> >
>> >+no_new_privs \- run program with new_new_privs set
>>
>> >+Sets the \fIno_new_privs\fP bit and then executes specified program.  With
>> >+this bit set,
>> >+.BR execve (2)
>> >+will not grant new privileges.  For example, the setuid
>> >+and setgid bits as well as file capabilities will not function.  This bit
>> >+is inherited by child processes and cannot be unset.  See
>> >+.BR prctl (2)
>> >+and
>> >+.IR Documentation/prctl/no_new_privs.txt
>> >+in the Linux kernel source.
>>
>> Seems very useful but a bit low level for a user command.
>> How about a prctl(1) command or equivalent, that could
>> accept that among other options to set.
>
>  It would be nice to have prctl(1) implemented like prlimit(1), it
>  means to support --set as well as --get operations.
>
>   prctl --set-endian=big --set-name=foo
>
>   prctl --pid 123    # return all --get-*
>
>   prctl --get-name --pid 123
>
>> I also notice the similar capsh(1) program for doing
>> so with capabilities. Perhaps these could be merged
>> to a setpriv(1) command or something for tweaking all
>> these knobs before exec?
>
>  hmm.. capsh(1) is libcap baby and it probably makes sense to maintain
>  it on the same place like libcap.

Taking a quick look through prctl:

PR_CAPBSET_READ/DROP: these want libcap for parsing, and maybe they
should go in capsh.  (Also, dropping caps requires privilege.)

PR_SET/GET_DUMPABLE: IIRC these are cleared on exec.

PR_SET/GET_ENDIAN: Does this survive exec?  I'd assume it's an ELF
header flag as well.

PR_SET/GET_FPEMU: IA-64 only.  Seems to be of limited use.

PR_SET/GET_FPEXC: Not sure about this one.

PR_SET/GET_KEEPCAPS: Useless except in combination with capsh-like controls.

PR_SET/GET_NAME: Reset on exec

PR_SET/GET_PDEATHSIG: This is potentially very useful.

PR_SET/GET_SECCOMP: This is way too specialized for a general tool.  A
general-purpose seccomp mode 2 sandbox would be wonderful, but it
would be rather complex is and is far beyond the scope of util-linux
IMO.  seccomp mode 1 is simple but entirely incompatible with exec.

PR_SET/GET_SECUREBITS: Useful.  Requires some parsing.  Might be
supported by capsh already.

PR_SET_TIMING: According to the man page, it gives you a choice of one option.

PR_GET/SET_TSC: Potentially useful.

PR_GET/SET_UNALIGN: Potentially useful on some platforms.

PR_MCE_KILL[_GET]: Potentially useful.

PR_GET/SET_TIMERSLACK: Useful

PR_TASK_PERF_EVENTS_ENABLE/DISABLE: No clue

PR_SET_MM: I'm not sure this is useful across exec

PR_SET_PTRACER: Maybe useful.  I don't know if it survives exec.

PR_GET/SET_CHILD_SUBREAPER: Very useful, but probably wants to be its own tool

PR_GET_TID_ADDRESS: Not useful


Do we want the useful flags in a prctl(1) tool or should the
security-related ones possibly be in their own tool (maybe capsh;
maybe something else)?

--Andy
