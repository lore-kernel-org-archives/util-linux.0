Return-Path: <SRS0=QCn3=6Z=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D822C47255
	for <util-linux@archiver.kernel.org>; Mon, 11 May 2020 09:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29310206F9
	for <util-linux@archiver.kernel.org>; Mon, 11 May 2020 09:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCZTbpie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgEKJpg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 11 May 2020 05:45:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54729 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728209AbgEKJpg (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 11 May 2020 05:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589190335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vfHXA+0CFmwGCqihjnJSvlOY0MZHS5yydBiKmSkKXNo=;
        b=QCZTbpieX/O/Jby+bFOua63RNo1juq/ccFo6VNrISIMRBeDgWr3inFsfXw+6N4jaFI31HJ
        TtfOuYi5XzF/TW36vgLHNoRf5IRkBvFJA4A9wdeXBINX8x8s6Zouzi1XldDDau+JO2/nKF
        BIjh9x3Y0V7wlKUQgTzdoqS+pSw/2UY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-D_9jRaRHM6KHiz-YB-oVIg-1; Mon, 11 May 2020 05:45:33 -0400
X-MC-Unique: D_9jRaRHM6KHiz-YB-oVIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D26881B18BC5;
        Mon, 11 May 2020 09:45:32 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11B626606E;
        Mon, 11 May 2020 09:45:31 +0000 (UTC)
Date:   Mon, 11 May 2020 11:45:29 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] (s)fdisk: avoid unneeded empty lines with '--list'
Message-ID: <20200511094529.yfdnyjyjoj6hhcvv@ws.net.home>
References: <20200506103921.2689-1-wsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506103921.2689-1-wsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, May 06, 2020 at 12:39:21PM +0200, Wolfram Sang wrote:
>  disk-utils/fdisk-list.c | 14 ++++++++------
>  disk-utils/fdisk-list.h |  2 +-
>  disk-utils/fdisk.c      |  9 ++-------
>  disk-utils/sfdisk.c     | 10 +++-------
>  4 files changed, 14 insertions(+), 21 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

