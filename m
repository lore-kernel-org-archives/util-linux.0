Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46555 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756707Ab3BVKbX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 22 Feb 2013 05:31:23 -0500
Date: Fri, 22 Feb 2013 11:31:03 +0100
From: Karel Zak <kzak@redhat.com>
To: Util-Linux <util-linux@vger.kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: Re: Discussion on BIOS/CMOS/UEFI clock in local time
Message-ID: <20130222103103.GA5239@x2.net.home>
References: <20130214123047.GA12371@boole.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130214123047.GA12371@boole.suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 14, 2013 at 01:30:47PM +0100, Dr. Werner Fink wrote:
> just before such a discussion I'd like to point the mail
> 
>      https://lkml.org/lkml/2008/1/12/87
> 
> from Ted Ts'o in the mail thread
> 
>      https://lkml.org/lkml/2008/1/8/195
> 
> In this mail he advises to set set the system clock before running
> e2fsck on an ext3 and higher file system to avoid wrong timestamps.
> 
> As this problem can also occur with other journaling file systems
> the way to avoid this is to correct the kernels assumption that the
> BIOS/CMOS clock is running in UTC by using the the system call
> settimeofday(2) with the tz_minuteswest field of the timezone
> structure.
> 
> This may done with the hwclock option --systz or here with the
> small warpclock utility in the initrd/initramfs.  Now with the UEFI
> specs (section 7.3) the local time will become more often the default
> for the BIOS/CMOS clock.
> 
> This will raise twice a year the problem if or if the HW clock has
> been corrected for DST on/off by the user or an other OS like Windows[tm].
> First case requires to ask the user if or if the DST offset has been
> corrected.  Whereas in the second case I do not know where the other
> OS stores its information about DST on/off.
> 
> With UEFI this could be solved as the EFI BIOS shows DST and TIMEZONE
> entries.  But AFAICS from the kernels source (3.7) the timezone is
> simply ignored, compare with drivers/rtc/rtc-efi.c as well as with
> drivers/char/efirtc.c in the functions convert_to_efi_time() and
> convert_from_efi_time() ...  also for the user space tools there
> is no API to change e.g. the DST flag.

 That's cool news. Thanks.

 It seems that kernel CONFIG_RTC_HCTOSYS code should be improved to use
 the information from UEFI rather than blindly assume that HW clock is 
 always in UTC. I don't see a reason to try to fix this in userspace as
 we use (or we want:-) CONFIG_RTC_HCTOSYS almost everywhere.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
