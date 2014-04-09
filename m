Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] fstrim: add systemd units
Date: Wed, 9 Apr 2014 12:07:56 +0200
Cc: Thomas =?iso-8859-1?q?B=E4chler?= <thomas@archlinux.org>,
        util-linux@vger.kernel.org
References: <1396561311-12825-1-git-send-email-thomas@archlinux.org> <201404081407.29362.sweet_f_a@gmx.de> <20140409075215.GP22126@x2.net.home>
In-Reply-To: <20140409075215.GP22126@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201404091207.56691.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 09 April 2014, Karel Zak wrote:
> On Tue, Apr 08, 2014 at 02:07:28PM +0200, Ruediger Meier wrote:
> > I don't say something against systemd here and I don't see this
> > black and white only. I'am just against adding sysadmin scripts
> > which actually do only trivial things.
>
> Well, it's not so important if the file is trivial or non-trivial --
> the overhead for distributions is usually almost the same. It's
> always cheaper to maintain distribution independent stuff on one
> shared place.

I understand, but isn't the usefulness of a daily job "fstrim -a" 
debatable at all? Should this be discussed by core util-linux 
developers or not better by sysadmins and distribution developers?
Actually I think daily "fstrim -a" IS not a good idea for most of my 
systems but I feel no need to discuss this here on util-linux because 
the decision whether, how, when and on which devices fstrim should be 
called should not be made here at all.

And I find my other examples in this thread not so stupid.
If we add scripts with one generic use case for fstrim. Why don't we add 
the generic boot and maintenance scripts how and when to mount or fsck 
all filesystems, to activate swap, to get and set hwclock or whatever?

Moreover the portability issue. Why adding scripts for systemd only 
allthough the same could be done without systemd in a more portable 
way.

cu,
Rudi
