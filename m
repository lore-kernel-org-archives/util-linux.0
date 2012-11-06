Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.9]:58673 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952Ab2KFQZE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 6 Nov 2012 11:25:04 -0500
Date: Tue, 6 Nov 2012 17:25:02 +0100 (CET)
From: Bernhard Voelker <mail@bernhard-voelker.de>
Reply-To: Bernhard Voelker <mail@bernhard-voelker.de>
To: util-linux@vger.kernel.org, mp.lists@free.fr
Message-ID: <535592290.498944.1352219102253.JavaMail.open-xchange@email.1und1.de>
In-Reply-To: <1352214367.5099275f85792@imp.free.fr>
References: <1352214367.5099275f85792@imp.free.fr>
Subject: Re: Accessibility of swap files
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On November 6, 2012 at 4:06 PM mp.lists@free.fr wrote:
> Hi *,
>
> I think, measures can|should be taken, which reduce the probability of having
> a
> swap file inadvertently run with too open permissions.
>
> As a first idea, it looks, as if such may be implemented, eg. by
>      letting swapon [and fstab-based "mounting"] by default not enable a swap
> file, if it has non-root access permissions

Did you know?
The swapon utility issues a warning diagnostic with --verbose:

  # ls -l /tmp/swapfile
  -rw-r--r-- 1 berny users 134217728 Nov  6 17:03 /tmp/swapfile

  # sbin/swapon -v  /tmp/swapfile
  swapon /tmp/swapfile
  swapon: /tmp/swapfile: insecure permissions 0644, 0600 suggested.
  swapon: /tmp/swapfile: insecure file owner 1000, 0 (root) suggested.
  swapon: /tmp/swapfile: found swap signature: version 1, page-size 4, same byte
order
  swapon: /tmp/swapfile: pagesize=4096, swapsize=134217728, devsize=134217728

BTW: the check for the owner has been added in 2.19
(in commit v2.18-88-g306c1df).

I don't know if refusing to swapon insecure swap files is a good
idea (see below).

>   || letting mkswap by default ignore too open settings of umask and create
> the
> swap file mod 0600 instead.

You don't need root privs to run mkswap. Furthermore, mkswap
doesn't create the swap file (in terms of calling creat()).
Instead, it just writes to it.
Nevertheless, I think a warning would be enough/nice at this stage.

> In both cases, an explicit switch|parameter could enable the present,
> non-restrictive behaviour.

Changing behavior is not always a good idea for compatibility reasons,
and therefore deserves *good* arguments.
Let Karel decide.

> PS: I'm speaking as of util-linux-ng version 2.17.2.

I'm speaking about the latest version in Git. ;-)

Have a nice day,
Berny
