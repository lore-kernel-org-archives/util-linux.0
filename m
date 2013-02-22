Return-Path: util-linux-owner@vger.kernel.org
Received: from zabrina.hetzner-de.towertech.it ([178.63.16.19]:43257 "EHLO
	zabrina.hetzner-de.towertech.it" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755769Ab3BVMKI (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Feb 2013 07:10:08 -0500
Date: Fri, 22 Feb 2013 13:01:52 +0100
From: Alessandro Zummo <a.zummo@towertech.it>
To: Karel Zak <kzak@redhat.com>
Cc: Util-Linux <util-linux@vger.kernel.org>, rtc-linux@googlegroups.com
Subject: Re: Discussion on BIOS/CMOS/UEFI clock in local time
Message-ID: <20130222130152.11a07e49@linux.lan.towertech.it>
In-Reply-To: <20130222103103.GA5239@x2.net.home>
References: <20130214123047.GA12371@boole.suse.de>
	<20130222103103.GA5239@x2.net.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, 22 Feb 2013 11:31:03 +0100
Karel Zak <kzak@redhat.com> wrote:

>  That's cool news. Thanks.
> 
>  It seems that kernel CONFIG_RTC_HCTOSYS code should be improved to use
>  the information from UEFI rather than blindly assume that HW clock is 
>  always in UTC. I don't see a reason to try to fix this in userspace as
>  we use (or we want:-) CONFIG_RTC_HCTOSYS almost everywhere.

 It seems reasonable to me ;)

p.s.
 
 Even if I'd just force everyone to use UTC... :)

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it

