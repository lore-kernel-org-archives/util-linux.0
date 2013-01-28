Return-Path: util-linux-owner@vger.kernel.org
Received: from sender1.zohomail.com ([72.5.230.95]:51789 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753426Ab3A1Ufe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 28 Jan 2013 15:35:34 -0500
Message-ID: <5106E09D.5010708@zoho.com>
Date: Mon, 28 Jan 2013 21:33:33 +0100
From: =?UTF-8?B?w4FuZ2VsIEdvbnrDoWxleg==?= <ingenit@zoho.com>
MIME-Version: 1.0
To: Ulf Zibis <Ulf.Zibis@gmx.de>
CC: util-linux@vger.kernel.org
Subject: Re: sfdisk man page bug
References: <51068D38.3040708@gmx.de>
In-Reply-To: <51068D38.3040708@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 28/01/13 15:37, Ulf Zibis wrote:
> Hi,
> 
> from the Manual page sfdisk(8):
> "... For example, when there are several primary DOS partitions, DOS
> assigns C: to the first among these that is bootable.)"
> 
> This seems to be wrong. I'm not 100 % sure about DOS, but about modern
> Windows, above statement is definitely wrong. Correct is:
> "... Windows/DOS assigns C: to the first among these that is visible
> (=not hidden).)"
> "... Windows/DOS typical generic MBR boot code loads and executes the
> bootloader found on the first among these that is bootable.)"
> 
> to be sure, I tested following:
> - having old WinXP installation on sda1, labelled "WIN_OLD"
> - copy this partition by GParted to sda2
> - newly install WinXP on sda1, labelled "WIN_NEW"
> - set sda2 to active
> - boot
> --> result:
> 1. in effect, WinXP from sda1 becomes booted
> 2. sda1 is named C:, cd1 is named D:, "bootable" sda2 is named E:
> 
> As today Windows is the more interesting use case, at least please add
> correct info for the Windows case.
> 
> Many thanks for your attention and hopefully answer,
> 
> -Ulf

Well, DOS assigns drive letters only to partitions it can read (although
obvious, this is not explained in the main page). When a partition is
hidden, it appears as having a different type, so it's skipped and thus
not taken into account.

In the Windows NT family (ie. all modern windows versions) it is
possible to assign fixed letters to a drive, so you no longer get the
letter-dancing that happened before.

