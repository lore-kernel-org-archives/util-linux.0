Return-Path: <SRS0=LPHN=6O=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EE2C8300A
	for <util-linux@archiver.kernel.org>; Thu, 30 Apr 2020 09:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B406B20787
	for <util-linux@archiver.kernel.org>; Thu, 30 Apr 2020 09:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/mQboX1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgD3JG4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:06:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30538 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726420AbgD3JGz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 30 Apr 2020 05:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588237614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=rO18mZn+H5d78Up9MhkoI3Kur5wiaGYoCvuzH+94OUI=;
        b=X/mQboX1Pmm9lm7IaBAK/JftI3tOnEKBigLxHOd/yP/OAgPDw/kGgJ3BI/VMIOlgu+CmFL
        kpsJy8Hn1LYGT3VDA8OWm5W/VOzOQjA8yQ0VMlInSi1f7P4JfwyTEiRVe/lZtLatHhO2Ja
        XnYRqWJpEvocnnJU9Si7k665bydeO7k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-pfGhBr3rMjyRTuIN265oXg-1; Thu, 30 Apr 2020 05:06:49 -0400
X-MC-Unique: pfGhBr3rMjyRTuIN265oXg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E635107ACCD;
        Thu, 30 Apr 2020 09:06:48 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 391C510013BD;
        Thu, 30 Apr 2020 09:06:46 +0000 (UTC)
Date:   Thu, 30 Apr 2020 11:06:44 +0200
From:   Karel Zak <kzak@redhat.com>
To:     michael-dev@fami-braun.de, Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     util-linux@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] Fix PID namespace persistence
Message-ID: <20200430090644.ltkx37w3ap2h27ar@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415211653.5455-1-michael-dev@fami-braun.de>
 <CAHO5Pa0OkdnTYRkzEsCV0=kAJZXDaSnVriEUAq3Zt-6csP3wFQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Apr 15, 2020 at 11:16:53PM +0200, michael-dev@fami-braun.de wrote:
>  sys-utils/unshare.c | 66 ++++++++++++++++++++++++++-------------------
>  1 file changed, 38 insertions(+), 28 deletions(-)

Applied. I did small changes to the patch, see:
https://github.com/karelzak/util-linux/commit/0d5260b66c5581c8a5855a5f49e298e48e8baf82


On Fri, Apr 24, 2020 at 11:21:15AM +0200, Michael Kerrisk wrote:
> @Zak: an analogous fix is required for time namespaces.

A have added ns/time_for_children to the commit.

Thanks guys!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

