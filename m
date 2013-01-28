Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:53100 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756576Ab3A1Ohn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Jan 2013 09:37:43 -0500
Received: from mailout-de.gmx.net ([10.1.76.17]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0Mhg69-1ULe6v0gF9-00MrGF for
 <util-linux@vger.kernel.org>; Mon, 28 Jan 2013 15:37:42 +0100
Message-ID: <51068D38.3040708@gmx.de>
Date: Mon, 28 Jan 2013 15:37:44 +0100
From: Ulf Zibis <Ulf.Zibis@gmx.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: sfdisk man page bug
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

from the Manual page sfdisk(8):
"... For example, when there are several primary DOS partitions, DOS assigns C: to the first among 
these that is bootable.)"

This seems to be wrong. I'm not 100 % sure about DOS, but about modern Windows, above statement is 
definitely wrong. Correct is:
"... Windows/DOS assigns C: to the first among these that is visible (=not hidden).)"
"... Windows/DOS typical generic MBR boot code loads and executes the bootloader found on the first 
among these that is bootable.)"

to be sure, I tested following:
- having old WinXP installation on sda1, labelled "WIN_OLD"
- copy this partition by GParted to sda2
- newly install WinXP on sda1, labelled "WIN_NEW"
- set sda2 to active
- boot
--> result:
1. in effect, WinXP from sda1 becomes booted
2. sda1 is named C:, cd1 is named D:, "bootable" sda2 is named E:

As today Windows is the more interesting use case, at least please add correct info for the Windows 
case.

Many thanks for your attention and hopefully answer,

-Ulf

