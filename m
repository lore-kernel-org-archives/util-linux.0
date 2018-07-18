Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726666AbeGRMtn (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 18 Jul 2018 08:49:43 -0400
Date: Wed, 18 Jul 2018 14:12:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Igor Plyatov <plyatov@gmail.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        rtc-linux@googlegroups.com, util-linux@vger.kernel.org,
        J William Piggott <elseifthen@gmx.com>
Subject: Re: 500 ms delay in time saved into RTC
Message-ID: <20180718121201.62gux3eualwz2j3a@ws.net.home>
References: <30ae185f-28c9-54f1-2884-4ee7801b130e@gmail.com>
 <34f50661-85f5-eb46-3ff7-45f0c2bb5960@prevas.dk>
 <20180219110328.n7yjorinjm3xxckr@ws.net.home>
 <0ce68f3f-fec7-1f1c-e70b-331c0752f6d6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0ce68f3f-fec7-1f1c-e70b-331c0752f6d6@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 19, 2018 at 02:31:23PM +0300, Igor Plyatov wrote:
> Dear Karel,
> 
> 
> > Would be possible to somehow detect what is the right default setting for
> > --delay? I mean for example detect architecture / clock HW, etc.
> > 
> > I have no problem with --delay, but it's tuning for advanced users and
> > HW specific stuff. It would be nice to have something more portable.
> > 
> >      Karel
> > 
> 
> As I understood, issue exists only at x86 platform, where
> MC146818-compatible RTC used.
> 
> But even if you will correctly detect platform, there is no guaranty to get
> exactly MC146818 RTC. RTC can be other type. It even can be not single in
> the system.
> 
> What is more or less usable is "/sys/class/rtc/rtcX/name" file, which
> contains driver name.
> For x86 and MC146818-compatible RTC its name is "rtc_cmos". And it can be
> used to distinguish RTC type by hwclock utility.

Implemented. From commit message:

    * add command line option --delay <seconds>
    
    * read RTC type from /sys/class/rtc/rtc<N>/name
    
    * default to 0.5 (500ms) for rtc_cmos or when RTC type is impossible
      determine; otherwise default is 0.


The change should be backwardly compatible in case hwclock is executed
in time /sys is not mounted. The option --delay overwrites everything.

The RTC type and the delay are visible by --verbose.

Maybe you can try it with your HW to test the patch :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
