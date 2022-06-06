Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D5BCCA481
	for <util-linux@archiver.kernel.org>; Mon,  6 Jun 2022 10:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiFFKZ1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 6 Jun 2022 06:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbiFFKYy (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 6 Jun 2022 06:24:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D50124948
        for <util-linux@vger.kernel.org>; Mon,  6 Jun 2022 03:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654511091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qXeNxDi0mGecSB/68q6S4yhWWL79nvHvrMrA2GWcp3U=;
        b=hkyBGfWFtgFChQEYnkXMTI24wXoQ+wOfAU8nhnm2+OhOYuTYRjpAKfzG9sUiGvGJD77IDN
        xIQd9L1Fcesf7dWMt2925qp8orFpuZNVIIVG+D7YWwTSlA/bXJWoZqOSrrCPoVI2LFUMHW
        86y9yYpogaTyr5OQzNAuAYkqX0SIh4Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-er7dW7YiOi6gc2P-7DuBKQ-1; Mon, 06 Jun 2022 06:24:50 -0400
X-MC-Unique: er7dW7YiOi6gc2P-7DuBKQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0A613C0D841;
        Mon,  6 Jun 2022 10:24:49 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03E50492C3B;
        Mon,  6 Jun 2022 10:24:48 +0000 (UTC)
Date:   Mon, 6 Jun 2022 12:24:46 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     Nathan Sharp <nwsharp@live.com>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] pipesz: use native PAGE_SIZE in tests
Message-ID: <20220606102446.3zdh5ljmndyzr4hi@ws.net.home>
References: <CADxRZqzipCFaFFAs-o=FDA_g=9NmrqzieXaYtWwbGCCXDeiM5g@mail.gmail.com>
 <SN6PR04MB39834AB02ACBCA91B949F821C2A09@SN6PR04MB3983.namprd04.prod.outlook.com>
 <CADxRZqxFetP=SczfzZtpx_G1OgseFtpLLQwDhLhCJ_NMGRGhUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADxRZqxFetP=SczfzZtpx_G1OgseFtpLLQwDhLhCJ_NMGRGhUg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Jun 04, 2022 at 11:28:08AM +0300, Anatoly Pugachev wrote:
> On Sat, Jun 4, 2022 at 5:00 AM Nathan Sharp <nwsharp@live.com> wrote:
> > Reported-by: Anatoly Pugachev <matorola@gmail.com>
> > --- a/tests/ts/misc/pipesz
> > +++ b/tests/ts/misc/pipesz
> > @@ -18,6 +18,10 @@ TS_DESC="pipesz"
> >  . $TS_TOPDIR/functions.sh
> >  ts_init "$*"
> >
> > +set -o pipefail
> > +
> > +DEFAULT_PIPE_SIZE=$(($(getconf PAGE_SIZE) * 16))
> 
> DEFAULT_PIPE_SIZE=$(($($TS_HELPER_SYSINFO pagesize) * 16))
> 
> to be consistent with other tests

 Fixed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

