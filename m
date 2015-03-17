Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32872 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932334AbbCQJ3J (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Mar 2015 05:29:09 -0400
Date: Tue, 17 Mar 2015 10:29:01 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/5] hwclock: remove depreciated ntpdate
Message-ID: <20150317092901.GS28925@ws.net.home>
References: <5503364E.6010302@gmx.com>
 <550337F0.3050100@gmx.com>
 <1426433205.3225343.240610937.5D55876F@webmail.messagingengine.com>
 <20150316103342.GD28925@ws.net.home>
 <5507A187.2020303@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5507A187.2020303@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 16, 2015 at 11:37:43PM -0400, J William Piggott wrote:
> On 03/16/2015 06:33 AM, Karel Zak wrote:
> > On Sun, Mar 15, 2015 at 04:26:45PM +0100, Benno Schulenberg wrote:
> >>
> >> On Fri, Mar 13, 2015, at 20:18, J William Piggott wrote:
> >>> Replace references to the depreciated ntpdate with sntp.
> >>
> >> s/depreciated/deprecated/
> >>
> >>> -.BR \%ntpdate\ \-q " , or " \%date\ \-Ins
> >>> +.BR \%sntp ", or " \%date\ \-Ins
> >>
> >> Hmm, maybe it's a bit to early to delete the mention of ntpdate?
> >> My fairly recent Linux Mint doesn't have sntp yet.  Maybe add
> >> sntp to the list instead of replacing ntpdate?
> > 
> >  Good point, it would be better to use something like "ntpdate or more
> >  recent sntp".
> 
> No, it is not a good point.  I assume he means *too* early, that's the
> funniest thing I've heard all day. No wait, "doesn't have sntp yet",
> that's the funniest thing I've heard all day.
> 
> The sntp client and ntpdate are both from the same project and
> approximately the same age. Nobody was interested in maintaining ntpdate
> so it *depreciated* over many years before being officially *deprecated*
> by the project.

You miss the point, after util-linux update, someone will read the man
page and then type "sntp" on command line, but because he has old /
stupid distro it will be unsuccessful. What next if there is no any
pointer to any other alternative? 

You're absolutely right with ntpdate vs. sntp, but it seems reality is
so painful that people still have systems where is no sntp.

> Before I added ntpdate two months ago, the hwclock man-page had gone 20
> years without it. Now there's concern over removing it?

OK :-) I'm going to apply the patches, it's nothing critical.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
