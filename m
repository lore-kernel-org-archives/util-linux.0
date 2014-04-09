Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Thomas =?utf-8?q?B=C3=A4chler?= <thomas@archlinux.org>
Subject: Re: [PATCH] fstrim: add systemd units
Date: Wed, 9 Apr 2014 17:44:48 +0200
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org> <201404091716.05131.sweet_f_a@gmx.de> <5345663A.1050403@archlinux.org>
In-Reply-To: <5345663A.1050403@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201404091744.48597.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 09 April 2014, Thomas B=C3=A4chler wrote:
> Am 09.04.2014 17:16, schrieb Ruediger Meier:
> > On Wednesday 09 April 2014, Thomas B=C3=A4chler wrote:
> >> Am 09.04.2014 14:12, schrieb Ruediger Meier:
> >>>> well, "fstrim -a" contains heruistic to select the right
> >>>> filestems (it really does not call trim for all devices), it has
> >>>> been implemented to *avoid* sysadmins creativity. If you don't
> >>>> like it, you can use "fstrim <device>" (for example from
> >>>> crontab).
> >>>
> >>> I'd like the documentation more detailed.
> >>> Does it really run on all mounts or only /etc/fstab?
> >>> Does it write on automounted devices which are probably not owned
> >>> by the admin? Does it affect read-only mounts?
> >>
> >> The documentation is precise here:
> >>
> >> 'Trim all mounted filesystems on devices that support the discard
> >> operation.'
> >
> > If this is 100% true then Karel's statement 10 lines above would be
> > wrong.
>
> There is no contradiction between this and what Karel said. I think
> you are confused and should read both statements again.

Yes I am confused now and read again.
Karel wrote "fstrim -a contains heruistic to select the right
filestems" which is something completely different than doing it=20
wherever it's possible.

> > Also this doc line indicates that even read-only mounts could be
> > trimmed (if FS supports it) which would be at least dangerous if it
> > runs automatically while admin is trying to repair a broken
> > filesystem.
>
> The documentation says nothing about excluding read-only file
> systems, that should probably be changed (but it is not something
> that I, personally, am terribly concerned about).
>
> >> It is not complicated, it is just a task that shouldn't be
> >> repeated countless times.
> >
> > Now you still need to enable it "countless times" which I would do
> > using rsync or git anyway like I would sync self created timers,
> > crontabs or whatever config files with same effort.
>
> This is getting annoying. It is your opinion that we should not add
> useful things because we haven't done so in the past, or because
> someone might want to do it slightly differently.
>
> I submitted it, Karel added it, period. There's no point continuing
> this argument.
