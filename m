Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:1035 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544Ab1GYJqq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 25 Jul 2011 05:46:46 -0400
Date: Mon, 25 Jul 2011 11:46:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Daniel Drake <dsd@laptop.org>
Cc: "Ted Ts'o" <tytso@mit.edu>, util-linux@vger.kernel.org
Subject: Re: Can't remount loopback ext4 without /etc/mtab
Message-ID: <20110725094638.GV22568@nb.net.home>
References: <CAGq3pz7FctJcUsO-1FmFmV=EW0N=n_ZYBCHGcyXQMr1CJ24zRA@mail.gmail.com> <20110724195713.GH3469@thunk.org> <20110725090624.GU22568@nb.net.home> <CAGq3pz4PH-MK5+AgBTnq03atWUxMEdVreUtoVeqrkOkcc+8DZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAGq3pz4PH-MK5+AgBTnq03atWUxMEdVreUtoVeqrkOkcc+8DZQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 25, 2011 at 10:20:55AM +0100, Daniel Drake wrote:
> On 25 July 2011 10:06, Karel Zak <kzak@redhat.com> wrote:
> >  mount(8) "bug"
> >
> >  The kernel does not accept any SELinux specific mount options for
> >  MS_REMOUNT. We already have exception for this in mount(8) ... and I
> >  hate it, but our SELunux kernel guys are happy with this strange
> >  behavior:
> >
> >  https://bugzilla.redhat.com/show_bug.cgi?id=563267#c9
> 
> That view might have changed, I found these commits:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=ff36fe2c845cab2102e4826c1ffa0a6ebf487c65
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=026eb167ae77244458fa4b4b9fc171209c079ba7
> (from https://bugzilla.redhat.com/show_bug.cgi?id=676630 )

 WOW...

> I'm going to test them against F15 kernel later today.

 F-15 uses 2.6.38, the patches are in kernel >= v2.6.39-rc7
 (according to git describe --contains).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
