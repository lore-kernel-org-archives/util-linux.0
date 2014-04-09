Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:62820 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933256AbaDIPQK convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Apr 2014 11:16:10 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Thomas =?utf-8?q?B=C3=A4chler?= <thomas@archlinux.org>
Subject: Re: [PATCH] fstrim: add systemd units
Date: Wed, 9 Apr 2014 17:16:04 +0200
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org> <201404091412.34060.sweet_f_a@gmx.de> <534541E3.4080906@archlinux.org>
In-Reply-To: <534541E3.4080906@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201404091716.05131.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wednesday 09 April 2014, Thomas Bächler wrote:
> Am 09.04.2014 14:12, schrieb Ruediger Meier:
> >> well, "fstrim -a" contains heruistic to select the right filestems
> >> (it really does not call trim for all devices), it has been
> >> implemented to *avoid* sysadmins creativity. If you don't like it,
> >> you can use "fstrim <device>" (for example from crontab).
> >
> > I'd like the documentation more detailed.
> > Does it really run on all mounts or only /etc/fstab?
> > Does it write on automounted devices which are probably not owned
> > by the admin? Does it affect read-only mounts?
>
> The documentation is precise here:
>
> 'Trim all mounted filesystems on devices that support the discard
> operation.'

If this is 100% true then Karel's statement 10 lines above would be 
wrong.
Also this doc line indicates that even read-only mounts could be trimmed 
(if FS supports it) which would be at least dangerous if it runs 
automatically while admin is trying to repair a broken filesystem.

> It says exactly what it will do. Every one of your questions is
> answered.

> > IMO the task itself is already installed since we have fstrim's
> > option -a". You just need to _enable_ it to run whenever you want
> > for example by using crontab. That's trivial.
>
> Because it takes time. I have done it four times already and it cost
> me several minutes each time. Now nobody has to do it again.

> > Nobody would have thought about adding a 1-liner cronjob file to
> > util-linux eventhough any distro has /etc/cron.daily/. But now
> > systemd timer? Thats what I don't understand.
>
> I don't know why nobody thought about doing that in the past, maybe
> nobody cared about the needs of all those other admins. Maybe because
> installing a file into cron.daily automatically enables it. Maybe
> because nobody cared about anything but his own system?

I guess because adding one crontab line is trivial in comparision to add 
two files plus symlinks to get such systemd timer running. 

> > If _creating_ a systemd timer is too complicated for today's admins
>
> It is not complicated, it is just a task that shouldn't be repeated
> countless times.

Now you still need to enable it "countless times" which I would do using 
rsync or git anyway like I would sync self created timers, crontabs or 
whatever config files with same effort.

cu,
Rudi

