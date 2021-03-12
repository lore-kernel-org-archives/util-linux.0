Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9754EC43331
	for <util-linux@archiver.kernel.org>; Fri, 12 Mar 2021 07:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 662FC64F88
	for <util-linux@archiver.kernel.org>; Fri, 12 Mar 2021 07:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhCLH41 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 12 Mar 2021 02:56:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231527AbhCLHzy (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 12 Mar 2021 02:55:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615535753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QlWPpjkuIyfWm6NLZltOKLflazr/SKOiiN0yww2SUCs=;
        b=O1NnSnXbFQANW8Vkpo2yZYKy/BAFUApA3BF61hwMoUx3oExv78V5gbICLZXVO4pGZKLenZ
        QsGQ5JN8Ry3ijXPSI2ee+S0AiaYh0V3wFeDkfWz69BGMl6XQKPgrulL5w8zGy9RF7nMRWh
        2YmmWqJEytMBReNOX2BJpTIzfbahRfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-jy6rJCfkNs2sPmbRmFSaiA-1; Fri, 12 Mar 2021 02:55:48 -0500
X-MC-Unique: jy6rJCfkNs2sPmbRmFSaiA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67B0084B9A1;
        Fri, 12 Mar 2021 07:55:47 +0000 (UTC)
Received: from ws.net.home (ovpn-113-171.ams2.redhat.com [10.36.113.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B3A0A101F961;
        Fri, 12 Mar 2021 07:55:46 +0000 (UTC)
Date:   Fri, 12 Mar 2021 08:55:43 +0100
From:   Karel Zak <kzak@redhat.com>
To:     L A Walsh <lkml@tlinx.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: is there a util, or can findmnt be enhanced...(RFE?)
Message-ID: <20210312075543.jei3secawflwrw6b@ws.net.home>
References: <604A8111.8090100@tlinx.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <604A8111.8090100@tlinx.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Mar 11, 2021 at 12:44:01PM -0800, L A Walsh wrote:
> I see 'findmnt' shows a mount if you specify the mount point.
> 
> Given the name, I was surprised it didn't already do
> this: I was wondering if it could find
> the mount point of a file or pathname I give to it?
> 
> So if I am in /home/cache/suse, and type:
> 
> >  findmnt .
> 
> it would tell me something like:
> 
> /home[cache/suse] /dev/Space/Home
> 
> meaning:
> MNTPOINT[offset_path]  <device>


 $ pwd
 /home/projects/util-linux

 $ findmnt --target .
 TARGET SOURCE         FSTYPE OPTIONS
 /home  /dev/nvme0n1p2 ext4   rw,relatime


 man page:

     -T, --target path
              Define the mount target.  If path is not a mountpoint
              file or directory, then findmnt checks the path elements
              in reverse order to get the mountpoint (this feature is
              supported only when searching in  kernel  files  and
              unsup‐ ported  for  --fstab).  It's recommended to use
              the option --mountpoint when checks of path elements are
              unwanted and path is a strictly specified mountpoint.


 I'll prove the beginning of the man page to make this feature more
 obvious.

   Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

