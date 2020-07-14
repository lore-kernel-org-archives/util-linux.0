Return-Path: <SRS0=vFYQ=AZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C2EC433E0
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 08:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7635F20771
	for <util-linux@archiver.kernel.org>; Tue, 14 Jul 2020 08:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7GSUA2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgGNIu3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:50:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32776 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725820AbgGNIu2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 14 Jul 2020 04:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594716627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GP2oo/oSTNCB23fRVq3N3NgDlsykYJsLEF4cZm18S34=;
        b=f7GSUA2RRksWtkLTjUR8ZkRYTZRUuNZFcx/2xmOgoo9BTf2nkqkn5GjIVdKz7ZvIXQMV4h
        y5Xc1g6w4ruIZB8aEI2eqA2DZ1g0cTCPVadphkkkwMECwQLmdIWV5wtQlpiXW3u8naryI7
        1dpSHN+wDYCD5TVLBh04xiO0j3v4Sck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-zwmC_L7dMTKqdXowek1NsA-1; Tue, 14 Jul 2020 04:50:25 -0400
X-MC-Unique: zwmC_L7dMTKqdXowek1NsA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 313C3C7465;
        Tue, 14 Jul 2020 08:50:24 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C68B5D9DC;
        Tue, 14 Jul 2020 08:50:23 +0000 (UTC)
Date:   Tue, 14 Jul 2020 10:50:20 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] Subject: docs: disk-utils: change "allows to <verb>" to
 "allows <verb>ing"
Message-ID: <20200714085020.knvec3zpj4a2l6pk@ws.net.home>
References: <20200710013909.GA2922@rhi.hi.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710013909.GA2922@rhi.hi.is>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jul 10, 2020 at 01:39:09AM +0000, Bjarni Ingi Gislason wrote:
>  disk-utils/fdisk.8     | 2 +-
>  disk-utils/sfdisk.8    | 6 +++---
>  disk-utils/swaplabel.8 | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

