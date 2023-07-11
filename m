Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199F5EB64DC
	for <util-linux@archiver.kernel.org>; Tue, 11 Jul 2023 09:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjGKJxn (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 11 Jul 2023 05:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGKJxm (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 11 Jul 2023 05:53:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953F5B7
        for <util-linux@vger.kernel.org>; Tue, 11 Jul 2023 02:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689069183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wCgUYnf6moYErfuSdaxI/x+mevgj7CaJlWyCXRaNNhQ=;
        b=IOG9aJlRZaqTcvVr6KQZZNYMfVEcRyUUujuL+Qq4GiN2gkBM0LTRQm73uvxxX/ux5XvmBs
        Dtn7cvgv6FnIs9W9xVwVN4+GWeDXTPDmh8KbY4hH8xr54sPIstnr+fnSUKUI9zfQTlnhD9
        rYptfXBXZOKadcDrt2zEQmQBgoc79Yc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-nSaJmVF9Ow6b4L9YS-3pgA-1; Tue, 11 Jul 2023 05:53:02 -0400
X-MC-Unique: nSaJmVF9Ow6b4L9YS-3pgA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 181903C23100;
        Tue, 11 Jul 2023 09:53:02 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A9404CD0C1;
        Tue, 11 Jul 2023 09:53:01 +0000 (UTC)
Date:   Tue, 11 Jul 2023 11:52:59 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] lib/pager: Allow PAGER commands with options
Message-ID: <20230711095259.igt2wrdaefokihy5@ws.net.home>
References: <20230704091430.3555428-1-dsimic@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704091430.3555428-1-dsimic@manjaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Jul 04, 2023 at 11:14:28AM +0200, Dragan Simic wrote:
>  lib/pager.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

