Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26027 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821Ab1HHIyY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Aug 2011 04:54:24 -0400
Date: Mon, 8 Aug 2011 10:54:22 +0200
From: Karel Zak <kzak@redhat.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: umount -a
Message-ID: <20110808085422.GH2204@nb.net.home>
References: <4E387230.5060002@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E387230.5060002@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 02, 2011 at 04:54:56PM -0500, Bruce Dubbs wrote:
> At linuxfromscratch, we've just made some changes to write bootscript  
> messages to /run/var.  This seems to work fine for us until shutdown 
> where
>
>   umaount -a
>
> unmounts /run which is mounted as a tmpfs.  We can certainly work around  
> the problem, but was wondering if this issue may also affect others.
>
> The man page for umount says:
>
>  -a     All of the file systems described in /etc/mtab are unmounted.
> (With umount version 2.7 and later: the proc filesystem is not
> unmounted.)
>
> Would it be reasonable to change umount -a to also omit /run if it is  
> mounted as a tmpfs?

 umount -a -t notmpfs  ?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
