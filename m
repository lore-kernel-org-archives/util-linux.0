Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Thomas =?utf-8?q?B=C3=A4chler?= <thomas@archlinux.org>
Subject: Re: [PATCH] fstrim: add systemd units
Date: Tue, 8 Apr 2014 14:07:28 +0200
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org> <201404081225.21563.sweet_f_a@gmx.de> <5343D600.7000507@archlinux.org>
In-Reply-To: <5343D600.7000507@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201404081407.29362.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Tuesday 08 April 2014, Thomas B=C3=A4chler wrote:
> Am 08.04.2014 12:25, schrieb Ruediger Meier:
> > Hm, isn't this a bit over the top? Adding a script just to
> > call "fstrim -a" automatically?
>
> It's a common task. I was getting tired of having to add this on
> every single machine that I set up.

=46or me it's very common task to do "rm -rf /tmp" after each reboot. I=20
have to setup this on every single machine. Should I go to coreutils,=20
the developers of rm to add a script which calls "rm -rf /tmp" on=20
reboot?
No, of course my distribution should give me that feature.

> > Should we also add scripts for "mount -a" or "fsck -a" or "swapon
> > -a"?
>
> And what purpose would that serve? Did you just take random commands
> and add '-a' to prove a point?

I wanted to point out that util-linux is a project to provide us tools=20
and not all the ways how and when to use them. systemd ustream is=20
mounting and fsck'ing our filesystems automatically. So they can also=20
fstrim if they find it useful.

> > And wouldn't we also need to add "example crontab" lines for
> > non-systemd systems! Sounds a bit ridiculous, right?
>
> You can add them if you feel like it. But this is not an "example"
> file, it is ready to be used.

An example crontab line is also ready to use. Your example timer is=20
(hopefully) not automatically enabled just because it is installed.

> > I think it's the distro's or admin's job to write and add the
> > scripts for filesystems maintenance etc.
>
> That's ridiculous. We finally, for the first time ever, have a
> unified way of creating service definitions that can be used
> unchanged in all relevant distributions (except Gentoo and Slackware,
> of course).

Beside the fact that before "unique service definitions" were invented=20
nobody would have thought that one would need such thing just to call a=20
single commandline one time per day.

> The main advantage of this unification is that they can =20
> be shipped and maintained by upstream projects - after all, the
> upstream projects know what services make sense and how to start them
> properly.

I don't say something against systemd here and I don't see this black=20
and white only. I'am just against adding sysadmin scripts which=20
actually do only trivial things. Though it might be worth to add such=20
unit file if it does something more interesting, like we have already=20
uuidd.service and uuidd.socket (and uuidd.rc) which provides nices ways=20
how to start uuidd.

> > BTW fstrim.timer is missing in "make dist" tar ball.
>
> Sorry, you are right. I'm a bit lost in this build system, Karel
> probably knows how to fix this.

cu,
Rudi
