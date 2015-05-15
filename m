Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:44796
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbbEOJfp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 15 May 2015 05:35:45 -0400
Date: Fri, 15 May 2015 11:35:38 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: Ron <ron@debian.org>, 785116@bugs.debian.org
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Re: Bug#785116: util-linux: blkid -s returns too much information
Message-ID: <20150515093538.GC12181@fatal.se>
References: <20150512132634.1127.8640.reportbug@hex.shelbyville.oz>
 <20150513063604.GA466@fatal.se>
 <20150513103706.GE4834@ws.net.home>
 <20150513212052.GM27477@hex.shelbyville.oz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150513212052.GM27477@hex.shelbyville.oz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello!

On Thu, May 14, 2015 at 06:50:52AM +0930, Ron wrote:
[...]
> Yeah, I completely sympathise with the pain in that line of thinking.
> I guess the question for me would be is there really any use case
> where someone might actually be relying on this (mis)behaviour?
> One where they aren't already explicitly passing -s DEVNAME as one
> of the tags they want exported (which really is what you should be
> doing if that's what you want).
[...]

I'm willing to bet that noone explicitly uses "-s DEVNAME" already, as
that simply does not work (because DEVNAME is not a tag).

Hacking the code to make DEVNAME a tag looked trivial to me but changing
things (again) will be risk ending up in a neverending back-and-forth
dance between people wanting/relying on different behaviours. Thats
why I wanted to ask for input from upstream as soon as possible in
this matter, even before producing the patch.

Regards,
Andreas Henriksson
