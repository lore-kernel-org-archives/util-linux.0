Return-Path: <SRS0=YmJi=65=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87114C433E0
	for <util-linux@archiver.kernel.org>; Fri, 15 May 2020 08:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D65CE206B6
	for <util-linux@archiver.kernel.org>; Fri, 15 May 2020 08:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hofstaedtler.name header.i=@hofstaedtler.name header.b="nF7X5nJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgEOIzg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 May 2020 04:55:36 -0400
Received: from mail.namespace.at ([213.208.148.235]:50810 "EHLO
        mail.namespace.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgEOIzg (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 15 May 2020 04:55:36 -0400
X-Greylist: delayed 313 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 May 2020 04:55:35 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=hofstaedtler.name; s=a; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GuZRvP2CcWKil2y7AESMKgmK3Dj2qVGj0GAMvyVEheM=; b=nF7X5nJCTUzSNpPEkLmz2/uKQW
        v2B0SnUKsZLM2MOAIsxqo2PTo3BBIHjceVLrnf/mwPGrEZPu6wAzf6/Xa4HPqd9vH+bDXJcJPKD39
        x8CXjfkNpRubqRjwDqY6P017Z08V1NsxQ9vcEMkkFGlzhT8HZybt7Jr/2jNWmc21XtaRHUyf+49+J
        JVMru6Ml/BSh23e4ZsdxgJ8xjhbqnZn9rL/JJFAr4Ts2aAU3WcnPdML7zlilsWtxRrc43l5uUzqF5
        KCkhQoF9QMmP9vwGGSpvOgCE6ZSKpLK2dGorSCayEau712QuPfXAVmQgsrHkmWzuYigk477eijy/A
        Q9vMMtCQ==;
Date:   Fri, 15 May 2020 10:50:13 +0200
From:   Chris Hofstaedtler <chris@hofstaedtler.name>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        Coly Li <colyli@suse.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] blkzone: deny destructive ioctls on busy blockdev
Message-ID: <20200515085013.i5lzw5t2sqpamwhi@zeha.at>
References: <20200515084133.21896-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200515084133.21896-1-johannes.thumshirn@wdc.com>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

* Johannes Thumshirn <johannes.thumshirn@wdc.com> [200515 10:41]:
> If a user submits a zone management ioctl from user-space, like a zone
> reset and a file-system (like zonefs or f2fs) is mounted on the zoned
> block device, the zone will get reset and the file-system's cached value
> of the zone's write-pointer becomes invalid.
> 
> Subsequent writes to this zone from the file-system will result in
> unaligned writes and the drive will error out.

"error out" meaning what exactly?

> Open the block device file in exclusive mode for submitting these ioctls.
> If a file-system is mounted the kernel will return -EBUSY and we can't
> continue issuing the ioctl.

Isn't this something the kernel should enforce, then?

What's to stop anybody from calling the ioctl from another tool,
without using O_EXCL?

Chris
