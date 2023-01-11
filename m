Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE98C46467
	for <util-linux@archiver.kernel.org>; Wed, 11 Jan 2023 10:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbjAKKcK (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 11 Jan 2023 05:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjAKKcI (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 11 Jan 2023 05:32:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13E726E5
        for <util-linux@vger.kernel.org>; Wed, 11 Jan 2023 02:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673433083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=On6w3uOQ8he95mudwjh3Hmeyg49dgxFxGjGHoF5ER3g=;
        b=FThnN38In3VhbcvF5pnSpu+uddWArkDF4XfwOKyDK7ZCfFGDN/WIS4fPd6m85Qt5OkaVPB
        kY2PDsPasdWLpg9/9788U400EOQhjuHMGVFo37G7/gA2TS27MZBLbfpIyhc0/z3YyUPsJw
        zoEsNaBVtr8C3EBBZiuTe77CgmI+e7w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-0DAXyQNMPRmikDLSXRt4Tw-1; Wed, 11 Jan 2023 05:31:20 -0500
X-MC-Unique: 0DAXyQNMPRmikDLSXRt4Tw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A5631C06EEA;
        Wed, 11 Jan 2023 10:31:20 +0000 (UTC)
Received: from ws.net.home (ovpn-194-37.brq.redhat.com [10.40.194.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF87B43FB6;
        Wed, 11 Jan 2023 10:31:19 +0000 (UTC)
Date:   Wed, 11 Jan 2023 11:31:17 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Chris Webb <chris@arachsys.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH v2] unshare: support --map-users=inner:outer:count as
 well as outer,inner,count
Message-ID: <20230111103117.swhwvu7xhxhrkmi5@ws.net.home>
References: <Y71vIkgFde7Zp9AI@arachsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y71vIkgFde7Zp9AI@arachsys.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jan 10, 2023 at 01:58:58PM +0000, Chris Webb wrote:
>  sys-utils/unshare.1.adoc |  8 +++++--
>  sys-utils/unshare.c      | 50 +++++++++++++---------------------------
>  2 files changed, 22 insertions(+), 36 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

