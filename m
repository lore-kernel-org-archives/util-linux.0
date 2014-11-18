Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56254 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754312AbaKRNny (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Nov 2014 08:43:54 -0500
Date: Tue, 18 Nov 2014 14:43:50 +0100
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Alexander Samilovskih <alexsamilovskih@gmail.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: Problem with gettimeofday
Message-ID: <20141118134350.GO6704@x2.net.home>
References: <CALkMTNnMEujZy7H2tv+iUApHK+10b3Q3aNu4E+cxy=U-uE37ew@mail.gmail.com>
 <CALkMTNnLBf3q4PBVUCOdgzJiK6G4h4-+28hSPzSGyvx+3xLnGQ@mail.gmail.com>
 <CAG27Bk2mYN7BoMcMfJEm=1KLat1zERNnvd2zV01deik-PBk_Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk2mYN7BoMcMfJEm=1KLat1zERNnvd2zV01deik-PBk_Hw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 02, 2014 at 09:26:02AM +0100, Sami Kerola wrote:
> On 2 May 2014 03:52, Alexander Samilovskih <alexsamilovskih@gmail.com> wrote:
> > There are several places where gettimeofday should be replaced by
> > clock_gettime(CLOCK_MONOTONIC_RAW). According to manual pages
> > gettimeofday affected by discontinues jumps made by system
> > administrator, can be slewed by ntpd or kinda stuff. So when we
> > subtract two different timestamps from gettimeofday we can get
> > confusing results
> >
> > sys-utils/eject.c
> > libmount/lock.c
> > maybe some other places...
> 
> Hi Alexander,
> 
> The diff you sent does not seem to work.
> 
> fatal: corrupt patch at line 123
> 
> The format you get from
> 
> $ git format-patch HEAD~1
> 
> would be appreciated.

 It seems Alexander does not care anymore, so I have fixed and applied 
 the patch.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
