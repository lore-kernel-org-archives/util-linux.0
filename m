Return-Path: mail@bernhard-voelker.de
Date: Mon, 10 Dec 2012 09:58:34 +0100 (CET)
From: Bernhard Voelker <mail@bernhard-voelker.de>
Reply-To: Bernhard Voelker <mail@bernhard-voelker.de>
To: Karel Zak <kzak@redhat.com>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Message-ID: <1203571747.166876.1355129914909.JavaMail.open-xchange@email.1und1.de>
In-Reply-To: <20121210084250.GA21405@x2.net.home>
References: <50C4CFDD.1070405@bernhard-voelker.de> <20121210084250.GA21405@x2.net.home>
Subject: Re: blkid: exit code as non-root user, and segfault
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>


On December 10, 2012 at 9:42 AM Karel Zak <kzak@redhat.com> wrote:
> On Sun, Dec 09, 2012 at 06:52:29PM +0100, Bernhard Voelker wrote:
> > blkid returns 0 without output when running as non-root user
> > and when the cache /dev/.blkid.tab is not yet there:
> >
> >   ./blkid /dev/sdb3 ; echo $?
> >   0
>
> ./blkid /dev/sdb3; echo $?2
> 2

Typo? "$?2" should lead to "02".

It really exits 0 here, when run as non-root user and when
/dev/.blkid.tab doesn't exist yet.

> > And another issue: blkid segfaults with this - okay, bad use of options:
> >
> >   ./blkid -n /dev/sdb3
> >   Segmentation fault
>
>  Fixed by:
...
> > Using latest git; it doesn't dump core with 2.20.1.
>
>  Really latest? ;-)

Yes, now (forgot make after pull, sorry) ;-)

Ok, that means the segfault is fixed, but the above
issue is still there.

Have a nice day,
Berny
