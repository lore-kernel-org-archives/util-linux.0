Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:13820 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751435AbaBQL6d (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Feb 2014 06:58:33 -0500
Date: Mon, 17 Feb 2014 12:58:29 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: please document alternate "bind" syntax in mount(8)
Message-ID: <20140217115829.GD2254@x2.net.home>
References: <52F50F60.3010103@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52F50F60.3010103@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 07, 2014 at 11:52:48AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Forwarded from debian bug #409942:
> 
> At the moment, neither mount(8) nor fstab(5) tells us how to do bind
> mounts with fstab, or even that it's possible.  We have to *guess* that
> doing this in fstab works:
> /some/old/dir   /some/new/mountpoint   ???   bind   ???   ???
> and it's not clear what is or isn't permitted for ???.

I see section "The bind mounts." in the man mount page where is
fstab example.

> Isn't it also time to update the SYNOPSIS in mount(8), now that linux
> versions >=2.4.0 will be standard ?  I suggest adding two lines
> like this:
>          mount { --bind | -o bind } olddir newdir
>          mount { --rbind | -o rbind } olddir newdir
> or, possibly, just one line
>          mount { --bind | --rbind | -o bind | -o rbind } olddir newdir

 IMHO all is well described in the man page now.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
