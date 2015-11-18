Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:42290 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753236AbbKRSYd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 18 Nov 2015 13:24:33 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1Zz7P8-0000qw-W2
	for util-linux@vger.kernel.org; Wed, 18 Nov 2015 19:24:27 +0100
Received: from 78-60-211-195.static.zebra.lt ([78.60.211.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 18 Nov 2015 19:24:26 +0100
Received: from grawity by 78-60-211-195.static.zebra.lt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 18 Nov 2015 19:24:26 +0100
To: util-linux@vger.kernel.org
From: =?UTF-8?Q?Mantas_Mikul=c4=97nas?= <grawity@gmail.com>
Subject: Re: RFC: usermount - a secure mount for unpriviledged users
Date: Wed, 18 Nov 2015 20:24:19 +0200
Message-ID: <564CC253.2080301@gmail.com>
References: <n2ibqp$ui6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <n2ibqp$ui6$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2015-11-18 19:17, U.Mutlu wrote:
> Currently no responsible admin can grant permission to the mount pgm
> to his users, because of the dangers inherent with bind-mounting etc.
> 
> I suggest there should be an additional mount program destined for
> unpriviledged users (to be used via sudo).
> 
> It should be a stripped down version of the mount pgm, with only some
> basic options for mounting, but without the dangerous options like
> bind-mount.
> 
> The new program should of course have a different name, for example
> "usermount".
> 
> I think this is the most clean solution to this problem.
> 
> Users are intessted in mounting their own filesystems into
> their own mountpoints, ie. they don't neccesserily need fstab or mtab etc.:
>   $ mkdir mymnt1 mymnt2
>   $ sudo usermount myfs.img ./mymnt1
>   $ sudo usermount my.iso   ./mymnt2

fwiw, udisks2 already lets you mount removable drives and loop devices
under (/run)/media:

  $ udisksctl mount -b /dev/sdb4

  $ udisksctl loop-setup -f ~/foo.img

-- 
Mantas Mikulėnas <grawity@gmail.com>

