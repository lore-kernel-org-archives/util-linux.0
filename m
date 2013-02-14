Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:33839 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755252Ab3BNMav (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Feb 2013 07:30:51 -0500
Received: from relay1.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 2FB61A52C6
	for <util-linux@vger.kernel.org>; Thu, 14 Feb 2013 13:30:50 +0100 (CET)
Date: Thu, 14 Feb 2013 13:30:47 +0100
From: "Dr. Werner Fink" <werner@suse.de>
To: Util-Linux <util-linux@vger.kernel.org>
Subject: Discussion on BIOS/CMOS/UEFI clock in local time
Message-ID: <20130214123047.GA12371@boole.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

just before such a discussion I'd like to point the mail

     https://lkml.org/lkml/2008/1/12/87

from Ted Ts'o in the mail thread

     https://lkml.org/lkml/2008/1/8/195

In this mail he advises to set set the system clock before running
e2fsck on an ext3 and higher file system to avoid wrong timestamps.

As this problem can also occur with other journaling file systems
the way to avoid this is to correct the kernels assumption that the
BIOS/CMOS clock is running in UTC by using the the system call
settimeofday(2) with the tz_minuteswest field of the timezone
structure.

This may done with the hwclock option --systz or here with the
small warpclock utility in the initrd/initramfs.  Now with the UEFI
specs (section 7.3) the local time will become more often the default
for the BIOS/CMOS clock.

This will raise twice a year the problem if or if the HW clock has
been corrected for DST on/off by the user or an other OS like Windows[tm].
First case requires to ask the user if or if the DST offset has been
corrected.  Whereas in the second case I do not know where the other
OS stores its information about DST on/off.

With UEFI this could be solved as the EFI BIOS shows DST and TIMEZONE
entries.  But AFAICS from the kernels source (3.7) the timezone is
simply ignored, compare with drivers/rtc/rtc-efi.c as well as with
drivers/char/efirtc.c in the functions convert_to_efi_time() and
convert_from_efi_time() ...  also for the user space tools there
is no API to change e.g. the DST flag.


    Werner

-- 
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr
