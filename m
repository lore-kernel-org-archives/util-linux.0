Return-Path: util-linux-owner@vger.kernel.org
Received: from connie.slackware.com ([64.57.102.36]:39816 "EHLO
	connie.slackware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbcDKEwL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 11 Apr 2016 00:52:11 -0400
Date: Sun, 10 Apr 2016 21:35:41 -0700 (PDT)
From: Robby Workman <rworkman@slackware.com>
To: util-linux@vger.kernel.org
cc: kzak@redhat.com
Subject: Re: v2.29 plan: kill mtab
Message-ID: <alpine.LNX.2.02.1604071350320.22605@connie.slackware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:

> libmount supports three scenarios:
> 
> 1) regular classic /etc/mtab
>
> 2) /etc/mtab symlink to /proc/self/mount -- in this case libmount uses
>    /proc/self/mountinfo and /run/mount/utab
>
> The current default is to detect symlink and on-the-fly switch
> between 1) and 2).
>
> 3) --enable-libmount-force-mountinfo -- don't care about the symlink
>    and always use /proc/self/mountinfo. This is robust solution required
>    for example by systemd, because unfortunately sometimes people use
>    broken stuff (init scripts, tools, etc.) which removes the symlink.
>
>
> I'd like to make 3) default, the question is what with mtab code:
>
>    a) #ifdef all mtab code (and add --enable-libmount-support-mtab)
>
>    b) remove mtab support at all (because it's evil and horrible code)
>
> Comments?


We still use SysV init because it suits our needs just fine, and we
have no plans to migrate to systemd in the foreseeable future, so
we don't have any other compelling reason to use anything other than
classic /etc/mtab. As such, we'd certainly appreciate, at the very
least, leaving the mtab support in util-linux.

-RW
