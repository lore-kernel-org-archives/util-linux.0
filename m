Return-Path: <SRS0=1kTP=O2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0054AC43387
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 22:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C390E20874
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 22:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbeLQWNj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:13:39 -0500
Received: from mout.gmx.net ([212.227.15.15]:38361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbeLQWNj (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Dec 2018 17:13:39 -0500
Received: from adsiz.fritz.box ([95.90.44.148]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M0gww-1hPSH81rSw-00uuUN; Mon, 17
 Dec 2018 23:13:36 +0100
From:   Ruediger Meier <sweet_f_a@gmx.de>
To:     Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] fstrim: add random delay to systemd timer
Date:   Mon, 17 Dec 2018 23:13:35 +0100
User-Agent: KMail/1.9.10
Cc:     util-linux@vger.kernel.org
References: <20181217124422.13334-1-mail@eworm.de> <201812172145.23296.sweet_f_a@gmx.de> <20181217221518.5a68691f@leda>
In-Reply-To: <20181217221518.5a68691f@leda>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201812172313.35898.sweet_f_a@gmx.de>
X-Provags-ID: V03:K1:hZELPMT1btM+zRJ5Xw510mDy9s99vsjsVt390zWaXUCJuSnyfht
 3Ja/mu6SAdj5Oh/XVpo7pIKX49EQ5jBAZ8zJeFg6o+l68YRuHOYp1LCPrOPYf/LpaN72TKZ
 +Tzkdv3cl/ypxpOf6LPUqK1AYzFzPt2KhvCFdkS7yWc1rTFGBG9MXucjF3pJSMGycop21lz
 fOO5Exp+dtEQfbr0ka4oQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5atJxqJlfQc=:D9FHfov/7YLx90P5fQFPXX
 svu5g5pOS79qFCUP8n/aEvPheSQ7aT4CI8PkYtM7m5HMQ4bZ3laJBTYsdS7SoN+2woWdVeIdA
 7W/r08kNrQnj3SiZFSMp57sSW4c0h50er0ZSkc9Ahk8+cbOTDQTgB91mMg58doSuedGEcY8jK
 yNcrzT/fwKhip9NX+HSnWB3TpW3jzd4bgZdsmQ4N5PQ57wpUDXHqfX2O/mXsK6cpiG1P0ld0e
 Zed7ul9EcTTVd4rFyGSqfgABzrdBGnS77AMgZQW7k0hprN5pLEy+iVwLBDX3vwZ487tMKmeyv
 Bth35mTZzufEwfT4lhELWLr8Mw8sf2SdSNlIDlFq6/LjWCEIITv/6CADqk+rzS0Ue3GxUoOiT
 7/gnM7JSnG/PloYdo+OREl1lIe0B8URpBgn/REOu/6UZ4Lqmj+pThUoPCZyf7JYgjLEu2G3R+
 0UaJwIUP5VJdp5wfH/7yERbcvi283aSIBCJH1CiTa021dEheB/yOtl4Z7YE+IpZQvKDmLWRSy
 ZQmxln8hYIF8zudiXByglIFuXs7iOzYvoJzYSmUp6vM9Nj2oo3sqE29jSgYWFnh3W6kFG/33j
 DjHhwb7gF1qq2PAXCI1uzJX24hTtroHUYx0NuZSxaKqYNovMMw2v8iHTARAX4qXMFPFjF+yeg
 csES7O+gRq1t0yHoifqq6Lct5HF+mvKlXvSNd861joFK5fC1S9M6U5xxi89le6grFz0nVXd3J
 +RmAa3GRwUAzuB/32oYo1tTStGyO1cmJOi68OXrMtaybIYGKVXaa3frdoPb2goDbSYfvqavqd
 /0B2LuQvkPDG1HfQbA9gj0eEb9/1e7Bm27taK7pGTdl/6knDYobpYhTYbhKoWdmpbGUk73eEE
 nKGDBO/csUFaa9ypcgwJxim6K3OOErD46DyyybFDQ=
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Monday 17 December 2018, Christian Hesse wrote:
> Ruediger Meier <sweet_f_a@gmx.de> on Mon, 2018/12/17 21:45:
> > On Monday 17 December 2018, Christian Hesse wrote:
> > > The fstrim timer tends to fire simultaneously with other timers
> > > like updatedb. As fstrim is not time criticaly let's add a random
> > > delay of up to an hour.
> > >
> > > Signed-off-by: Christian Hesse <mail@eworm.de>
> > > ---
> > >  sys-utils/fstrim.timer | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/sys-utils/fstrim.timer b/sys-utils/fstrim.timer
> > > index 3a3762d5c..dd3328e2a 100644
> > > --- a/sys-utils/fstrim.timer
> > > +++ b/sys-utils/fstrim.timer
> > > @@ -5,6 +5,7 @@ Documentation=man:fstrim
> > >  [Timer]
> > >  OnCalendar=weekly
> > >  AccuracySec=1h
> > > +RandomizedDelaySec=1h
> >
> > Looks like it could still run simultaneously with other timers at
> > random times. So this does not seem to be a real fix for the
> > problem described in your commit message.
> >
> > You may look at /etc/cron.{hourly,daily,weekly,monthly} if you want
> > to run such jobs one after the other.
>
> There's no harm when jobs run simultaneously, other than bad user
> experience: Consider a user stating his notebook, workstation,
> whatever on a Monday morning and system feels bad under high load.
> This can be avoided (most of the time) with just a single line in the
> timer. I think it is worth it.

Hm, on my file server updatedb needs about 30 minutes. A random delay of 
1 hour means that both jobs will still run simultaneously in 50% of the 
cases.

> Anyway... Feel free to deny committing the patch. For now I added a
> configuration snipped on my system.

Nevermind, I just wanted to rant again about why we are maintaining this 
timer files at all. IMO the distros and/or admins should configure such 
tasks *properly* according their needs. UL upstream is IMHO the wrong 
place.

BTW note that RandomizedDelaySec will produce an annoying warning on 
sytstems where systemd is not up-to date. And to rant again, IMO it's 
questionable whether we should bother users with such warnings or why 
one should update the whole systemd monstrum just to achieve such 
simple improvement which was solved already by cron 30 years ago in a 
better way ;)

cu,
Rudi
