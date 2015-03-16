Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35938 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbbCPATR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 Mar 2015 20:19:17 -0400
Received: by padcy3 with SMTP id cy3so47324956pad.3
        for <util-linux@vger.kernel.org>; Sun, 15 Mar 2015 17:19:16 -0700 (PDT)
Received: from Sparta ([50.0.225.244])
        by mx.google.com with ESMTPSA id sg4sm14098821pac.11.2015.03.15.17.19.15
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2015 17:19:16 -0700 (PDT)
Date: Mon, 16 Mar 2015 00:19:14 +0000
From: Isaac Dunham <ibid.ag@gmail.com>
To: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/5] hwclock: remove depreciated ntpdate
Message-ID: <20150316001913.GB1722@Sparta>
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

On Debian Jessie, there's ntpdate, no sntp, and apt-cache search sntp only
shows rdate (which can use the SNTP protocol).

Thanks,
Isaac Dunham
