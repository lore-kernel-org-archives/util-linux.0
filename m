Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A2EC433E0
	for <util-linux@archiver.kernel.org>; Tue,  5 Jan 2021 13:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26DC225AC
	for <util-linux@archiver.kernel.org>; Tue,  5 Jan 2021 13:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbhAENaw (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 5 Jan 2021 08:30:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726059AbhAENaw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 5 Jan 2021 08:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609853366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j1FijiReNYy5rHx/OGsOjaVVNxxKWSrZ0tZTwznpMJo=;
        b=Vk9jmjE22LnJRiMp3zOajCtQSeU9cP3ebrp7mXfqbzR0fhjQ4XvASOV0NefYDjB9f82/uL
        Jo4JBBmjdfeq1BwCbD+bfQYFkIvvFWqKTFEI5whN/60XiYV6TyvQ428iUjAaVpR6xaWWMT
        ViN4kZ5j62TV6Sf8v3/+2y3OJgmhR14=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-tdD_4ofjPBGex5YNqeaCIg-1; Tue, 05 Jan 2021 08:29:23 -0500
X-MC-Unique: tdD_4ofjPBGex5YNqeaCIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B14F3107ACF5;
        Tue,  5 Jan 2021 13:29:22 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3E9F6F957;
        Tue,  5 Jan 2021 13:29:21 +0000 (UTC)
Date:   Tue, 5 Jan 2021 14:29:19 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/1] fstab.5: NTFS and FAT volume IDs use upper case
Message-ID: <20210105132919.6bs5i25bhnh5alll@ws.net.home>
References: <20201231003254.56902-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201231003254.56902-1-xypron.glpk@gmx.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Dec 31, 2020 at 01:32:54AM +0100, Heinrich Schuchardt wrote:
>  sys-utils/fstab.5 | 2 ++
>  1 file changed, 2 insertions(+)

Good point. Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

