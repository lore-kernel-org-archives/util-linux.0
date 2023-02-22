Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5521CC61DA4
	for <util-linux@archiver.kernel.org>; Wed, 22 Feb 2023 20:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjBVUrW (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 22 Feb 2023 15:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjBVUrS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 22 Feb 2023 15:47:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16183BD99
        for <util-linux@vger.kernel.org>; Wed, 22 Feb 2023 12:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677098793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=reVCmcTNv7HI8TW1RTnDzw8sfefR7A/HvUDzF6aikcY=;
        b=B6YZKFU6VZSZuIWLPglks7QOroJ6MsDmIpmzaOdei+0cZelKm4jgFAxdQmZIc4AdG7wIoK
        fr+iE7pdFMG3fMuDKaEKIHXf/MZINDJhxqJUIDCebrZGkdJn42miHcgRPPOuDYtYGsyxsS
        0xedqEdG6uI4leEmof3eiPBbPHrPeEI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-TChOq4MyPSiCPuA91gq7AA-1; Wed, 22 Feb 2023 15:46:29 -0500
X-MC-Unique: TChOq4MyPSiCPuA91gq7AA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F5621819441
        for <util-linux@vger.kernel.org>; Wed, 22 Feb 2023 20:46:25 +0000 (UTC)
Received: from ws.net.home (ovpn-192-20.brq.redhat.com [10.40.192.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 98EC7492B05;
        Wed, 22 Feb 2023 20:46:24 +0000 (UTC)
Date:   Wed, 22 Feb 2023 21:46:22 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Thomas Haller <thaller@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/1] lib/randutils: drop unnecessary fcntl() in
 random_get_fd()
Message-ID: <20230222204622.6ac45lugaizc5jbt@ws.net.home>
References: <20230222153203.1506570-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222153203.1506570-1-thaller@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Feb 22, 2023 at 04:32:03PM +0100, Thomas Haller wrote:
> This was a left over from commit b1fa3e2234fa ('lib: use O_CLOEXEC in
> libcommon').

An excellent example of using sed(1) (or so) to modify code without
reading context is a bad idea.

>  lib/randutils.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

