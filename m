Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-b32.telenor.se ([213.150.131.21]:48434 "EHLO
	smtprelay-b32.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbaG0KsK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Jul 2014 06:48:10 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b32.telenor.se (Postfix) with ESMTP id F1C37EE8FF
	for <util-linux@vger.kernel.org>; Sun, 27 Jul 2014 12:48:07 +0200 (CEST)
Date: Sun, 27 Jul 2014 12:48:06 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: wolput@on.nl, 756177@bugs.debian.org
Cc: util-linux@vger.kernel.org
Subject: fdisk -l regression between v2.24.2 and v2.25
Message-ID: <20140727104806.GA11443@fatal.se>
References: <53D4AA62.30501@openmailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53D4AA62.30501@openmailbox.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello Jos van Wolput!

Thanks for your bug report.

On Sun, Jul 27, 2014 at 03:29:38PM +0800, Jos van Wolput wrote:
[...]
> After upgrading util-linux 2.20.1-5.8 (sid) to version 2.25-3 (experimental) fdisk -l ends with
> the following error: cannot open /dev/sr0: No medium found
[...]
> fdisk: cannot open /dev/sr0: No medium found
> ---
> and the other devices /dev/sdb* are not shown.
> 
> Indeed I don't use the cdrom (sr0) but using fdisk -l from util-linux 2.20.1-5.8 (sid) there is no such issue, all disks are shown:
[...]

This seems to be a regression between 2.24.2 and 2.25 and git bisect tells
me the first bad commit is: a22c6eb206fb716fa4

Reverting a22c6eb206fb716fa4 and reviving wholedisk.h from 62acb047a625059e77
makes v2.25 fdisk -l work as expected for me.

I'm CCing the upstream developer mailing list to hopefully have some help
on finding the proper fix.

Regards,
Andreas Henriksson
