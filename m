Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF91C433DB
	for <util-linux@archiver.kernel.org>; Tue,  5 Jan 2021 13:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E1522AAE
	for <util-linux@archiver.kernel.org>; Tue,  5 Jan 2021 13:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbhAENbT (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 5 Jan 2021 08:31:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726059AbhAENbT (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 5 Jan 2021 08:31:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609853393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3eWW2jcOHjY1w4HVq454t/O06+etMnsGtpzdXymouOY=;
        b=SKoS+7+NFrziLURpJrb7rxQxqEUM6Vj1Q2yrS19nO+13EWRC89beSYMZgJP3W/ko8mlcsW
        SNReDZtJ7ZHT7efNYdNZU1R25WHlPZLeBXi27E1dEjzzRxwNQQA16VygOax1EaSx2DuAHB
        j2YYxFC5p0bkj4cV9yRp0GEZvk/lTMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-YPgR0tXbM5-BI0birj29hQ-1; Tue, 05 Jan 2021 08:29:49 -0500
X-MC-Unique: YPgR0tXbM5-BI0birj29hQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6588310054FF;
        Tue,  5 Jan 2021 13:29:48 +0000 (UTC)
Received: from ws.net.home (ovpn-117-0.ams2.redhat.com [10.36.117.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AE3095D9CC;
        Tue,  5 Jan 2021 13:29:47 +0000 (UTC)
Date:   Tue, 5 Jan 2021 14:29:45 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] sys-utils: mount.8: fix a typo
Message-ID: <20210105132945.6ssrjun4ijrnpku6@ws.net.home>
References: <20201231040557.324825-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201231040557.324825-1-ebiggers@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Dec 30, 2020 at 08:05:57PM -0800, Eric Biggers wrote:
>  sys-utils/mount.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

