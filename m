Return-Path: util-linux-owner@vger.kernel.org
Received: from aserp1040.oracle.com ([141.146.126.69]:29942 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932245Ab3LENhR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 5 Dec 2013 08:37:17 -0500
Date: Thu, 5 Dec 2013 14:37:07 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, xen-devel@lists.xen.org
Subject: Re: [RFC PATCH] sgetty: Smart serial console getty
Message-ID: <20131205133707.GB17074@olila.local.net-space.pl>
References: <1386196297-2398-1-git-send-email-daniel.kiper@oracle.com>
 <20131205110508.GC8058@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131205110508.GC8058@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,

On Thu, Dec 05, 2013 at 12:05:08PM +0100, Karel Zak wrote:
>
>  Hi Daniel,
>
> On Wed, Dec 04, 2013 at 11:31:37PM +0100, Daniel Kiper wrote:
> > Very often when I was switching from Xen to Linux I was forced
> > to change /etc/inittab to make serial console working. It was
> > boring so I thought how to solve that problem. I was not able
> > to find sensible solution. So I decided to write something.
> > Here it is.
>
> Would be better to extend agetty(1) to read console name from kernel
> command line rather than introduce a special wrapper?
>
> Something like:
>
>    agetty --detect-console [baud_rate...] [term]

Make sens.

> Note that in login-utils/sulogin-consoles.c we have code to detect
> consoles for sulogin, for example detect_consoles_from_cmdline().

Great... I will try to use it. Should I build this file as a library
and then link into agetty or just link ordinary object file
(login-utils/sulogin-consoles.o) with it?

> We did a lot of work to consolidate and clean up agetty and kill
> things like mingetty in last years. So I'd like to have only util,
> especially if all the magic is just console name only.

Agreed.

> > I posted this patch earlier to Xen-devel list but Ian Campbell
> > stated that it is more generic and maybe I should try to include
>
> yeah, that's probably a generic issue.
>
> BTW, I guess that systemd does not use hardcoded console names (like
> /etc/inittab), ... just for the record :-) (I have no problem to
> support classic inittab.)

That is great. However, I do not know systemd (I only heard about that)
and maybe my question is stupid but I am curious how it starts getty
on serial console, i.e. how it gets a name of serial console and
passes it to getty.

Daniel
