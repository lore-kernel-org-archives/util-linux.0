Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C7BC433F5
	for <util-linux@archiver.kernel.org>; Mon, 25 Apr 2022 13:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbiDYNn5 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 Apr 2022 09:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236605AbiDYNn5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 Apr 2022 09:43:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CBB749276
        for <util-linux@vger.kernel.org>; Mon, 25 Apr 2022 06:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650894052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XseoXK3Ue4xpw/SytrvIsRDE+AUgBXgzrwsswR2D/Jw=;
        b=RqpNCF1p3UfXUE5NS8+USchq/d90Z344vMRUFZLCuc96IdX+pj3U2slq+KvHvOnui7U/4l
        zB1+EA/YkuvuEwBDNUZhHoMmIji9jiz25DhVj6aHCRjB7Y29cMR2SUrkdfMSry2SqrqU+l
        4by9/1fvKQr3fjCFIpwDFtOvgmHkKno=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-kHDdWC7JOBqB-VTMjU852g-1; Mon, 25 Apr 2022 09:40:50 -0400
X-MC-Unique: kHDdWC7JOBqB-VTMjU852g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E74489FF19
        for <util-linux@vger.kernel.org>; Mon, 25 Apr 2022 13:40:42 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7CF454CB1C;
        Mon, 25 Apr 2022 13:40:41 +0000 (UTC)
Date:   Mon, 25 Apr 2022 15:40:39 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] libblkid: add interface for FSSIZE field
Message-ID: <20220425134039.4gmgdudcbdhftc7k@ws.net.home>
References: <20220421130946.318737-1-aalbersh@redhat.com>
 <20220421130946.318737-2-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421130946.318737-2-aalbersh@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Apr 21, 2022 at 03:09:45PM +0200, Andrey Albershteyn wrote:
> +int blkid_probe_set_fssize(blkid_probe pr, unsigned long long size)

I'd prefer uint64_t  rather than unsigned long long


> +{
> +	struct blkid_chain *chn = blkid_probe_get_chain(pr);
> +	char u[20];
> +
> +	if (!(chn->flags & BLKID_SUBLKS_FSSIZE))
> +		return 0;
> +
> +	snprintf(u, sizeof(u), "%llu", size);
> +
> +	return blkid_probe_set_value(pr, "FSSIZE", (unsigned char *) u, strlen(u) + 1);
> +}

  return blkid_probe_sprintf_value(pr, "FSSIZE", "%" PRIu64, size);

and you not need snprintf(), etc.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

