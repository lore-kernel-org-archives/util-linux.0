Return-Path: yamato@redhat.com
Date: Wed, 23 Nov 2011 02:09:16 +0900 (JST)
Message-Id: <20111123.020916.621492840863713193.yamato@redhat.com>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org
Subject: Re: [patch] Enable fstab.d in mount -a
From: Masatake YAMATO <yamato@redhat.com>
In-Reply-To: <20111122144755.GY7916@nb.net.home>
References: <20111114.224753.785892012923334635.yamato@redhat.com>
	<20111122144755.GY7916@nb.net.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <util-linux.vger.kernel.org>

On Tue, 22 Nov 2011 15:47:55 +0100, Karel Zak wrote:
> On Mon, Nov 14, 2011 at 10:47:53PM +0900, Masatake YAMATO wrote:
>> This patch makes mount command read fstab.d/*.fstab if the command
>> is built with --enable-libmount-mount.  
> 
>  Applied (with minor changes). Thanks! It was in my TODO for the next
>  release.
>  
>  I have also updated fstab.5 and mount.8 man pages.
> 
>     Karel

Thanks. Now we can put a mount point into a rpm package quite easily.

Masatake YAMATO
