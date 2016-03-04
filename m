Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:36659 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759275AbcCDQN7 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Mar 2016 11:13:59 -0500
Subject: Re: Fixing su + runuser vulnerability CVE-2016-2779
To: up201407890@alunos.dcc.fc.up.pt
References: <56D7409A.6050407@suse.cz>
 <20160303013722.22156xdxrqmywgw0@webmail.alunos.dcc.fc.up.pt>
 <56D8648F.60504@suse.cz>
Cc: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56D9B445.5080808@suse.cz>
Date: Fri, 4 Mar 2016 17:13:57 +0100
MIME-Version: 1.0
In-Reply-To: <56D8648F.60504@suse.cz>
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mar 3, 2016 at 17:21 Stanislav Brabec wrote:
> On Mar 3, 2016 at 01:37 up201407890@alunos.dcc.fc.up.pt wrote:
> 
>> On another note, grsecurity recently released a new feature named
>> GRKERNSEC_HARDEN_TTY that disallows the use of TIOCSTI to unprivileged
>> users unless the caller has CAP_SYS_ADMIN.
> 
> This will fix all util-linux issues, but not chroot. There root inside 
> the chroot escapes from chroot and calls commands outside.
> 
We had a talk about this bug, and we found, that there is no quick and
100% safe fix.

Here are possibilities:

1) Quick kernel fix disabling TIOCSTI ioctl() for non-root, if the PID
of the terminal owner is not equal to PID of the calling process,
eventually use capabilities for the same.

Pros:
+ Fix in one place.
+ Fix all possible future abuses.

Cons:
- Many utilities are potentially affected and need testing.
- Some custom code could be affected. (I can imagine for example bar
  code reader running with a dedicated UID, and pushing bar code to the
  terminal. Such code will break for sure.)


2) Per utility fix using setsid().

Pros:
+ Prevents the exploit without uncertain side effects.

Cons:
- Each affected utility needs fix.
- Loss of job control will affect working style of many people.


Conclusion:

We need a different solution:

3) Introduce new terminal ioctl() or flag in the kernel. This flag will
block TIOCSTI (and possibly other dangerous actions). It will allow to
implement something like setsid(), but without side effects of job
control loss.

Pros:
+ No unwanted side effects at all.

Cons:
- Each affected utility needs fix.


We think, that only 3 will be safe and have no side effects.


Note:

Fixing character stealing described in previous mails is not covered by
any of these solutions. This could be possible safely only with a new
syscall revoke(), which was not yet accepted to the kernel.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
