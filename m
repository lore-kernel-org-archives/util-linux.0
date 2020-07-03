Return-Path: <SRS0=BDLL=AO=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDCBC433DF
	for <util-linux@archiver.kernel.org>; Fri,  3 Jul 2020 08:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C8A206DF
	for <util-linux@archiver.kernel.org>; Fri,  3 Jul 2020 08:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V92XVjKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgGCIkt (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:40:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44571 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725648AbgGCIkt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 3 Jul 2020 04:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593765648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vaSieKrqwjoTAgPbWHf5Cjxx9IRoiJrIJMpqMeAGtnw=;
        b=V92XVjKCPhXZlFI8NuzwLeRAIhLqtlghErCKeqrbtFLBIw0dbWNXdNLvf0+cA9p4wutP83
        FjPEcxz4kun5y4qRRt+XUP6oxPznXhqom6LJ5kOML3Z3zeti/Kcdr8jkES86K6cW4Ycaq3
        LB+kHrD1KL+SClBDt5IFT5EF3F8PQmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-PU-S0H3KOPOmK7s_cXL-6A-1; Fri, 03 Jul 2020 04:40:38 -0400
X-MC-Unique: PU-S0H3KOPOmK7s_cXL-6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72CF58015CB;
        Fri,  3 Jul 2020 08:40:37 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CBE45DD63;
        Fri,  3 Jul 2020 08:40:36 +0000 (UTC)
Date:   Fri, 3 Jul 2020 10:40:33 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     util-linux@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] blkzone: add capacity field to zone report
Message-ID: <20200703084033.cl2yef6vsxjonce5@ws.net.home>
References: <20200701113326.153550-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701113326.153550-1-shinichiro.kawasaki@wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Jul 01, 2020 at 08:33:26PM +0900, Shin'ichiro Kawasaki wrote:
>  configure.ac        |  4 ++++
>  sys-utils/blkzone.8 |  1 +
>  sys-utils/blkzone.c | 20 ++++++++++++++++++--
>  3 files changed, 23 insertions(+), 2 deletions(-)

Applied to the "next" branch. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

