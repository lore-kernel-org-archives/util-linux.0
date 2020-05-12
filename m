Return-Path: <SRS0=qlqL=62=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BB6C54E4B
	for <util-linux@archiver.kernel.org>; Tue, 12 May 2020 08:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6E9F20714
	for <util-linux@archiver.kernel.org>; Tue, 12 May 2020 08:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoSrm+qx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgELIPM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 12 May 2020 04:15:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27258 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbgELIPM (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 12 May 2020 04:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589271311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EJ9QAC0J5DYwj84rmU6w15yF0Fc5XABtF6qBDagfFzc=;
        b=WoSrm+qx/w9lXTg7bdDt3ycqNcYlsWjPUiClgKnWqoYd4PYsw0rUwoYCSWtvLJD/dR1s0o
        Q371HIU4z9MFjqU3H0+OedJKbvZD3RgJvgVjxHFN5GJMuQ7tFU4HW9gf+NpwrHPmOqBA9J
        kuGWVK3o+xI7+lVQrSF7S/WLE3HDqqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-80kWNhDgPvypSzb7i4wLUA-1; Tue, 12 May 2020 04:11:08 -0400
X-MC-Unique: 80kWNhDgPvypSzb7i4wLUA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 873E1475;
        Tue, 12 May 2020 08:11:07 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C76D25C1BB;
        Tue, 12 May 2020 08:11:06 +0000 (UTC)
Date:   Tue, 12 May 2020 10:11:04 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] sfdisk: avoid unneeded empty lines with '--list-free'
Message-ID: <20200512081104.uxib26ibilpfuxjd@ws.net.home>
References: <20200511161048.12347-1-wsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511161048.12347-1-wsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, May 11, 2020 at 06:10:48PM +0200, Wolfram Sang wrote:
>  disk-utils/fdisk-list.c | 14 ++++++++------
>  disk-utils/fdisk-list.h |  2 +-
>  disk-utils/sfdisk.c     | 10 +++-------
>  3 files changed, 12 insertions(+), 14 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

