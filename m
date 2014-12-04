Return-Path: Martin@lichtvoll.de
From: Martin Steigerwald <Martin@lichtvoll.de>
To: Karel Zak <kzak@redhat.com>
Cc: Matthew Eaton <m.eaton82@gmail.com>, util-linux@vger.kernel.org
Subject: Re: fdisk units size
Date: Thu, 04 Dec 2014 15:14:42 +0100
Message-ID: <2572315.jG5ZmGVWTg@merkaba>
In-Reply-To: <20141204130044.GH1994@x2.net.home>
References: <CAF+0mvmE_i0P350hT4E4a-ZTTuuS5PdZ2vw1siQ2HowpB2Xn-g@mail.gmail.com> <20141204130044.GH1994@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <util-linux.vger.kernel.org>

Am Donnerstag, 4. Dezember 2014, 14:00:44 schrieb Karel Zak:
> On Tue, Nov 25, 2014 at 04:19:25PM -0800, Matthew Eaton wrote:
> > Hello, I have a quick question regarding recent fdisk.
> > 
> > I noticed fdisk -l now uses base 2 (GiB) instead of base 10 (GB) to
> > calculate device size.  This is good, but sometimes it is nice to see
> 
>  when sometimes?
> 
> > the base 10 calculation, can this be toggled with a switch?  I can't
> > find a recent man page for fdisk.
> 
>  Frankly, use 10 based calculation in IT is ugly thing, we are not
>  hard disk device marketing guys...

Say you want to divide a 500 GB disk in five equally sized partitions. Thats 
easier to do with base 10 calculation. 5 x 100 GB = approx. 500 GB. 5 x 100 
GiB is more.

But anyway, I use LVM these days for most stuff.

-- 
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
