Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20004 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976Ab2KHNsF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 Nov 2012 08:48:05 -0500
Date: Thu, 8 Nov 2012 14:48:01 +0100
From: Karel Zak <kzak@redhat.com>
To: Matt Burgess <matthew@linuxfromscratch.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Discrepancies between real and symlinked mtab
Message-ID: <20121108134801.GA1983@x2.net.home>
References: <1351638239.1651.13.camel@kyoto.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1351638239.1651.13.camel@kyoto.localdomain>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 30, 2012 at 11:03:59PM +0000, Matt Burgess wrote:
> 1) mount(8)
> 
> /dev/root on / type ext3 (rw,relatime,data=ordered)

 I have improved libmount and now it returns the real device name if
 the file /proc/cmdline contains root= option.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
