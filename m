Return-Path: <SRS0=qYTN=2H=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4394C43603
	for <util-linux@archiver.kernel.org>; Tue, 17 Dec 2019 12:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBFE2082E
	for <util-linux@archiver.kernel.org>; Tue, 17 Dec 2019 12:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDlE4eTu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfLQMGR (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 17 Dec 2019 07:06:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38657 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726141AbfLQMGR (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 17 Dec 2019 07:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576584377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T+UdbR69bJVkjKvOivMK2M3BlSRM13pgQQrTZaCCbNU=;
        b=HDlE4eTuTPY54cuylL/vyH5ONLuE/2gL8CACTfnjDpVlz7D0D2DqmPjFCsRtMlIj6+dALH
        oSyN+bhj/J8SjndB4HNghXY3lSVBjC/MguSUqkiLvlLFX1kCA1y5tQJn6LAlkv6dNLHb7Z
        FMmjL8Ji71dcO7/QsJeFdOUlhO+LHyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-BAFbRTMgOPGWYvx8iERxew-1; Tue, 17 Dec 2019 07:06:15 -0500
X-MC-Unique: BAFbRTMgOPGWYvx8iERxew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9251E1800D63;
        Tue, 17 Dec 2019 12:06:13 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-205-38.brq.redhat.com [10.40.205.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CDB5768877;
        Tue, 17 Dec 2019 12:06:12 +0000 (UTC)
Date:   Tue, 17 Dec 2019 13:06:09 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] man pages: Make the number of .RS/.RE equal
Message-ID: <20191217120609.by6rab2fbqnrn65y@10.255.255.10>
References: <20191214001230.GA30935@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191214001230.GA30935@rhi.hi.is>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Dec 14, 2019 at 12:12:30AM +0000, Bjarni Ingi Gislason wrote:
>  sys-utils/mount.8    | 1 -
>  text-utils/hexdump.1 | 1 +
>  text-utils/more.1    | 1 +
>  3 files changed, 2 insertions(+), 1 deletion(-)

All 5 your man page patches have been applied. 

Thanks for all the work!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

