Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28277 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932812Ab2KNJoE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Nov 2012 04:44:04 -0500
Date: Wed, 14 Nov 2012 10:43:58 +0100
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/3] fdisk: dos: always write mbr
Message-ID: <20121114094358.GB1835@x2.net.home>
References: <1352880292.2577.5.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352880292.2577.5.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 14, 2012 at 12:04:52AM -0800, Davidlohr Bueso wrote:
> There's no harm when writing the MBR, changed or not. This also

it's harm -- kernel has to parse the new PT, udev has to scan all the
stuff etc. ... many event and every event is painful if you have
complicated setup (DM, multipath, udisks, ...).

> allows us to get rid of the 'MBRbuffer_changed' global variable.

It would be nice to add to fdisk_context

    void *labeldata;

 and define in fdiskdos.h

 struct fdisk_dosdata {
    int write_status;             /* FDISKDOS_WRITE_* flags */
    ...
 }

 enum {
    FDISKDOS_WRITE_HDR     = (1 << 1)  /* header buffer modified (e.g. ID change) */
    FDISKDOS_WRITE_PT      = (1 << 2)  /* partition table modified */
    FDISKDOS_WRITE_EPT     = (1 << 3)  /* any extended partition table modified */
 };

(maybe you found better names for the macros and variables :-)


 than we can add fdisk_is_modified() and is_modified() to fdisk_label
 driver and remove all label specific junk from fdisk.c.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
