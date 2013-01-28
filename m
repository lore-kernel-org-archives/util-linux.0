Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:52232 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977Ab3A1XAH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Jan 2013 18:00:07 -0500
Received: from mailout-de.gmx.net ([10.1.76.35]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MZRMh-1UIT4S3HsD-00LFcX for
 <util-linux@vger.kernel.org>; Tue, 29 Jan 2013 00:00:05 +0100
Message-ID: <510702F8.2050809@gmx.de>
Date: Tue, 29 Jan 2013 00:00:08 +0100
From: Ulf Zibis <Ulf.Zibis@gmx.de>
MIME-Version: 1.0
To: =?UTF-8?B?w4FuZ2VsIEdvbnrDoWxleg==?= <ingenit@zoho.com>
CC: util-linux@vger.kernel.org
Subject: Re: sfdisk man page bug
References: <51068D38.3040708@gmx.de> <5106E09D.5010708@zoho.com>
In-Reply-To: <5106E09D.5010708@zoho.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Ángel,

Am 28.01.2013 21:33, schrieb Ángel González:
> On 28/01/13 15:37, Ulf Zibis wrote:
>> Hi,
>>
>> from the Manual page sfdisk(8):
>> "... For example, when there are several primary DOS partitions, DOS
>> assigns C: to the first among these that is bootable.)"
>>
>> This seems to be wrong. I'm not 100 % sure about DOS, but about modern
>> Windows, above statement is definitely wrong. Correct is:
>> "... Windows/DOS assigns C: to the first among these that is visible
>> (=not hidden).)"
>> "... Windows/DOS typical generic MBR boot code loads and executes the
>> bootloader found on the first among these that is bootable.)"
>>
>> to be sure, I tested following:
>> - having old WinXP installation on sda1, labelled "WIN_OLD"
>> - copy this partition by GParted to sda2
>> - newly install WinXP on sda1, labelled "WIN_NEW"
>> - set sda2 to active
>> - boot
>> --> result:
>> 1. in effect, WinXP from sda1 becomes booted
>> 2. sda1 is named C:, cd1 is named D:, "bootable" sda2 is named E:
>>
>> As today Windows is the more interesting use case, at least please add
>> correct info for the Windows case.
>>
>> Many thanks for your attention and hopefully answer,
>>
>> -Ulf
> Well, DOS assigns drive letters only to partitions it can read (although
> obvious, this is not explained in the main page). When a partition is
> hidden, it appears as having a different type, so it's skipped and thus
> not taken into account.

By sfdisk it is possible to set the bootable flag to a "hidden" partition, but neither DOS nor 
Windows will see that partition as C:, and won't boot.
If you have 2 full Windows installations in 2 visible partitions (maybe from partition clone action) 
and the 2nd one is marked as bootable, Windows/DOS typical generic MBR boot code loads and executes the
bootloader, found on the 2nd partition, but that then boots the Windows system from the 1st 
partition, which will be assigned C:, regardless which partition is marked bootable. In ths case the 
example from sfdisk man page will not hold :-(
If you have 1 Windows installation in 1st partition and after install a 2nd instance of Windows on 
the 2nd partition (which may be a primary or a logical), a bootloader menu will appear to allow to 
boot one of both. If booting into the 2nd instance, the system volume would be D: (or E: if there is 
a CD-drive) and the 1st partition would also be visible, still as C:. In such constellation, no 
bootloader will be on the 2nd partition, so marking the 2nd as bootable will cause both to be 
unbootable, and there will be no effect whether which volume would be assigned as C:.

> In the Windows NT family (ie. all modern windows versions) it is
> possible to assign fixed letters to a drive, so you no longer get the
> letter-dancing that happened before.

Not really, the letter of the start volume can't be changed.

Do I have missed something?

-Ulf


