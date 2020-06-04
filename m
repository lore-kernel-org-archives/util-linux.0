Return-Path: <SRS0=aW19=7R=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42E4C433E0
	for <util-linux@archiver.kernel.org>; Thu,  4 Jun 2020 09:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F5F2067B
	for <util-linux@archiver.kernel.org>; Thu,  4 Jun 2020 09:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E7EyRvQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgFDJfS (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:35:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41072 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726299AbgFDJfS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 4 Jun 2020 05:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591263317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CpHq6SEfzhknAKu4XcsWEX8pbs2b96C4OV0A6PIf2Ck=;
        b=E7EyRvQGVR47roy//kPTDz67YipJrQIb45a5JZ5Vh7bkO0WC9h7L3UgTG0rqxCv66POEKM
        yCuhoxLdlaz76gl+Re6TJs5bDE+IcjUpGOUx2hNhpQYsjt/7bLXxg/jJGGJe50sfeEvNjI
        IqCCnOw0kx7k2ctT8Atpj0ITyWg3RFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-LSTPuNUwMROSDsyncgMpXg-1; Thu, 04 Jun 2020 05:35:15 -0400
X-MC-Unique: LSTPuNUwMROSDsyncgMpXg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94A6E107ACCA;
        Thu,  4 Jun 2020 09:35:14 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D75B310013C0;
        Thu,  4 Jun 2020 09:35:13 +0000 (UTC)
Date:   Thu, 4 Jun 2020 11:35:11 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH util-linux] dmesg: adjust timestamps according to
 suspended time
Message-ID: <20200604093511.odabuy6ald7bkpbw@ws.net.home>
References: <159103929487.199093.15757669576783156290.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159103929487.199093.15757669576783156290.stgit@buzz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Jun 01, 2020 at 10:21:34PM +0300, Konstantin Khlebnikov wrote:
>  include/monotonic.h |    2 ++
>  lib/monotonic.c     |   12 ++++++++++++
>  sys-utils/dmesg.1   |    2 ++
>  sys-utils/dmesg.c   |   22 +++++++++++++++++-----
>  4 files changed, 33 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

