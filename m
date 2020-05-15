Return-Path: <SRS0=YmJi=65=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC85C433E0
	for <util-linux@archiver.kernel.org>; Fri, 15 May 2020 10:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AAA12065C
	for <util-linux@archiver.kernel.org>; Fri, 15 May 2020 10:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxWAZNQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgEOKhw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 May 2020 06:37:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28877 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728013AbgEOKhw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 15 May 2020 06:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589539071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=grp5xKjKUEecw8So1DsIYL9ogErlwszup/1YeSpQEWo=;
        b=RxWAZNQsC9q9Rqh7LCJiF51cjo6A8bOEN1uLhbjjEIX68tkaIvg54gbazm9n46SolyfKEF
        xTb/Qbr63zJAqENbb2xbs//z9+7FpthiUwbcb244KAJMkPAY//bwYJk24HpbDYCAIK6nC0
        zwCgK3uYDt+jqQ9u05o1jbhuOiEvOYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-0TUOGsb6PvWaVEptc7J_fw-1; Fri, 15 May 2020 06:37:46 -0400
X-MC-Unique: 0TUOGsb6PvWaVEptc7J_fw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB2288005AD;
        Fri, 15 May 2020 10:37:43 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E1615D9D7;
        Fri, 15 May 2020 10:37:40 +0000 (UTC)
Date:   Fri, 15 May 2020 12:37:36 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Chris Hofstaedtler <chris@hofstaedtler.name>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Coly Li <colyli@suse.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] blkzone: deny destructive ioctls on busy blockdev
Message-ID: <20200515103736.5jsezljksq64kofg@ws.net.home>
References: <20200515084133.21896-1-johannes.thumshirn@wdc.com>
 <20200515085013.i5lzw5t2sqpamwhi@zeha.at>
 <SN4PR0401MB35982647432681A63CBABCA99BBD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB35982647432681A63CBABCA99BBD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, May 15, 2020 at 09:53:46AM +0000, Johannes Thumshirn wrote:
> On 15/05/2020 10:50, Chris Hofstaedtler wrote:
> > * Johannes Thumshirn <johannes.thumshirn@wdc.com> [200515 10:41]:
> >> If a user submits a zone management ioctl from user-space, like a zone
> >> reset and a file-system (like zonefs or f2fs) is mounted on the zoned
> >> block device, the zone will get reset and the file-system's cached value
> >> of the zone's write-pointer becomes invalid.
> >>
> >> Subsequent writes to this zone from the file-system will result in
> >> unaligned writes and the drive will error out.
> > 
> > "error out" meaning what exactly?
> 
> The drive will report an Unaligned Write error.
> 
> > 
> >> Open the block device file in exclusive mode for submitting these ioctls.
> >> If a file-system is mounted the kernel will return -EBUSY and we can't
> >> continue issuing the ioctl.
> > 
> > Isn't this something the kernel should enforce, then?
> 
> I did a patch for the kernel yesterday [1] enforcing this limitation, but as
> Damien said it's SYS_CAP_ADMIN and with great power comes great responsibility.
> We're also allowing other raw block device accesses on block devices.
> 
> [1] https://lore.kernel.org/linux-block/BY5PR04MB69006DE86D1050620B5EDAA4E7BD0@BY5PR04MB6900.namprd04.prod.outlook.com/
> 
> > What's to stop anybody from calling the ioctl from another tool,
> > without using O_EXCL?
> 
> Nothing, but still we don't need to make one's life hard by letting blkzone go 
> havoc with FS internal caching. If another tool does zone resets, it's up to them
> to check for mounted block devices.

O_EXCL good idea, it nothing unusual that you can do crazy things with
devices with mounted filesystem (see for example fdisk(s), wipefs, ...). 

And sometimes it is valid use-case to do "bad" things and in this case
we have --force option in our tools (for example to avoid O_EXCL).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

