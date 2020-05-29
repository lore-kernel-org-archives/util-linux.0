Return-Path: <SRS0=/i5r=7L=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786B5C433E0
	for <util-linux@archiver.kernel.org>; Fri, 29 May 2020 12:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A80D20721
	for <util-linux@archiver.kernel.org>; Fri, 29 May 2020 12:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goUPIal2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgE2Mhe (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 29 May 2020 08:37:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58995 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726282AbgE2Mhe (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 29 May 2020 08:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590755853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o64b6mL7v5XvL4nLjEQStr23ntCtR5EUyFuRqzV+GZw=;
        b=goUPIal2guceAtFDdKSjATRW+9z9q2Bw8qBj2cSPKk1J1kFeSGmwzs5Jh+VaGJL35ET6X4
        ZM2OAYj71sqnGgnFd0FhE1OQHUiS0Z45cVPAeHv16lw4fyJ5x0gDdD54lncBZmmVG/88IS
        aG51fiv3l3OfF8CsuQ0AzyMoWM53H8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-jrZqWLwSMl6s8mukEV7VxA-1; Fri, 29 May 2020 08:37:30 -0400
X-MC-Unique: jrZqWLwSMl6s8mukEV7VxA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10A9E835B40;
        Fri, 29 May 2020 12:37:29 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F9EF1001B07;
        Fri, 29 May 2020 12:37:28 +0000 (UTC)
Date:   Fri, 29 May 2020 14:37:25 +0200
From:   Karel Zak <kzak@redhat.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] Manual pages: wording fix: "another" ==> "other"
Message-ID: <20200529123725.mcmbr5dsq6tgzdp7@ws.net.home>
References: <20200529122048.1052198-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529122048.1052198-1-mtk.manpages@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, May 29, 2020 at 02:20:47PM +0200, Michael Kerrisk (man-pages) wrote:
> surprisingly confusing for native speakers, especially those
> unaware that in some other languages, "another" and "other" can be
> expressed with the same word.

"Gammarly" firefox module highlights this my mistake pretty often  :-)

>  disk-utils/fdisk.8        | 2 +-
>  disk-utils/sfdisk.8       | 4 ++--
>  login-utils/runuser.1     | 2 +-
>  login-utils/su.1          | 2 +-
>  misc-utils/blkid.8        | 2 +-
>  sys-utils/lsmem.1         | 3 ++-
>  sys-utils/mount.8         | 9 +++++----
>  sys-utils/umount.8        | 6 +++---
>  term-utils/scriptreplay.1 | 2 +-
>  text-utils/column.1       | 2 +-
>  10 files changed, 18 insertions(+), 16 deletions(-)

 All 2 patches applied. Thank.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

