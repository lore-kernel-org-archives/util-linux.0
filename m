Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:30813 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846Ab1GRW2w (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Jul 2011 18:28:52 -0400
Date: Tue, 19 Jul 2011 00:28:47 +0200
From: Karel Zak <kzak@redhat.com>
To: Thomas =?utf-8?Q?B=C3=A4chler?= <thomas@archlinux.org>
Cc: util-linux@vger.kernel.org
Subject: Re: dmesg(1) changes
Message-ID: <20110718222847.GG4354@nb.redhat.com>
References: <20110714115231.GF3486@nb.net.home> <4E242E69.6090409@archlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4E242E69.6090409@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 18, 2011 at 03:00:25PM +0200, Thomas Bächler wrote:
> Am 14.07.2011 13:52, schrieb Karel Zak:
> > 
> >  Hi,
> > 
> > I did some changes to dmesg(1) in last days:
> 
> Thanks for these advances.
> 
> While we're making a wishlist, I always wanted a 'follow' option
> (similar to tail -f/-F) for dmesg.

 It's not so simple:
 http://www.spinics.net/lists/util-linux-ng/msg04453.html

 I'll try to play with that a little more later. Now I'd like to
 release 2.20 ASAP.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
