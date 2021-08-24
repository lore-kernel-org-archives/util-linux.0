Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0FFC4338F
	for <util-linux@archiver.kernel.org>; Tue, 24 Aug 2021 12:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0965A6127B
	for <util-linux@archiver.kernel.org>; Tue, 24 Aug 2021 12:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbhHXMsV (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 24 Aug 2021 08:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237298AbhHXMsU (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 24 Aug 2021 08:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629809255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=89ESICqyRHdJ5XmEU+qW7BTTHee0BRk1M5JevKl9d4s=;
        b=ZnUZxfKGznD/ge9YSJYYHzGYhzqVmrJ0aY0v/TnnriTe4yPIy123OCl1KF+SGvtrPpe09S
        mMo2s6cc4eKqjKybJFPatvoG9JIL9JUU0hyXRniNMp52e/TdNOIr/hGUQU4ENSUU7NbzuJ
        e3CXYzuZEilbjomYlpHI6suSf33r8/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-lZ8N8_HsM7SDUv8qUwqxcw-1; Tue, 24 Aug 2021 08:47:33 -0400
X-MC-Unique: lZ8N8_HsM7SDUv8qUwqxcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 827CA802921;
        Tue, 24 Aug 2021 12:47:32 +0000 (UTC)
Received: from ws.net.home (ovpn-112-16.ams2.redhat.com [10.36.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D70DC60C05;
        Tue, 24 Aug 2021 12:47:31 +0000 (UTC)
Date:   Tue, 24 Aug 2021 14:47:29 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 0/2] add columns for zoned parameters
Message-ID: <20210824124729.or5nyoadc3fbla2y@ws.net.home>
References: <20210824011718.300747-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824011718.300747-1-naohiro.aota@wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Aug 24, 2021 at 10:17:16AM +0900, Naohiro Aota wrote:
> Several parameters for zoned devices are missing from lsblk's columns. This
> series introduces them as following.

Thanks! I thought about it a few weeks ago ;-)

> 
>  Column Name      Description             Sysfs path
>  ---------------------------------------------------------------------
>  ZONE-SIZE        zone size               queue/chunk_sectors
>  ZONE-WGRAN       zone write granularity  queue/zone_write_granularity
>  ZONE-APPEND      zone append max bytes   queue/zone_append_max_bytes
>  ZONES-NR         number of zones         queue/nr_zones
>  ZONES-OMAX       max open zones          queue/max_open_zones
>  ZONES-AMAX       max active zones        queue/max_active_zones
> 
> Sample output:
> 
> $ lsblk -o NAME,ZONED,ZONE-SIZE,ZONE-WGRAN,ZONE-APPEND,ZONES-NR,ZONES-OMAX,ZONES-AMAX -i

What about to add all the columns to "--zoned" output too? 

We do not keep backward compatibility for set of columns in outputs
like --zoned, so it's open for changes. I guess we can use --zoned as
a generic option for all zoned stuff and not for a model only.

> NAME        ZONED        ZONE-SIZE ZONE-WGRAN ZONE-APPEND ZONES-NR ZONES-OMAX ZONES-AMAX
> sda         host-managed      256M         4K        672K    55880        128          0
> sdb         host-managed      256M         4K        672K    55880        128          0
> zram0       none                0B         0B          0B        0          0          0
> nvme2n1     none                0B         0B          0B        0          0          0
> |-nvme2n1p1 none                0B         0B          0B        0          0          0
> |-nvme2n1p2 none                0B         0B          0B        0          0          0
> `-nvme2n1p3 none                0B         0B          0B        0          0          0
> nvme0n1     none                0B         0B          0B        0          0          0
> nvme1n1     none                0B         0B          0B        0          0          0
> nvme0n2     host-managed        2G         4K          4M     1844         14         14
> nvme1n2     host-managed        2G         4K          4M     1844         14         14
> 
> $ lsblk --help|grep -i zone
>  -z, --zoned          print zone model
>         ZONED  zone model
>     ZONE-SIZE  zone size
>    ZONE-WGRAN  zone write granularity
>   ZONE-APPEND  zone append max bytes
>      ZONES-NR  number of zones
>    ZONES-OMAX  max open zones
>    ZONES-AMAX  max active zones

It would be nice to have shorter column names, but I do not have any
sane suggestion (Z-SIZE or Z-APPEND seems strange).

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

