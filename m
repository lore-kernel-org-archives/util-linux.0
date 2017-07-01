Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42402 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751976AbdGAXvV (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 1 Jul 2017 19:51:21 -0400
Date: Sun, 2 Jul 2017 01:51:15 +0200
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux <util-linux@vger.kernel.org>,
        Ruediger Meier <sweet_f_a@gmx.de>
Subject: Re: 0b2b32e8a7 caused an unusual increase in hwclock size
Message-ID: <20170701235115.qtoui3merx5nmoje@ws.net.home>
References: <bbb77383-8a90-b1b1-0dfa-78cee5fb6267@gmx.com>
 <919e5992-abd9-b66c-5799-833c594cece1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <919e5992-abd9-b66c-5799-833c594cece1@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jul 01, 2017 at 12:07:24PM -0400, J William Piggott wrote:
> 
> On 06/30/2017 04:41 PM, J William Piggott wrote:
> > 
> > Does anyone know why this small change added 43K (+23%) to the binary?
> 
> I'm no compiler guru, but it appears to me that gcc is smart enough to
> exclude the unused strutils.h file without using '#if defined', and this
> new code pulls it in.
> 
> So as I said when reviewing the commit, the new code needs to be in:
> #if defined(__linux__) && defined(__alpha__)
> https://marc.info/?l=util-linux-ng&m=149830453215524&w=2
> 
> After doing so the unused fat is no longer in the binary. I'm a bit
> surprised that strutils adds 43K though.
> 
> Then adding '#if defined' to the header include actually made the binary
> 32 bytes larger. The striped binary was unchanged.
> 
> I'm going to submit a patch to remove strutils from hwclock, but this
> information might apply to other commands that were changed?

It would be better to compare striped versions.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
