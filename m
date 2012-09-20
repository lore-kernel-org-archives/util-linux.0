Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35255 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753923Ab2ITJrO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 20 Sep 2012 05:47:14 -0400
Date: Thu, 20 Sep 2012 11:47:04 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>,
        Werner Fink <werner@suse.de>, Ludwig Nussel <ludwig.nussel@suse.de>
Cc: Thomas =?iso-8859-1?Q?B=E4chler?= <thomas@archlinux.org>,
        util-linux@vger.kernel.org, Dave Reisner <d@falconindy.com>,
        Tobias Powalowski <tpowa@archlinux.org>
Subject: Re: [su] New su utility messes with my PATH
Message-ID: <20120920094330.GC16499@x2.net.home>
References: <50547FE7.204@archlinux.org>
 <50549411.9000302@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <50549411.9000302@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Sep 15, 2012 at 03:43:29PM +0100, Pádraig Brady wrote:
> On 09/15/2012 02:17 PM, Thomas Bächler wrote:
> >I found what I think is absolutely unexpected behaviour in the new su
> >utility. It seems to have been introduced by commit a6fdd3f8.
> >
> >It is about /sbin and /usr/sbin being in the path: Whenever you switch
> >to a non-root user, they are removed from the path, and when you switch
> >to root, they are added. I find it completely unexpected that su (when
> >not running with -l) messes with my environment at all.
> >
> >Commands like
> >  PATH=... su -c "cmd" user
> >do not work as expected.
> >
> >In my opinion, when you wish your path (or anything in the environment)
> >to change you should a) use -l to start a login shell or b) configure
> >your scripts to take care of it.
> >
> >I propose to revert the mentioned patch. Opinions?
> 
> Ouch, I agree.
> su shouldn't be messing with PATH at all IMHO.

It's Suse patch, I guess there is/was any reason for the patch

        commit a6fdd3f8125be23930d955c2bc6b7a46cdaf8a12
        Author: Werner Fink <werner@suse.de>
        Date:   Tue Aug 17 09:09:55 2010 +0200

        make sure /sbin resp /usr/sbin are in PATH


Werner, Ludwig? What about to revert the patch?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
