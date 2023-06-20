Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC374EB64DB
	for <util-linux@archiver.kernel.org>; Tue, 20 Jun 2023 10:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjFTKBI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjFTKA2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 20 Jun 2023 06:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853C81BFB
        for <util-linux@vger.kernel.org>; Tue, 20 Jun 2023 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687255051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pO3pnwhfTZreKgikEWnu1u7APIomkmuG1G/wTb5pG8I=;
        b=aPmOv29hjNFMfKEcaPVQsUamW+G5nC0rxsFeRz/W3Zlv0cWKCQjZ4Swa2rLWVnLdQ/9S9l
        +Byr8OLn9DnuJ1lLKLzrexWl5Y5Oxzkii8YAns6vK5PdOX0TwFe5FYth/DS3HJVHG3/lmn
        WDbKG/zn6mI4g/Ez49JJFfz3xus9y8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-WAYYphdKN4Cyqh0IIsB-zw-1; Tue, 20 Jun 2023 05:57:28 -0400
X-MC-Unique: WAYYphdKN4Cyqh0IIsB-zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7FDB890F80;
        Tue, 20 Jun 2023 09:57:27 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3093717596;
        Tue, 20 Jun 2023 09:57:27 +0000 (UTC)
Date:   Tue, 20 Jun 2023 11:57:25 +0200
From:   Karel Zak <kzak@redhat.com>
To:     zhujun2 <zhujun2@cmss.chinamobile.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] blkid: solve a bug that the disk device of the
 ceph_bluestore
Message-ID: <20230620095725.juhogmjqjue4ohjf@ws.net.home>
References: <20230619023532.16534-1-zhujun2@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619023532.16534-1-zhujun2@cmss.chinamobile.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jun 19, 2023 at 10:35:32AM +0800, zhujun2 wrote:
> file system, the disk by-partlabel probability loss problem
> 
> The superblock of ceph_bluestore exists in the first 1024 bytes, and the
> real data is stored after 8K (that is, 16 sectors). By checking the source
> code of blkid, it is found to check whether it is the xfs_external_log file
> system, which is to cycle through the first 256k data range (the first
> 512 sectors ). That is to say, when blkid judges whether the partition is
> an xfs_external_log file system, it will mistakenly judge the real data of
> ceph_bluestore. This means that if the user's data itself conforms to
> the xfs_external_log format and is stored in sectors 17~512, it will be mistakenly
> considered as the xfs_external_log file system.

Not sure if I understand. According to docs BlueStore uses XFS
partition to store metadata and another device to store raw data. It
sounds like the XFS should be visible as a normal filesystem.

From your description it sounds like the both is on the same device
and we should not detect it as XFS log. If yes, then I do not
understand why anyone use XFS log header for this purpose.

XFS log detection seems robust, so I guess if libblkid detects the
superblock then it's really the FS.

    Karel

> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---
>  libblkid/src/superblocks/xfs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/libblkid/src/superblocks/xfs.c b/libblkid/src/superblocks/xfs.c
> index d8c6fb6d4..3686bd52b 100644
> --- a/libblkid/src/superblocks/xfs.c
> +++ b/libblkid/src/superblocks/xfs.c
> @@ -259,6 +259,11 @@ static int probe_xfs_log(blkid_probe pr,
>  		if (memcmp(&buf[i*512], "XFSB", 4) == 0)
>  			return 1;
>  
> +		if (memcmp(&buf[i*512], "bluestore block device", 22) == 0) {
> +			DBG(LOWPROBE, ul_debug("\t device has ceph_bluestore ambivalent"));
> +			return 1;
> +		}
> +
>  		rhead = (struct xlog_rec_header *)&buf[i*512];
>  
>  		if (xlog_valid_rec_header(rhead)) {
> -- 
> 2.20.1
> 
> 
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

