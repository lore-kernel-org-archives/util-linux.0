Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccac.dreamhost.com ([208.97.132.202]:54329 "EHLO
	homiemail-a60.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753891Ab2KZEXg (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 25 Nov 2012 23:23:36 -0500
Message-ID: <1353903814.2945.13.camel@offbook>
Subject: Re: [PATCH 3/3] fdisk: dos: always write mbr
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Date: Sun, 25 Nov 2012 20:23:34 -0800
In-Reply-To: <20121114094358.GB1835@x2.net.home>
References: <1352880292.2577.5.camel@offbook>
	 <20121114094358.GB1835@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 2012-11-14 at 10:43 +0100, Karel Zak wrote:
> On Wed, Nov 14, 2012 at 12:04:52AM -0800, Davidlohr Bueso wrote:
> > There's no harm when writing the MBR, changed or not. This also
> 

Sorry about the long delay, life has been crazy busy - trying to squeeze
in some util-linux time :-)

> it's harm -- kernel has to parse the new PT, udev has to scan all the
> stuff etc. ... many event and every event is painful if you have
> complicated setup (DM, multipath, udisks, ...).

good point.

> 
> > allows us to get rid of the 'MBRbuffer_changed' global variable.
> 
> It would be nice to add to fdisk_context
> 
>     void *labeldata;
> 
>  and define in fdiskdos.h
> 
>  struct fdisk_dosdata {
>     int write_status;             /* FDISKDOS_WRITE_* flags */
>     ...
>  }
> 
>  enum {
>     FDISKDOS_WRITE_HDR     = (1 << 1)  /* header buffer modified (e.g. ID change) */
>     FDISKDOS_WRITE_PT      = (1 << 2)  /* partition table modified */
>     FDISKDOS_WRITE_EPT     = (1 << 3)  /* any extended partition table modified */
>  };
> 
> (maybe you found better names for the macros and variables :-)
> 
> 
>  than we can add fdisk_is_modified() and is_modified() to fdisk_label
>  driver and remove all label specific junk from fdisk.c.

Yeah, a generic pointer to label-specific data is something that we have
to do. I will take a look at this option for a v2.

Thanks,
Davidlohr


