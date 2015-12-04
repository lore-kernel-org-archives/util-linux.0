Return-Path: util-linux-owner@vger.kernel.org
Received: from que006-public.msg.strl.va.charter.net ([68.114.190.43]:34826
	"EHLO que006-public.msg.strl.va.charter.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755092AbbLDXNY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 4 Dec 2015 18:13:24 -0500
Date: Fri, 4 Dec 2015 18:08:14 -0500 (EST)
From: Dave Rutherford <dave@evilpettingzoo.com>
Reply-To: dave@evilpettingzoo.com
To: util-linux@vger.kernel.org
cc: "U.Mutlu" <for-gmane@mutluit.com>
Subject: Re: fsck memory leak
Message-ID: <alpine.DEB.2.02.1512041806510.17213@bb>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 4, 2015 at 5:26 PM, U.Mutlu <for-gmane@mutluit.com> wrote:
> I'm not a friend of such default integrated system caching, it reminds
> me of Windows idiocy. This is nothing but a diskcache in ram,

... made up strictly of memory that nothing else wants.
This is different than a ramdisk, which itself is something that wants 
RAM.

> but then
> the admin should have the the freedom to set the size of the cache via
> a config file in etc, for example /etc/default/cache or in 
/etc/default/tmpfs.

Why? It's memory that *nothing else wants*. It's given up instantly
the moment something else needs to use it. So there's no downside,
unlike with that other "operating system" you mention.

> :-)

:-(

-- 
Prius I, Pontiff, Schenectadian Catholic Church
