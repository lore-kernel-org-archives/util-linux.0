Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45813 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450AbbCPKds (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Mar 2015 06:33:48 -0400
Date: Mon, 16 Mar 2015 11:33:42 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: J William Piggott <elseifthen@gmx.com>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/5] hwclock: remove depreciated ntpdate
Message-ID: <20150316103342.GD28925@ws.net.home>
References: <5503364E.6010302@gmx.com>
 <550337F0.3050100@gmx.com>
 <1426433205.3225343.240610937.5D55876F@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1426433205.3225343.240610937.5D55876F@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 15, 2015 at 04:26:45PM +0100, Benno Schulenberg wrote:
> 
> On Fri, Mar 13, 2015, at 20:18, J William Piggott wrote:
> > Replace references to the depreciated ntpdate with sntp.
> 
> s/depreciated/deprecated/
> 
> > -.BR \%ntpdate\ \-q " , or " \%date\ \-Ins
> > +.BR \%sntp ", or " \%date\ \-Ins
> 
> Hmm, maybe it's a bit to early to delete the mention of ntpdate?
> My fairly recent Linux Mint doesn't have sntp yet.  Maybe add
> sntp to the list instead of replacing ntpdate?

 Good point, it would be better to use something like "ntpdate or more
 recent sntp".

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
