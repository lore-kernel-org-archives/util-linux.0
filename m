Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67DCC433ED
	for <util-linux@archiver.kernel.org>; Tue, 18 May 2021 11:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6D46008E
	for <util-linux@archiver.kernel.org>; Tue, 18 May 2021 11:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244062AbhERLCP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 18 May 2021 07:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35175 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239147AbhERLCP (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 May 2021 07:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621335657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zvcKiBsMszrHBU6C15brZkjmQctu8mEIynN1qpYzsjo=;
        b=i8/uiK2M1VruT28WWkfC2k0y9wLXJnCrdD32c6KbIHKBEEL0LImT+/h39KpxMZpsnkA2NB
        QCkbnDXnGugAPmb5DAv8fTuvTE+1nww24YpdwOgkPhMZpKdDXwOjjbbOkXlRKB4rsoLO1l
        lGKT2lcmTohq6o76qhxPlEStJztV7RQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-RVXz0dKvNeqIwzivvUpRpA-1; Tue, 18 May 2021 07:00:55 -0400
X-MC-Unique: RVXz0dKvNeqIwzivvUpRpA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A3769F937
        for <util-linux@vger.kernel.org>; Tue, 18 May 2021 11:00:54 +0000 (UTC)
Received: from ws.net.home (ovpn-115-34.ams2.redhat.com [10.36.115.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9505F60657
        for <util-linux@vger.kernel.org>; Tue, 18 May 2021 11:00:53 +0000 (UTC)
Date:   Tue, 18 May 2021 13:00:51 +0200
From:   Karel Zak <kzak@redhat.com>
To:     util-linux@vger.kernel.org
Subject: Re: [PATCH] sulogin: ignore not existing console devices
Message-ID: <20210518110051.b2gzuuj7nssxywka@ws.net.home>
References: <YJPK1JUPtKTuMJ1J@boole.suse.de>
 <20210510145111.x5ap5raymlfoewi5@ws.net.home>
 <YKKEkSc/ryc56IJu@boole.suse.de>
 <20210517152528.GA11780@noether>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517152528.GA11780@noether>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, May 17, 2021 at 05:25:28PM +0200, Dr. Werner Fink wrote:
> The attached patch is for latest git repository

Thanks, applied to the "next" branch and it will be merged to the
"master" after v2.37 release.

>   "Having a smoking section in a restaurant is like having
>           a peeing section in a swimming pool." -- Edward Burr

 +1 ;-)

    Karel




-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

