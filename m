Return-Path: <SRS0=Ohmc=7A=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769DBC433E0
	for <util-linux@archiver.kernel.org>; Mon, 18 May 2020 11:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 442C520709
	for <util-linux@archiver.kernel.org>; Mon, 18 May 2020 11:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FuUDkY6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgERLj6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 18 May 2020 07:39:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25690 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726362AbgERLj6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 18 May 2020 07:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589801997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TKlZKY04ccrHGfM4eZc3MJDLwSGrdRB3IDe9XjYKKQI=;
        b=FuUDkY6ZKI/CjkefRoVxjfdP8z7GsR89QwxuGw+WKCSMIbxkBgHNB9f6kSD75aUgW/NPXa
        Ed6EizeGrzwe6f4lr+fkZa7ZBzDnRZ5rCqoV22ZVAEu+fvIWq3NR1BcxkJuB4f0iyttJwn
        kLHGsLcwfI6cloc41Hu0XUgkoBrH4EQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-pGxBNFW8P4mwxgI14OumHQ-1; Mon, 18 May 2020 07:39:53 -0400
X-MC-Unique: pGxBNFW8P4mwxgI14OumHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DE3E1054F8F;
        Mon, 18 May 2020 11:39:52 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E99C5D9DC;
        Mon, 18 May 2020 11:39:51 +0000 (UTC)
Date:   Mon, 18 May 2020 13:39:48 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Yannick Le Pennec <yannick.lepennec@live.fr>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix dead references to kernel documentation
Message-ID: <20200518113948.f57czituiszkxpzs@ws.net.home>
References: <DBBPR08MB55480F8E7F62EFE9323E29FA9BBB0@DBBPR08MB5548.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBBPR08MB55480F8E7F62EFE9323E29FA9BBB0@DBBPR08MB5548.eurprd08.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, May 17, 2020 at 11:13:22PM +0800, Yannick Le Pennec wrote:
>  disk-utils/fdisk.8  | 2 +-
>  sys-utils/eject.c   | 2 +-
>  sys-utils/mount.8   | 2 +-
>  sys-utils/rfkill.8  | 2 +-
>  sys-utils/tunelp.8  | 2 +-
>  sys-utils/zramctl.8 | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

