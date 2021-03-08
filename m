Return-Path: <SRS0=a3o7=IG=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D92C433E0
	for <util-linux@archiver.kernel.org>; Mon,  8 Mar 2021 10:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE0D60190
	for <util-linux@archiver.kernel.org>; Mon,  8 Mar 2021 10:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhCHJ7u (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 8 Mar 2021 04:59:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231524AbhCHJ7l (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 8 Mar 2021 04:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615197580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/D8ZbgjT4wQN3Cf2Sjxx/156TtPGKLs1qBUAkDUsZs=;
        b=HiFAd+/ER9HabgtkK4bNEjIJIGcg7ToVjYgAMB85OdIWvY0h2M8yoyyUuJtDfJAgEhcVDN
        QuvXiASpEp0UtWRtQdRnvch3wksg+FcbgKzsRu9vxVUIVX/Lo8nYZtHZDXpxHxG+KrU0vX
        PHHpIMk4dDY06s0xXa1i2wmQ7KrPTm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-bbgVKWqbMiK4WWNzlQm86w-1; Mon, 08 Mar 2021 04:59:38 -0500
X-MC-Unique: bbgVKWqbMiK4WWNzlQm86w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48EEA108BD06;
        Mon,  8 Mar 2021 09:59:37 +0000 (UTC)
Received: from ws.net.home (ovpn-113-171.ams2.redhat.com [10.36.113.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 965B41971E;
        Mon,  8 Mar 2021 09:59:36 +0000 (UTC)
Date:   Mon, 8 Mar 2021 10:59:33 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Dan Jacobson <jidanni@jidanni.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: Mention fdisk -l order on man page
Message-ID: <20210308095933.7fqg7q3ldllgff6m@ws.net.home>
References: <87o8fvrfpj.8.fsf@jidanni.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8fvrfpj.8.fsf@jidanni.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sun, Mar 07, 2021 at 08:05:12AM +0800, Dan Jacobson wrote:
> OK, maybe it is just reading in physical disk/partition/device order
> always. OK, mention that on the man page.

It's in order how kernel listens it in /proc/partitionts. I have info
about it to the man page.

Thanks for your report.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

