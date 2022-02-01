Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0C9C433F5
	for <util-linux@archiver.kernel.org>; Tue,  1 Feb 2022 20:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiBAUMW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237677AbiBAUMW (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 Feb 2022 15:12:22 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D2CC061714
        for <util-linux@vger.kernel.org>; Tue,  1 Feb 2022 12:12:21 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c3so16336234pls.5
        for <util-linux@vger.kernel.org>; Tue, 01 Feb 2022 12:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=n4nd8lQeZdLU1T1yf0YuOQfRfVVYKJloRIcU5zoIYPQ=;
        b=avW/twL+0UVQNShabHmtM2HU8v/D591ZXSwLD8RDaNb1xXHv8u71/owMv7PdfRqDnl
         hOnu310RkFAZd6i9gXyi3S9XaKrqDaPdbqDZj0ZWN9SEh3MLbvbp9rhDe8OsYUUTH/Ga
         ojErM9J0HDBnWGQgcy0h4VfedPVa2Mpk2Uh9YF0/QQzKgy5K8tjSHK/1G1d1lijoOXPt
         jpVIZoynB8+f2Rh3ljF5Q++1HZH0zUDR2sseyrUF31noDdgLpfj+B54a153lBhYVYdtM
         kRPFioa1XnmrNmrhJyxg85TEXZcE01mgWejr639qC+ETNA9Q28a7M706YhJJFzUrWYFQ
         RuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=n4nd8lQeZdLU1T1yf0YuOQfRfVVYKJloRIcU5zoIYPQ=;
        b=RlEbYl7iIDdBW/YmdhKMhK3D2D9Nb2udKMyRI29x+oMf3IP9NTVas3y7QeGgiq89ax
         4uzREJd2YoiiiCkS69M+bldNruGQWUD6dMyZXaZWFhSuBX+aaZS40xJUrXv8CUxA1LTl
         nmft38mGs/pHHa7qo8FdAgD8twHk69/3HG+HelqyMfva9CezvZXoKfYC+zdws7s9ShAq
         3BGqRaD6WjZxGHdjjPCA0TB7CG0Izv3HnDhXvsVVAEzCTCAvDx1a+9qAcQce3O56LOb8
         qC0rOz2I0Oc2Js58Rpn+SUHLP4WrtPMANPeK6nE9FUlwo+Ty+gORDqY+pPe8l2nrnPaY
         uzcw==
X-Gm-Message-State: AOAM531b/px64c59+Yf5VKJEKYzEPn1697S1RcGxuWMUod3JLbPycMkW
        mA+JF/OUGaQTRNOecbWd4YNc778rLCwfrSIMvLrmY2AS
X-Google-Smtp-Source: ABdhPJyTf0mSxLC5cUiutA+HBs/vtflc+WTZ6ZFLG78+/HqlqO8G4i1HwU7CiPq9Z92c2M58Y9nb1JIwsDrBroGmPIw=
X-Received: by 2002:a17:903:230f:: with SMTP id d15mr28405108plh.8.1643746341210;
 Tue, 01 Feb 2022 12:12:21 -0800 (PST)
MIME-Version: 1.0
References: <CAHi0vA9rJS=+KT2PxTQ9bBeutt9KqpmgvmhJq3VASrKke_h+NQ@mail.gmail.com>
 <20220131093510.onug66aufuadj2ed@ws.net.home> <CAHi0vA-8RYm88aYbLAuTcwBLYuH+GsVWP2WEqucFQXCsg2CKpg@mail.gmail.com>
 <20220201125806.7shbxjw4mcyhmlhw@ws.net.home>
In-Reply-To: <20220201125806.7shbxjw4mcyhmlhw@ws.net.home>
From:   =?UTF-8?Q?Mario_Bl=C3=A4ttermann?= <mario.blaettermann@gmail.com>
Date:   Tue, 1 Feb 2022 21:12:09 +0100
Message-ID: <CAHi0vA96-FOmhguiaFh+uCapaTSsYYYjkqGa_SMCQ23NAKeUJw@mail.gmail.com>
Subject: Re: Unify the --help and --version descriptions in man pages?
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Karel,

Am Di., 1. Feb. 2022 um 13:58 Uhr schrieb Karel Zak <kzak@redhat.com>:
>
> On Mon, Jan 31, 2022 at 09:17:22PM +0100, Mario Bl=C3=A4ttermann wrote:
> > Hello Karel,
> >
> > Am Mo., 31. Jan. 2022 um 10:35 Uhr schrieb Karel Zak <kzak@redhat.com>:
> > >
> > > On Sat, Jan 29, 2022 at 12:57:12PM +0100, Mario Bl=C3=A4ttermann wrot=
e:
> > > > I've just noticed the commit =C2=BBdocs: add man-common/in-bytes.ad=
oc=C2=AB.
> > > > What about to unify the descriptions of the --help and the --versio=
n
> > > > options in the man pages in a similar manner? Besides to simplify t=
he
> > > > ma=C3=ADntenance, it would also shrink the .po file of the man page=
s a bit.
> > >
> > > Arbitrary unification and consolidation is wanted, go ahead ;-)
> > >
> > > > --- blockdev.8.adoc     2021-11-26 17:40:06.931013901 +0100
> > > > +++ blockdev.8.adoc    2022-01-29 12:47:43.087144014 +0100
> > > > @@ -40,10 +40,10 @@
> > > > Print a report for the specified device. It is possible to give mul=
tiple device
> > > > s. If none is given, all devices which appear in _/proc/partitions_=
 are shown. N
> > > > ote that the partition StartSec is in 512-byte sectors.
> > > >
> > > > *-h*, *--help*::
> > > > -Display help text and exit.
> > > > +include::man-common/help-description.adoc[]
> > > >
> > > > *-V*, *--version*::
> > > > -Print version and exit.
> > > > +include::man-common/version-description.adoc[]
> > >
> > > Do we need to separate help & version? Maybe we can use
> > >
> > >   include::man-common/help-and-version.adoc[]
> > >
> > > where will be everything.
> > >
> > >       *-h*, *--help*
> > >               Display help text and exit.
> > >
> > >       *-V*, *--version*
> > >               Display version information and exit.
> > >
> > > We use the same in usage() function (--help output) where both
> > > items are printed together by USAGE_HELP_OPTIONS macro. (see 'git gre=
p
> > > USAGE_HELP_OPTIONS')
> > >
> > > IMHO --help and --version is so generic that we do not need to keep i=
t
> > > sorted in man pages. I guess it's OK to keep it at the end of the lis=
t
> > > of options like we use in usage().
> >
> >
> > OK, this is possible for --help without any other changes; all our
> > tools have the same options (*-h*, *--help*). But for --version, the
> > single-letter option differs. While most of the tools have *-V*,
> > *--version*, it is *-v*, *--version* for the following ones:
> >
> > sfdisk.8.adoc
> > chsh.1.adoc
> > chfn.1.adoc
> >
> > For sfdisk, -V has a different meaning, and for chsh and chfn the
> > option -V is unknown (invalid). So we could change chsh and chfn to
> > accept -V (and maybe drop -v in turn), and we leave the --help and
> > --version part of sfdisk.8.adoc untouched.
>
> For chsh and chfn it's probably good idea to support also -V, but for
> backward compatibility it would be nice to keep -v in code (not
> necessary in man page).
>
> And yes, sfdisk.8.adoc keep untouched.
>

See my pull request. Just stumbled upon some other peculiarities:

"fsck" doesn't know -h; the single-letter help option is "-?".

"kill" doesn't accept neither, -h, -V, nor --version; only --help is accept=
ed.

The behavior of "tunelp" is unknown, because it is not available from
my system. The current man page doesn't contain neither of the -h and
-V options.


In the current state with "--help" and "--version" concatenated into
one, it is only possible to add some extra info to --version, if
needed (see the hardlink man page, for example). If a man page author
needs to add something to --help, he needs to get back to the old
behavior. But I don't expect that somebody insists on adding important
extra information to the --help option.


Best Regards,
Mario
