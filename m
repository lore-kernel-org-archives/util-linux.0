Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40845 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753543AbaLDNAs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 4 Dec 2014 08:00:48 -0500
Date: Thu, 4 Dec 2014 14:00:44 +0100
From: Karel Zak <kzak@redhat.com>
To: Matthew Eaton <m.eaton82@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fdisk units size
Message-ID: <20141204130044.GH1994@x2.net.home>
References: <CAF+0mvmE_i0P350hT4E4a-ZTTuuS5PdZ2vw1siQ2HowpB2Xn-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAF+0mvmE_i0P350hT4E4a-ZTTuuS5PdZ2vw1siQ2HowpB2Xn-g@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 25, 2014 at 04:19:25PM -0800, Matthew Eaton wrote:
> Hello, I have a quick question regarding recent fdisk.
> 
> I noticed fdisk -l now uses base 2 (GiB) instead of base 10 (GB) to
> calculate device size.  This is good, but sometimes it is nice to see

 when sometimes?

> the base 10 calculation, can this be toggled with a switch?  I can't
> find a recent man page for fdisk.

 Frankly, use 10 based calculation in IT is ugly thing, we are not 
 hard disk device marketing guys...

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
