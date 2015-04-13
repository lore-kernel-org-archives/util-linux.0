Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37033 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754069AbbDMLVG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Apr 2015 07:21:06 -0400
Date: Mon, 13 Apr 2015 13:20:59 +0200
From: Karel Zak <kzak@redhat.com>
To: "Jean-Loup 'clippix' Bogalho" <clippix@lse.epita.fr>
Cc: util-linux@vger.kernel.org, gabriel@lse.epita.fr
Subject: Re: [PATCH V2] dos: copy previous bootsector for dos partition table
Message-ID: <20150413112059.GP3923@ws.net.home>
References: <20150404160526.GA24261@clippix.lab.lse.epita.fr>
 <20150407094535.GF3923@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150407094535.GF3923@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 07, 2015 at 11:45:35AM +0200, Karel Zak wrote:
>  Maybe it would be better to add --protect-bootsector command line option;
>  if you want to implement it:
> 
>     - add protect_boot flag to struct fdisk_context (fdiskP.h)
>     - add a new function fdisk_protect_boot(cxt, enable) to set/unset the new flag
> 
>     - extend fdisk_init_firstsector_buffer() to protect specified area:
>          fdisk_init_firstsector_buffer(cxt, 0, 446)
> 
>     - call fdisk_init_firstsector_buffer() from dos_create_disklabel()
>       with proper offset and size when the protect_boot flag is enabled
> 
>     - add fdisk_protect_boot() to 
>         libfdisk/src/libfdisk.h.in
>         libfdisk/src/libfdisk.sym
>         libfdisk/docs/libfdisk-sections.txt

I'm working on this, because it's necessary for sfdisk.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
