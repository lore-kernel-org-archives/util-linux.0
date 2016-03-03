Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:59431 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435AbcCCQVh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 Mar 2016 11:21:37 -0500
Subject: Re: Fixing su + runuser vulnerability CVE-2016-2779
To: up201407890@alunos.dcc.fc.up.pt
References: <56D7409A.6050407@suse.cz>
 <20160303013722.22156xdxrqmywgw0@webmail.alunos.dcc.fc.up.pt>
Cc: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Message-ID: <56D8648F.60504@suse.cz>
Date: Thu, 3 Mar 2016 17:21:35 +0100
MIME-Version: 1.0
In-Reply-To: <20160303013722.22156xdxrqmywgw0@webmail.alunos.dcc.fc.up.pt>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mar 3, 2016 at 01:37 up201407890@alunos.dcc.fc.up.pt wrote:

> On another note, grsecurity recently released a new feature named
> GRKERNSEC_HARDEN_TTY that disallows the use of TIOCSTI to unprivileged
> users unless the caller has CAP_SYS_ADMIN.

This will fix all util-linux issues, but not chroot. There root inside 
the chroot escapes from chroot and calls commands outside.

I can imagine yet another kernel level solution:

Implement a way to disallow TIOCSTI, eventually revoke terminal R/W access.

This would need application level fixes:
- Before calling the restricted process, disallow TIOCSTI.
- After returning from the restricted process, revoke terminal R/W.

> Brad Spengler (spender) said
> that looking into it, he didn't find legitimate uses of such ioctl, and
> no wide usage of writevt.

Some old systems had tiocsti(1) utility, probably used like a 
predecessor of readline.

Just for curiosity, I just ran grep for TIOCSTI ioctl() over all 
openSUSE sources. I got about 60 matches.

I analyzed use of some cases:

util-linux: used in agetty in wait_for_term_input()
kbd: contrib utility sti equal to tiocsti utility.
irda: Used by handle_scancode() to emulate input.
tcsh: Used in ed mode and in pushback().
emacs: Used in stuff_char() (putting char to be read from terminal)
...

It seems that TIOCSTI is used for:
- Read character, and if it does not match, put it back.
- Wait for character, than put it back for processing.
- Implementing a simple line editing.

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
