Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56300 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754129AbbFJKZo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Jun 2015 06:25:44 -0400
Date: Wed, 10 Jun 2015 12:25:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Tom Yan <tom.ty89@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: making `blkid -lt NAME=value -o device` equivalent to `findfs`
 for PART{UUID,LABEL}
Message-ID: <20150610102542.GJ1992@ws.net.home>
References: <CAGnHSEksSynfOvBMuPAMdFxgdip8=wfUFKhVM5ZeYjiP7x102w@mail.gmail.com>
 <CAGnHSEmnn5z-=x4V6dkh1hK3Gq2_v2Hn9HxqT4rC5n1fGAdkbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGnHSEmnn5z-=x4V6dkh1hK3Gq2_v2Hn9HxqT4rC5n1fGAdkbA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 10, 2015 at 03:23:56PM +0800, Tom Yan wrote:
> By the way, according to the blkid(8):
> 
>        -l     Look up only one device that matches the search
> parameter specified with the -t option.  If there are multiple devices
> that match the specified search parameter,  then  the  device  with
> the
>               highest  priority  is  returned,  and/or the first
> device found at a given priority...
> 
> However, as you can see in my last email, blkid_evaluate_tag() doesn't
> seem to return the first device. Only `blkid -lt PARTLABEL="EFI
> System" -o device`, which doesn't use the function, output the
> "/dev/sda1".

blkid_evaluate_tag() follows /etc/blkid.conf EVALUATE= setting (see
man blkid). The default is to use udev and /dev/disk/by-* symlinks
rather than the cache maintained by libblkid.

Maybe the best solution will be:

 1/ add info about this behavior to findfs man page
 2/ remove the shortcut:

> >     /* convert LABEL/UUID lookup to evaluate request */
> >     if (lookup && output_format == OUTPUT_DEVICE_ONLY && search_type &&
> >         (!strcmp(search_type, "LABEL") || !strcmp(search_type, "UUID"))) {
> >         eval++;
> >         lookup = 0;
> >     }

 .. and for blkid always use cache based results to keep it
 consistent.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
