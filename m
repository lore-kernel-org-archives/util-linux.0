Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.alunos.dcc.fc.up.pt ([193.136.39.109]:33287 "EHLO
	smtp.alunos.dcc.fc.up.pt" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbcCCAzL convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 2 Mar 2016 19:55:11 -0500
Message-ID: <20160303013722.22156xdxrqmywgw0@webmail.alunos.dcc.fc.up.pt>
Date: Thu, 03 Mar 2016 01:37:22 +0100
From: up201407890@alunos.dcc.fc.up.pt
To: "Stanislav Brabec" <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: Fixing su + runuser vulnerability CVE-2016-2779
References: <56D7409A.6050407@suse.cz>
In-Reply-To: <56D7409A.6050407@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Quoting "Stanislav Brabec" <sbrabec@suse.cz>:


> To Federico Bento: Could you confirm that you are author and approve
> the license in the test_tiocsti.c, please?

There were vulnerabilities in the past regarding the same issue for  
different programs ("su" for example, CVE-2005-4890), that when  
reported, used the same technique. The program is the most basic you  
can get to demonstrate this, so i'm pretty sure i wasn't the only one  
that used something similar.
At the time, though, i wrote it off my head. This doesn't mean, as I  
said, that no one wrote something very similar, so i'm not really sure  
if I should be credited for something that has a high probability of  
having been written before.


On another note, grsecurity recently released a new feature named  
GRKERNSEC_HARDEN_TTY that disallows the use of TIOCSTI to unprivileged  
users unless the caller has CAP_SYS_ADMIN. Brad Spengler (spender)  
said that looking into it, he didn't find legitimate uses of such  
ioctl, and no wide usage of writevt.

https://gitweb.gentoo.org/proj/hardened-patchset.git/commit/?id=d47ea9080b76a7445e8a36545c539b2a62c31faa

Check out gr_handle_tiocsti()


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.

