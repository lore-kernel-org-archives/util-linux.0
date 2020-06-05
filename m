Return-Path: <SRS0=WsHy=7S=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2AFC433E0
	for <util-linux@archiver.kernel.org>; Fri,  5 Jun 2020 08:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 045EA207D5
	for <util-linux@archiver.kernel.org>; Fri,  5 Jun 2020 08:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/3d8wqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgFEIGj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:06:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37477 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726134AbgFEIGj (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 5 Jun 2020 04:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591344398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q9BVt6+/kjJ23lN6rDM5sBYxAMZYuakToZRiM0BsFeI=;
        b=i/3d8wqbmuEa3JJcUbOspcSMo3n5gKwCjaHvZg35lWYlb4q+ml/kqCqi2OsdvhDTDtJfSR
        FGBizMpc1sgd+BzeHOtfNf7sLp3nPvdvwSZ3nzY8R92oZ0fKs3YckFJyjgDo3grdcihMJd
        vqZJybHlmVtJPBcLe9L/mv1geGurl8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-E_UrJkoNNRmDLoUjt5nlGg-1; Fri, 05 Jun 2020 04:06:36 -0400
X-MC-Unique: E_UrJkoNNRmDLoUjt5nlGg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7270287307A;
        Fri,  5 Jun 2020 08:06:35 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 75A1D19C58;
        Fri,  5 Jun 2020 08:06:34 +0000 (UTC)
Date:   Fri, 5 Jun 2020 10:06:31 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org, Martin Wilck <martin.wilck@suse.com>
Subject: Re: [PATCH] blockdev: Don't fail on missing start sector
Message-ID: <20200605080631.uqvhmvwsddtzdovz@ws.net.home>
References: <a7a4f974-8a32-efb3-0ba3-a25e77145946@suse.cz>
 <20200603151622.bypdu5k5r22cuq6z@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603151622.bypdu5k5r22cuq6z@ws.net.home>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Jun 03, 2020 at 05:16:26PM +0200, Karel Zak wrote:
> Stanislav, can you re-send the patch by git-send-email or create PR on
> git-hub? Please. It seems the patch is broken by your/my email client (or
> so) :-(

OK, applied manually. You don't need to resend it :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

