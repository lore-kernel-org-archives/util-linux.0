Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3143BC433F5
	for <util-linux@archiver.kernel.org>; Wed,  1 Dec 2021 15:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344328AbhLAPVT (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Dec 2021 10:21:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21302 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350872AbhLAPT6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 1 Dec 2021 10:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638371797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SkbWj/d+Us7+z1Kb6j/BO/TN2sAhF/HRQNDWwJd37GM=;
        b=c3/8lWpMP2S3NdVYKWBkDmJjl/qfL+XHhUhroJ4yoWZd9AcPpIDbHDlC71gDEdvah4Z1Xt
        eSqSnrYe67G3Tsc+yJ38eoCwsXQmUveAaEmPPhXrFx/ASbr4pZ3E//HG2tYgjDN8VKIPtN
        rwVgHR5Vxz44sqOOYCxq4vpxb7esA28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-aHwXferdPsmgaJv4dvyQPQ-1; Wed, 01 Dec 2021 10:16:34 -0500
X-MC-Unique: aHwXferdPsmgaJv4dvyQPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBD32760C0;
        Wed,  1 Dec 2021 15:16:32 +0000 (UTC)
Received: from ws.net.home (ovpn-112-12.ams2.redhat.com [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8845D1972D;
        Wed,  1 Dec 2021 15:16:31 +0000 (UTC)
Date:   Wed, 1 Dec 2021 16:16:28 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Sean Anderson <seanga2@gmail.com>
Cc:     util-linux@vger.kernel.org,
        Mikhail Gusarov <dottedmag@dottedmag.net>,
        Matthew Harm Bekkema <id@mbekkema.name>,
        James Peach <jpeach@apache.org>
Subject: Re: [PATCH v2 0/6] unshare: Add support for mapping ranges of
 user/group IDs
Message-ID: <20211201151628.gy4t4nnfhk66juc2@ws.net.home>
References: <20211124182618.1801447-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124182618.1801447-1-seanga2@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Nov 24, 2021 at 01:26:12PM -0500, Sean Anderson wrote:
> Sean Anderson (6):
>   include/c: Add abs_diff macro
>   unshare: Add waitchild helper
>   unshare: Add some helpers for forking and synchronizing
>   unshare: Add options to map blocks of user/group IDs
>   unshare: Add option to automatically create user and group maps
>   unshare: Document --map-{groups,users,auto}
> 
>  include/c.h              |   8 +
>  include/pathnames.h      |   3 +
>  sys-utils/unshare.1.adoc |  32 +++
>  sys-utils/unshare.c      | 477 ++++++++++++++++++++++++++++++++++-----
>  4 files changed, 465 insertions(+), 55 deletions(-)

Applied, thanks!

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

