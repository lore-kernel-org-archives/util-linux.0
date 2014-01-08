Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f47.google.com ([209.85.160.47]:43971 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757612AbaAHUhb convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 8 Jan 2014 15:37:31 -0500
Received: by mail-pb0-f47.google.com with SMTP id um1so2036722pbc.6
        for <util-linux@vger.kernel.org>; Wed, 08 Jan 2014 12:37:31 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20140108092116.GA7516@x2.net.home>
References: <1389051548-1268-1-git-send-email-kerolasa@iki.fi>
	<52CBCF17.50706@archlinux.org>
	<20140107101935.GA2658@x2.net.home>
	<201401071344.09876.vapier@gentoo.org>
	<20140108092116.GA7516@x2.net.home>
Date: Wed, 8 Jan 2014 20:37:30 +0000
Message-ID: <CAG27Bk2S5ert+sjnai8ybEhhoUruYmX6P+U7c1AaghfjQ_s2TA@mail.gmail.com>
Subject: Re: [PATCH] uuidd: use pkg-config to find systemd-deamon support
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Mike Frysinger <vapier@gentoo.org>,
        =?ISO-8859-1?Q?Thomas_B=E4chler?= <thomas@archlinux.org>,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 8 January 2014 09:21, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Jan 07, 2014 at 01:44:07PM -0500, Mike Frysinger wrote:
>> On Tuesday 07 January 2014 05:19:35 Karel Zak wrote:
>> > On Tue, Jan 07, 2014 at 10:55:35AM +0100, Thomas Bächler wrote:
>> > > >> We already have such a cyclic dependency, since udevd depends on
>> > > >> libblkid+libuuid, and findmnt (from util-linux) depends on libudev.
>> > > >>
>> > > >  .. and nobody complains, good point :-) Thanks!
>> > > >
>> > > >     Karel
>> > >
>> > > Actually, now that I know you care about these things, I am complaining.
>> > >
>> >  :-)))
>> >  :
>> > > It has caused me (minor) trouble once already.
>> >
>> >  It's possible (first time) to compile util-linux without libudev,
>> >  compile systemd/udevd and then again recompile util-linux with
>> >  libudev.
>> >
>> >  IMHO libudev is very useful for findmnt and lsblk to get info about
>> >  devices.
>> >
>> >  Note that uuidd is absolutely unnecessary if you don't have huge SAP
>> >  installation (-- it means unnecessary for 99% of the all Linux users).
>>
>> on a semi-related matter, it'd be nice if we could easily build util-linux
>> such that we only get the libraries.  the plethora of configure flags that
>> control utils is a nightmare to manage, and i'm not sure there's a flag for
>> every utility (i haven't checked myself, so i could easily be wrong).
>
> not yet ;-)
>
>> if that were in play, the circular loop would be easy to address -- build
>> util-linux once just for its libs, then udev/systemd, then util-linux again.
>
> Yep, I know about the pain... I guess it would be enough to have
> something like
>
>  ./configure --disable-all-builds --enable-libblkid
>
> where --enable/disable-all-builds controls the default of the
> enable_<name>= variables (the current default is usually "check")
> in configure.
>
> I'll try to implement it later (I'm working on new cfdisk now) -- or
> maybe some volunteer...? :-)

I could try to fiddle around with autotools in next days/weeks.

The one thing I am thinking to change immediately is
's/--disable-all-builds/--enable-minimal/'.  Unfortunately, due I'm just
a random contributor without distribution packaging experience at all I
will need few hints from real pros.  Most important question being what
the minimal should include?  I did think that option could be
--enable-libaries-only, but is that too minimal to be practical?

p.s.  Karel, the consider the cal(1) enhancements being temporarily
postponed.  Well, they weren't import anyway, so IMHO not a big loss.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
