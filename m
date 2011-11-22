Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:51481 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757693Ab1KVKyy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Nov 2011 05:54:54 -0500
Date: Tue, 22 Nov 2011 11:54:49 +0100
From: Karel Zak <kzak@redhat.com>
To: Maurizio Lombardi <m.lombardi85@gmail.com>
Cc: dave@gnu.org, util-linux@vger.kernel.org
Subject: Re: mkfs.minix V3 is broken
Message-ID: <20111122105449.GX7916@nb.net.home>
References: <CAMtsiiDWF3xCiFtENTaYS36zKOJjRHML0x2nk1P0d0zeU3qi0A@mail.gmail.com> <1321913175.3253.8.camel@offbook> <CAMtsiiDrWGKthY52+HT5r19g9EFRG2NHKMD3vni-SeaMNfuGDg@mail.gmail.com> <CAMtsiiDNPk4+m7JoWRp0JQWdL229OMCMYjZZsg-E2Ej0Rkv4OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAMtsiiDNPk4+m7JoWRp0JQWdL229OMCMYjZZsg-E2Ej0Rkv4OA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 22, 2011 at 11:05:04AM +0100, Maurizio Lombardi wrote:
> >    if (BLOCKS > MINIX_MAX_INODES)
> >       BLOCKS = MINIX_MAX_INODES;
> 
> Please note that this piece of code is horrible too, comparing the
> number of blocks to the max number of inodes is like comparing apples
> and oranges, no? :)
> 
> In general I think that the mkfs.minix is full of weird things and
> needs a serious cleanup.

 Go ahead! :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
