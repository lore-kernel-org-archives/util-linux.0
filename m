Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.alunos.dcc.fc.up.pt ([193.136.39.109]:59213 "EHLO
	smtp.alunos.dcc.fc.up.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbcCDSDY convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 4 Mar 2016 13:03:24 -0500
Message-ID: <20160304190312.17036kwlv8g5ydk4@webmail.alunos.dcc.fc.up.pt>
Date: Fri, 04 Mar 2016 19:03:12 +0100
From: up201407890@alunos.dcc.fc.up.pt
To: "Stanislav Brabec" <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: Fixing su + runuser vulnerability CVE-2016-2779
References: <56D7409A.6050407@suse.cz>
	<20160303013722.22156xdxrqmywgw0@webmail.alunos.dcc.fc.up.pt>
	<56D8648F.60504@suse.cz> <56D9B445.5080808@suse.cz>
In-Reply-To: <56D9B445.5080808@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Quoting "Stanislav Brabec" <sbrabec@suse.cz>:

> On Mar 3, 2016 at 17:21 Stanislav Brabec wrote:
>> On Mar 3, 2016 at 01:37 up201407890@alunos.dcc.fc.up.pt wrote:
>>
>>> On another note, grsecurity recently released a new feature named
>>> GRKERNSEC_HARDEN_TTY that disallows the use of TIOCSTI to unprivileged
>>> users unless the caller has CAP_SYS_ADMIN.
>>
>> This will fix all util-linux issues, but not chroot. There root inside
>> the chroot escapes from chroot and calls commands outside.

Haven't looked into it, but grsecurity also has several chroot  
hardening features, so maybe this is why HARDEN_TTY was enough.

> Here are possibilities:
>
> 1) Quick kernel fix disabling TIOCSTI ioctl() for non-root, if the PID
> of the terminal owner is not equal to PID of the calling process,
> eventually use capabilities for the same.
>
> Pros:
> + Fix in one place.
> + Fix all possible future abuses.
>
> Cons:
> - Many utilities are potentially affected and need testing.
> - Some custom code could be affected. (I can imagine for example bar
>   code reader running with a dedicated UID, and pushing bar code to the
>   terminal. Such code will break for sure.)
>

Definitely needs testing.

>
> 2) Per utility fix using setsid().
>
> Pros:
> + Prevents the exploit without uncertain side effects.
>
> Cons:
> - Each affected utility needs fix.
> - Loss of job control will affect working style of many people.

Most weren't fixed because of this reason, it's likely they won't  
change it now.

> Conclusion:
>
> We need a different solution:
>
> 3) Introduce new terminal ioctl() or flag in the kernel. This flag will
> block TIOCSTI (and possibly other dangerous actions). It will allow to
> implement something like setsid(), but without side effects of job
> control loss.
>
> Pros:
> + No unwanted side effects at all.
>
> Cons:
> - Each affected utility needs fix.

Seems reasonable to me.

>
> We think, that only 3 will be safe and have no side effects.
>
>
> Note:
>
> Fixing character stealing described in previous mails is not covered by
> any of these solutions. This could be possible safely only with a new
> syscall revoke(), which was not yet accepted to the kernel.


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.

