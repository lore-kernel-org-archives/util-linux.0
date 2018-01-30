Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:21984 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751674AbeA3NjI (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 30 Jan 2018 08:39:08 -0500
Date: Tue, 30 Jan 2018 14:38:46 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: J William Piggott <elseifthen@gmx.com>, util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] cal: remove year top header
Message-ID: <20180130133846.elgq3n55anu555zf@ws.net.home>
References: <7bdff2d4-ad0d-699e-d451-be087f637074@gmx.com>
 <425f0c7b-5f76-675a-95b4-f4aeee1b25a9@gmx.com>
 <20180130110804.dxg3lk2qdqetpink@ws.net.home>
 <201801301321.36966.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201801301321.36966.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 30, 2018 at 01:21:36PM +0100, Ruediger Meier wrote:
> On Tuesday 30 January 2018, Karel Zak wrote:
> > On Wed, Jan 24, 2018 at 07:53:11PM -0500, J William Piggott wrote:
> > >  misc-utils/cal.c | 32 +++-----------------------------
> > >  1 file changed, 3 insertions(+), 29 deletions(-)
> >
> > Do I understand correctly that "cal -y" will not display year on the
> > top and year will be always behind all month names?
> >
> > If yes, I'm not sure if I like it. I understand that "Month Year" is
> > a good thing for complicated outputs (especially cross year borders),
> > but if I ask for all year (by -y)?
> 
> 
> I'd also like to see the year only once per year. FreeBSD's cal does it 
> very nice IMO.
> 
> Unfortunately we have this bloated output already now in 
> 
> $ cal -n 36

Not perfect, but makes some sense, and it's used for this new feature
from the beginning.

The "cal -y" is pretty old and I don't think we need a change here.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
