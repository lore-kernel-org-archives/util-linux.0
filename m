Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33613 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJBO7A (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 2 Oct 2018 10:59:00 -0400
Date: Tue, 2 Oct 2018 10:16:54 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jaroslav =?utf-8?B?xaBrYXJ2YWRh?= <jskarvad@redhat.com>,
        mpluskal@suse.com, base-system@gentoo.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Bombe <andreas.bombe@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: Future of dosfstools project (FAT)
Message-ID: <20181002081654.jxesr3kj62snzez5@pali>
References: <20180929084038.an6pfhnsd6tblejl@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAFLxGvxfegQFh0kvk81VLhLh0AkgvpT=hWMDCJz5FmgoTUNRqA@mail.gmail.com>
 <20180929084038.an6pfhnsd6tblejl@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 01 October 2018 22:13:41 Richard Weinberger wrote:
> On Mon, Oct 1, 2018 at 10:01 PM Andreas Dilger <adilger@dilger.ca> wrote:
> > If the current dosfstools maintainer is non-responsive, you could always
> > fork the project in GitHub, land the critical patches into your branch,
> >  and make a release on your own.  If the maintainer surfaces again, then
> > they can pull in your patches.  If not, then you are the new maintainer.
>-
> I also recommend talking to package maintainers of major distros.
> Maybe one of them forked the project already and did what you plan to do.
>-
> In any case, let's try to avoid a drama like util-linux-ng was.

Based on Richard's comment, I'm forwarding my original email (below) to
the Fedora, Suse and Gentoo maintainers.

On Saturday 29 September 2018 10:40:38 Pali Rohár wrote:
> Hi!
> 
> Last year I did some research how Windows and Linux tools handle FAT
> labels (boot sector vs root directory) and proposed some unification.
> More in thread: https://www.spinics.net/lists/kernel/msg2640891.html
> 
> My proposed change for manipulating with FAT labels is now implemented
> in util-linux v2.33, prepared new mtools version, and also in dosfstools
> git (unreleased) https://www.spinics.net/lists/kernel/msg2645732.html
> 
> Project dosfstools contains de-facto standard Linux userspace tools for
> FAT filesystems (mkfs.fat, fsck.fat, fatlabel) and so it is quite
> important because of high usage of FAT.
> 
> But there was no new release of dosfstools since Jan 2017 and for more
> then month I'm unsuccessfully try to contact maintainer of dosfstools
> project (Andreas) about future of project itself.
> 
> I do not know what happened, if either Andreas do not have time or
> something else...
> 
> So does somebody know what is state of dosfstools project?
> 
> Also there are lot of proposed changes (with patches) for this project
> https://github.com/dosfstools/dosfstools/pulls and also more reported
> bugs https://github.com/dosfstools/dosfstools/issues
> 
> If Andreas does not have time, can somebody else at least look at pull
> requests and do some code review?
> 
> I have some other unpublished/unfinished changes for dosfstools, but I
> do not know now if it make sense to invest more time in this project
> when maintainer does not respond... if this project is active or going
> to be dead...
> 
> If dosfstools is going to be inactive/dead, there is still mtools
> project with provides FAT tools too and maintainer of it is now
> preparing new bugfix version. So at least some alternative exists.

-- 
Pali Rohár
pali.rohar@gmail.com
