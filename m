Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:44189 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbeCFPhS (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 6 Mar 2018 10:37:18 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: agetty /etc/issue handling
Date: Tue, 6 Mar 2018 16:37:08 +0100
Cc: Ludwig Nussel <ludwig.nussel@suse.de>, util-linux@vger.kernel.org
References: <2fb8c760-3be8-a77f-0ab1-ad67ebca63cb@suse.de> <201803061451.37202.sweet_f_a@gmx.de> <20180306143323.ssny4nslxnmsuoxu@ws.net.home>
In-Reply-To: <20180306143323.ssny4nslxnmsuoxu@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201803061637.09015.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tuesday 06 March 2018, Karel Zak wrote:
> On Tue, Mar 06, 2018 at 02:51:36PM +0100, Ruediger Meier wrote:
> > To be honest, I don't really like that emergency-critical things
> > like agetty will need to read dozens of files from many different
> > file systems ... just for cosmetical reasons. IMO a 3rd party
> > issue-generator is the better way.
>
> All the stuff should be optional.
>
> The reason is that growing number of use-cases where specific
> subsystem or software want to print any information by the issue
> file. (I mean containers, virtualization, serial line
> redirections/switches, etc.)
>
> We don't want to store generated things in /etc (read-only,
> state-less machines, ...), so at least /run (usually tmpfs) seems
> like good choice.

I see the use case but I don't see that we need new functionality inside 
agetty because distros could either use

  agetty --issue-file /run/generated-issues

or

  ln -sf /run/generated-issues /etc/issues

Speaking as an admin I really hate that distros nowadays introduce more 
and more techniques to let 3rd parties change global setup within /usr 
(where I don't see it) instead of using /etc which I track and review 
using git.

I fully understand that this makes it much easier for the distro 
developers. But the resulting systems are more difficult and complex to 
understand and to debug for the admins.

BTW looking over /etc we could actually use the "agetty argument" to 
introduce the "/usr-/run/-/etc merge technique" also for any other 
programs too. Why not moving the distro's default
/etc/hosts, /etc/services, /etc/ntp.conf, /etc/cron.d, *everything* 
to /usr? No more noise in /etc on upgrade/install...

Will admins be more happy when all installations and distros finally 
have the same empty /etc by default but still being completely 
differently configured *somewere* in /run and /usr?

cu,
Rudi


