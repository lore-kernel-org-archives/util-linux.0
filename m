Return-Path: util-linux-owner@vger.kernel.org
Received: from sender153-mail.zoho.com ([74.201.84.153]:22362 "EHLO
	sender153-mail.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872AbbKOUkS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 Nov 2015 15:40:18 -0500
Message-ID: <5648EA26.2080804@zoho.com>
Date: Sun, 15 Nov 2015 21:25:10 +0100
From: =?UTF-8?B?w4FuZ2VsIEdvbnrDoWxleg==?= <ingenit@zoho.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: unshare -m for non-root user
References: <n2674p$ulm$1@ger.gmane.org> <87si49p771.fsf@x220.int.ebiederm.org> <n26nkm$13l$1@ger.gmane.org> <20151114181716.GA3839@newbook> <n287q4$efd$1@ger.gmane.org> <n28krj$8i0$1@ger.gmane.org> <20151115012418.GC31395@vapier.lan> <n28pis$6uv$1@ger.gmane.org> <20151115062819.GD31395@vapier.lan> <n29sg5$15j$1@ger.gmane.org> <20151115124211.GA5949@vapier.lan> <n2a9uv$313$1@ger.gmane.org>
In-Reply-To: <n2a9uv$313$1@ger.gmane.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>> complain to Debian. iirc, they break their kernels on purpose by adding
>> non-standard caps which disallow userns usage.
>
> Ok, I found out that on Debian one needs to make the follwing entry in
> /etc/sysctl.conf:
> kernel.unprivileged_userns_clone = 1
> and reboot, or do sysctl -p /etc/sysctl.conf, or equivalently
> echo 1 > /proc/sys/kernel/unprivileged_userns_clone

The kernel will neded to be compiled with CONFIG_USER_NS

