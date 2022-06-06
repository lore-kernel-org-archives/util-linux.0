Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503E9C43334
	for <util-linux@archiver.kernel.org>; Mon,  6 Jun 2022 10:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbiFFKiy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 6 Jun 2022 06:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiFFKhi (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 6 Jun 2022 06:37:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13D2B366A3
        for <util-linux@vger.kernel.org>; Mon,  6 Jun 2022 03:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654511855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tPu17bzK2yA8niT03gWyNAYTSMwrZRNWCNoaFImPwlg=;
        b=dO8e06nhaUg1yckH7xSvwV5g/oAudRfKCJF23QTBvgYrxt37EzpjJmjOk5XpEC98/VzUFf
        i6uNB2BFRSIXLWj/I/nVXKAzFS4CbBJzR3us383blCqFdF1GeLVu4H/Oap5bu2g3Aytfql
        2uzVnfrv2EcxoNGnehc36rCilC1hLtw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-nGZhC7svPZWmdhH1zrF8lg-1; Mon, 06 Jun 2022 06:37:31 -0400
X-MC-Unique: nGZhC7svPZWmdhH1zrF8lg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73D2E1C16B42;
        Mon,  6 Jun 2022 10:37:31 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E903E82882;
        Mon,  6 Jun 2022 10:37:30 +0000 (UTC)
Date:   Mon, 6 Jun 2022 12:37:28 +0200
From:   Karel Zak <kzak@redhat.com>
To:     zhenwei pi <pizhenwei@bytedance.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 0/5] Support --nvme/--virtio and MQ
Message-ID: <20220606103728.ha5ez6tuwcifq4sk@ws.net.home>
References: <20220603122402.3274789-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603122402.3274789-1-pizhenwei@bytedance.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jun 03, 2022 at 08:23:57PM +0800, zhenwei pi wrote:
> zhenwei pi (5):
>   lsblk: add -N/--nvme
>   lsblk: support virtio block
>   lsblk: add -v/--virtio
>   lsblk: introduce 'MQ' column
>   lsblk: enable 'MQ' for NVMe/virtio by default
> 
>  bash-completion/lsblk   |  4 +-
>  misc-utils/lsblk.8.adoc |  6 +++
>  misc-utils/lsblk.c      | 84 ++++++++++++++++++++++++++++++++++++++++-
>  misc-utils/lsblk.h      |  2 +
>  4 files changed, 93 insertions(+), 3 deletions(-)

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

