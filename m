Return-Path: <SRS0=Tf+r=CU=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCECDC43461
	for <util-linux@archiver.kernel.org>; Fri, 11 Sep 2020 10:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A90208FE
	for <util-linux@archiver.kernel.org>; Fri, 11 Sep 2020 10:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tw/t/SxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgIKKmf (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 11 Sep 2020 06:42:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28838 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725836AbgIKKmc (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 11 Sep 2020 06:42:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599820951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZCa8gZ9WW/EuJVTSC4vBeq10ZKPBGhaYrllm4rX4IfI=;
        b=Tw/t/SxB+MEdrzez3+LxKS433422Ws5cZQa2jKFdnwxsjZtFYgIQkDDS049QdA+q9OoFPu
        rNNq2eYwNnOsI30aXXEUcbZ4NWXfCJ4E6k71hdadO74HjLv3uzltDU2tl5mQnQT1zUleqh
        upC/8rnDXRmLAMlp/eG9KLa04T8RP40=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-yAEuo5__PB-VMnzJwiLCaA-1; Fri, 11 Sep 2020 06:42:25 -0400
X-MC-Unique: yAEuo5__PB-VMnzJwiLCaA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 655CC80365D;
        Fri, 11 Sep 2020 10:42:24 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0ED399CBA;
        Fri, 11 Sep 2020 10:42:22 +0000 (UTC)
Date:   Fri, 11 Sep 2020 12:42:20 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Hans Holmberg <hans.holmberg@wdc.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Matias Bjorling <matias.bjorling@wdc.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] blkzone: add report capacity command
Message-ID: <20200911104220.uqsyxo2v446wfldq@ws.net.home>
References: <20200911084723.14996-1-hans.holmberg@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911084723.14996-1-hans.holmberg@wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Sep 11, 2020 at 10:47:23AM +0200, Hans Holmberg wrote:
>  sys-utils/blkzone.8 |  7 +++++++
>  sys-utils/blkzone.c | 28 ++++++++++++++++++++--------
>  2 files changed, 27 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

