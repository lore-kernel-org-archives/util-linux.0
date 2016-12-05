Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750951AbcLEMHI (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 5 Dec 2016 07:07:08 -0500
Date: Mon, 5 Dec 2016 13:06:31 +0100
From: Karel Zak <kzak@redhat.com>
To: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Pull request: nsenter(1) fixes
Message-ID: <20161205120631.qgyuymptnoacnppr@ws.net.home>
References: <CAKgNAkjtq0kh7X5umw26FQhh_cork1yb_C-gNL4jHZNr7Fz2qA@mail.gmail.com>
 <20161205115129.hvxasynsgszi33tu@ws.net.home>
 <CAKgNAkgLVYfiroRtGbP48uFps8=EGtAhdt5iLsmVdX0zsRAJMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKgNAkgLVYfiroRtGbP48uFps8=EGtAhdt5iLsmVdX0zsRAJMw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 05, 2016 at 12:56:36PM +0100, Michael Kerrisk (man-pages) wrote:
> Hello Karel,
> 
> On 5 December 2016 at 12:51, Karel Zak <kzak@redhat.com> wrote:
> > On Mon, Dec 05, 2016 at 11:25:45AM +0100, Michael Kerrisk (man-pages) wrote:
> >> I have various fixes to send, but I'll start small, with a couple of
> >> fixes for nsenter(1).
> >
> >  Applied ... but you have removed "See also.. " sentence from
> >  description of the --user. Would be better to keep there?
> 
> My apologies. That was a blunder. I can send you a patch, or do you
> want to revert that deletion manually. Let me know which you prefer.

Fixed, I did the change manually.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
