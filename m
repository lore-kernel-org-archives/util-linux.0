Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751616AbeCHKXz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 8 Mar 2018 05:23:55 -0500
Date: Thu, 8 Mar 2018 11:23:51 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Ludwig Nussel <ludwig.nussel@suse.de>, util-linux@vger.kernel.org
Subject: Re: agetty /etc/issue handling
Message-ID: <20180308102351.l72qmcjhswd5acnx@ws.net.home>
References: <2fb8c760-3be8-a77f-0ab1-ad67ebca63cb@suse.de>
 <201803061451.37202.sweet_f_a@gmx.de>
 <20180306143323.ssny4nslxnmsuoxu@ws.net.home>
 <201803061637.09015.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201803061637.09015.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 06, 2018 at 04:37:08PM +0100, Ruediger Meier wrote:
> On Tuesday 06 March 2018, Karel Zak wrote:
> > On Tue, Mar 06, 2018 at 02:51:36PM +0100, Ruediger Meier wrote:
> > > To be honest, I don't really like that emergency-critical things
> > > like agetty will need to read dozens of files from many different
> > > file systems ... just for cosmetical reasons. IMO a 3rd party
> > > issue-generator is the better way.
> >
> > All the stuff should be optional.
> >
> > The reason is that growing number of use-cases where specific
> > subsystem or software want to print any information by the issue
> > file. (I mean containers, virtualization, serial line
> > redirections/switches, etc.)
> >
> > We don't want to store generated things in /etc (read-only,
> > state-less machines, ...), so at least /run (usually tmpfs) seems
> > like good choice.
> 
> I see the use case but I don't see that we need new functionality inside 
> agetty because distros could either use
> 
>   agetty --issue-file /run/generated-issues
> 
> or
> 
>   ln -sf /run/generated-issues /etc/issues
> 
> Speaking as an admin I really hate that distros nowadays introduce more 
> and more techniques to let 3rd parties change global setup within /usr 
> (where I don't see it) instead of using /etc which I track and review 
> using git.
> 
> I fully understand that this makes it much easier for the distro 
> developers. But the resulting systems are more difficult and complex to 
> understand and to debug for the admins.

That's all about different update cycles for different setting. The
/etc is place for manually created setup, /run for generated and /usr
for static distro stuff (from packages). You don't want to maintain 
all on the same place.

There is also dramatically growing number of systems where is no admin
at all and all is generated on the fly, root is read-only and after
installation it's expected that system (container) just works with
minimal extra tuning by post-install scripts. We have to reflect these
use-cases too.

Anyway, it's backwardly compatible. You can use /etc/issue as 20 years
ago. This is the most important thing for me. Nobody forces anyone to 
use the new features and it's distro decision if they want to use 
/usr/lib, etc. We're ready for both use-cases.

> BTW looking over /etc we could actually use the "agetty argument" to 
> introduce the "/usr-/run/-/etc merge technique" also for any other 
> programs too. Why not moving the distro's default
> /etc/hosts, /etc/services, /etc/ntp.conf, /etc/cron.d, *everything* 
> to /usr? No more noise in /etc on upgrade/install...

Maybe one day... :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
