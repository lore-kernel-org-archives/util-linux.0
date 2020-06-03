Return-Path: <SRS0=KLef=7Q=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DA7C433E1
	for <util-linux@archiver.kernel.org>; Wed,  3 Jun 2020 15:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49415206E6
	for <util-linux@archiver.kernel.org>; Wed,  3 Jun 2020 15:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSeCuOFx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgFCPGp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:06:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28492 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726086AbgFCPGp (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 3 Jun 2020 11:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591196804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OHYR7d2uAUrxh40F9e7WSTcCLl3yugJVAfxxEMoAyt0=;
        b=DSeCuOFxIWGAxcnUn+goPOgs2kyL0Cof29pKPKedLrYrUF8yPPftlK0RqvWJTvoRo/Twv9
        NTi2PdX53F9chxMbomShLUEVz4pgAnhpZw2jikHJD0H/fwCSHP7+5FtZnksBlkKOvC4k5a
        1mMv1HviynD6WwzQGvcJQiQEmD3CPRI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-ATmGOePOONau_tGMTkx0qA-1; Wed, 03 Jun 2020 11:06:40 -0400
X-MC-Unique: ATmGOePOONau_tGMTkx0qA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5D471883600;
        Wed,  3 Jun 2020 15:06:39 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EB6210013D5;
        Wed,  3 Jun 2020 15:06:39 +0000 (UTC)
Date:   Wed, 3 Jun 2020 17:06:36 +0200
From:   Karel Zak <kzak@redhat.com>
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] Manual pages: unshare.1: clarify that --pid=<file>
 requires --fork
Message-ID: <20200603150636.g2kwxzwqc4ml4y63@ws.net.home>
References: <20200603074057.540157-1-mtk.manpages@gmail.com>
 <20200603074057.540157-2-mtk.manpages@gmail.com>
 <CAKgNAkgLZp=t21vrcfuf9iPmHxk_tG74-_jbtOftQKpGge1dpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgNAkgLZp=t21vrcfuf9iPmHxk_tG74-_jbtOftQKpGge1dpw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Jun 03, 2020 at 12:22:46PM +0200, Michael Kerrisk (man-pages) wrote:
> > +(Creation of a persistent PID namespace will fail if the
> > +.B \-\-fork
> > +is not also specified.)
> 
> Small wording problem there... s/is/option is/

Applied & fixed, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

