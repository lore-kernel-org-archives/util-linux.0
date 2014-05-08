Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:49267 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856AbaEHU0j (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 May 2014 16:26:39 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: kerolasa@gmail.com
Subject: Re: last: please review -F and --time-format
Date: Thu, 8 May 2014 22:26:36 +0200
Cc: "util-linux" <util-linux@vger.kernel.org>
References: <201405071631.53729.sweet_f_a@gmx.de> <CAG27Bk0fWizWdEhQQUxQNVHp+SsM71qZwqgXgXbhVKxBZkmY+g@mail.gmail.com>
In-Reply-To: <CAG27Bk0fWizWdEhQQUxQNVHp+SsM71qZwqgXgXbhVKxBZkmY+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201405082226.36617.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thursday 08 May 2014, Sami Kerola wrote:
> On 7 May 2014 15:31, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> > IMO -F and --time-format=xxx need some review/cleanup regarding
> > logout times "still running" and "gone - no logout".
> >
> > Is there any reason why -F and --time-format=full
> > look different? --time-format=notime looks ugly too.
> >
> > See the all the cases here:
> > ------------
> > for opt in -F --time-format=full --time-format=iso
> > --time-format=short --time-format=notime; do echo "### $opt ###"
> >     ./last  -f ../tests/ts/last/wtmp.LE  $opt  | grep "running\| no
> > logout" done
> >
> > ### -F ###
> > torvalds linux        hobby            Mon Aug 26 02:57:08 1991  
> > gone - no logout reboot   system boot  system-name      Wed Aug 28
> > 20:00:00 2013   still running ### --time-format=full ###
> > torvalds linux        hobby            Mon Aug 26 02:57:08 1991   
> > gone                    - no logout reboot   system boot 
> > system-name      Wed Aug 28 20:00:00 2013   still                  
> >  running ### --time-format=iso ###
> > torvalds linux        hobby            1991-08-26T02:57:08+0200  
> > gone - no logout reboot   system boot  system-name     
> > 2013-08-28T20:00:00+0200   still running ### --time-format=short
> > ###
> > torvalds linux        hobby            Mon Aug 26 02:57    gone -
> > no logout reboot   system boot  system-name      Wed Aug 28 20:00  
> > still running ### --time-format=notime ###
> > torvalds linux        hobby              - no logout
> > reboot   system boot  system-name        running
>
> Hi Ruediger,
>
> The alignment makes sense when you look the printout where there are
> sessions  that are still present, no logout, and logged out.

Yes but I wondered why is there a difference between "full" and -F 
while "iso" behaves equally to -F.

> In 
> --time-format=full the hyphen in front of 'no logout' does look a bit
> silly. If it really bothers you send a patch.

That's a bit ugly to fix without more refactoring. I've tried here to 
address both issues:
https://github.com/karelzak/util-linux/pull/73

cu,
Rudi
