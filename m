Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:5331 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489Ab3LLMFt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Dec 2013 07:05:49 -0500
Date: Thu, 12 Dec 2013 13:05:44 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: read only bind mount ignores ready only
Message-ID: <20131212120544.GJ16572@x2.net.home>
References: <52A878C5.6050505@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52A878C5.6050505@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 [CC: kernel guys]

On Wed, Dec 11, 2013 at 09:37:57AM -0500, Phillip Susi wrote:
> It seems that the kernel has a bug where it silently ignores the
> MS_RDONLY flag when creating a bind mount.  mount issues a warning
> that the mount point appears to be read-write even though you
> requested read only.  The reporter suggests a patch to automatically
> attempt to remount with MS_RDONLY before issuing this warning to work
> around the kernel bug.  What do you think?

I have it implemented, so

 mount --bind --read-only /mnt /mnt

is interpreted as two requests (two mount(2) calls)

 mount --bind /mnt /mnt
 mount -o remount,bind,ro /tmp      

it works as expected, but it does not work with MS_REC (recursive)
because kernel currently does not support

  MS_REMOUNT|MS_BIND|MS_REC|...

it means that 

  mount --rbind --read-only /mnt /mnt

creates only top-level read-only mountpoint, the rest is unchanged.


Miklos would be possible to fix kernel to accept MS_REC for
MS_REMOUNT|MS_BIND|MS_RDONLY operation? Please.

It seems that all we need is to call stuff in mnt_make_readonly() for 
all next_mnt() items.


(Well, it would be also nice to learn kernel to support
 MS_BIND|MS_RDONLY, but it's probably more invasive change.)

    Lare;

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
