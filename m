Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD06DC433E0
	for <util-linux@archiver.kernel.org>; Wed, 10 Mar 2021 15:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C7964F4B
	for <util-linux@archiver.kernel.org>; Wed, 10 Mar 2021 15:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhCJPL3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Mar 2021 10:11:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41661 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232251AbhCJPLO (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 10 Mar 2021 10:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615389073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PuusyM+id2ULlvh0G3ks5S5TV2CNZnU3pv205Nq4sbE=;
        b=Ao6UsMhbEG+6Wv+7RcW7joaU0JL4vpZfunxAL0hX6FHLA0Eg+Uyp9Y6Yo2DT5tWV/uaWv9
        rRpddgvK8Q8VHNK72+BzUDEXL7lOjGlFRG/963xfQYOiYUfZSVuLiRbfkLdxbGRh/oxcP0
        Hy2I6y+ZvM5K9YSQ38rBjS8CpuaOdX8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-ybumrSrnMeyTf8bFrNESHg-1; Wed, 10 Mar 2021 10:11:11 -0500
X-MC-Unique: ybumrSrnMeyTf8bFrNESHg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F09F41005D4A;
        Wed, 10 Mar 2021 15:11:09 +0000 (UTC)
Received: from ws.net.home (ovpn-113-171.ams2.redhat.com [10.36.113.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0D5010013C1;
        Wed, 10 Mar 2021 15:11:08 +0000 (UTC)
Date:   Wed, 10 Mar 2021 16:11:06 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: Please include blkzone: add capacity field to zone report in
 next dot release
Message-ID: <20210310151106.hqilnhitaaan77wi@ws.net.home>
References: <PH0PR04MB741640EEABC8A25E6EE248399B919@PH0PR04MB7416.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR04MB741640EEABC8A25E6EE248399B919@PH0PR04MB7416.namprd04.prod.outlook.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Mar 10, 2021 at 10:47:36AM +0000, Johannes Thumshirn wrote:
> 
> I just saw you tagged 2.36.2 last month, but it doesn't include the commit
> e5ad3a6ad0b4 ("blkzone: add capacity field to zone report").

2.36.2 is already released
> Would it be possible to include it in the next dot release? The zonefs-tools
> test suite depends on this commit and it will be easier for downstreams to
> test zonefs and/or the kernel's zone append implementations with this patch.

I'm going to prepare 2.37 in the next days from the master branch
where is already the patch.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

