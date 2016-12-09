Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932299AbcLIMjW (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 9 Dec 2016 07:39:22 -0500
Date: Fri, 9 Dec 2016 13:39:20 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 0/2] docs: renice(1) patches
Message-ID: <20161209123920.tknhbe4ac67zfx7u@ws.net.home>
References: <a107f552-049d-0600-3893-fdb2a5c11f29@gmail.com>
 <201612071552.38043.sweet_f_a@gmx.de>
 <20161209123647.mhbzm57f5phjtg3k@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161209123647.mhbzm57f5phjtg3k@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 09, 2016 at 01:36:47PM +0100, Karel Zak wrote:
> On Wed, Dec 07, 2016 at 03:52:37PM +0100, Ruediger Meier wrote:
> > On Wednesday 07 December 2016, Michael Kerrisk (man-pages) wrote:
> > > Karel,
> > >
> > > The two following patches contain nontrivial content
> > > changes to the renice(1) page. They depend on changes
> > > sent in my just-sent git pull request that includes
> > > trivial changes to the renice(1) page.
> > 
> > 
> > For example like this:
> > 
> > $ rm -rf /tmp/patches
> > $ git format-patch --cover-letter o /tmp/patches  master..HEAD
> > $ git send-email --to=util-linux@vger.kernel.org /tmp/patches/*
> 
>  +1
> 
>  I have problem to apply the patches, for example:

 because I'm <censored> ... I forgot your "[pull request] trivial
 fixes", sorry. Ignore the previous email.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
