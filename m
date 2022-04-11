Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6CCC433F5
	for <util-linux@archiver.kernel.org>; Mon, 11 Apr 2022 09:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbiDKJpo (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 11 Apr 2022 05:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiDKJpn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 11 Apr 2022 05:45:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7311E37A11
        for <util-linux@vger.kernel.org>; Mon, 11 Apr 2022 02:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649670209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZC266Be7AIQkNuWA1ogBOdFuT8hy6lh161Yi20Mniqg=;
        b=IDpB8mBt4DnhV9bj9sB89AfMsYRbZTivjZLCrjY+q2IxgGi0xgoB1hmpdUW+eNtOX/+NK2
        0SrZME6EwrNVVa9Xz6wu9ijCQbMz1iTlK9QO1HfSFp2iY5yiXnZ99wATLiuAOpyLestCnf
        erjHJ96+J1sViXv2zyVOeOUCIUyyd94=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-U3IbosPVNK6KgLWu-m6b4w-1; Mon, 11 Apr 2022 05:43:27 -0400
X-MC-Unique: U3IbosPVNK6KgLWu-m6b4w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A19AF299E745;
        Mon, 11 Apr 2022 09:43:27 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C31E406793;
        Mon, 11 Apr 2022 09:43:26 +0000 (UTC)
Date:   Mon, 11 Apr 2022 11:43:24 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Philippe Reynes <philippe.reynes@softathome.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/1] libfdisk: write mbr only when useful
Message-ID: <20220411094324.f2qu5ebqb27ldppz@ws.net.home>
References: <20220408121004.183615-1-philippe.reynes@softathome.com>
 <20220408121004.183615-2-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408121004.183615-2-philippe.reynes@softathome.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Apr 08, 2022 at 02:10:04PM +0200, Philippe Reynes wrote:
>  static int gpt_write(struct fdisk_context *cxt, off_t offset, void *buf, size_t count)
>  {
>  	if (offset != lseek(cxt->dev_fd, offset, SEEK_SET))
> @@ -2079,6 +2092,8 @@ static int gpt_write_header(struct fdisk_context *cxt,
>  static int gpt_write_pmbr(struct fdisk_context *cxt)
>  {
>  	struct gpt_legacy_mbr *pmbr;
> +	struct gpt_legacy_mbr *current;
> +	int rc;
>  
>  	assert(cxt);
>  	assert(cxt->firstsector);
> @@ -2107,6 +2122,25 @@ static int gpt_write_pmbr(struct fdisk_context *cxt)
>  		pmbr->partition_record[0].size_in_lba =
>  			cpu_to_le32((uint32_t) (cxt->total_sectors - 1ULL));
>  
> +	current = malloc(sizeof(*current));
> +	if (!current)
> +		goto do_write;
> +
> +	rc = gpt_read(cxt, GPT_PMBR_LBA * cxt->sector_size,
> +		      current, cxt->sector_size);
> +	if (rc)

here is memory leak (for "current")

> +		goto do_write;
> +
> +	rc = memcmp(pmbr, current, sizeof(*current));

What about:

        rc = gpt_read(cxt, GPT_PMBR_LBA * cxt->sector_size, current, cxt->sector_size);

        if (rc == 0)
            rc = memcmp(pmbr, current, sizeof(*current));

        free(current);

        if (rc) {
           DBG(GPT, ul_debug("Same MBR on disk => don't write it"));
           return 0;
        }

    Karel

> +	free(current);
> +
> +	if (!rc) {
> +		DBG(GPT, ul_debug("Same MBR on disk => don't write it"));
> +		return 0;
> +	}
> +
> + do_write:
>  	/* pMBR covers the first sector (LBA) of the disk */
>  	return gpt_write(cxt, GPT_PMBR_LBA * cxt->sector_size,
>  			 pmbr, cxt->sector_size);
> -- 
> 2.25.1
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

