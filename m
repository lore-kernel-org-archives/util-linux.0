Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A51C4361B
	for <util-linux@archiver.kernel.org>; Tue,  8 Dec 2020 10:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D9A223A9C
	for <util-linux@archiver.kernel.org>; Tue,  8 Dec 2020 10:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgLHKKy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 8 Dec 2020 05:10:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726734AbgLHKKy (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 8 Dec 2020 05:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607422168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ogGyimCq1GrhgYK0fTnF3U1F418pQGwe3tvmWC0c+Yc=;
        b=VbEs3Lgby1DIYSP0r/8xNcxzjnnYdzfHM7FIu8GzzUZQ3R0RLkfiSqU6zOm5OrSjMtbGOC
        Y+5kWT21JNDYpEiFQSoZU1xXRsB3VSx/nUibPoWOmqypMLomlVli8OjIOy77KCqUrmXzg3
        Mcw+qT9emRr2mIc0MNicFcVdOQKpV5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-TSySUCWGNR6ZnRhLPzjAyg-1; Tue, 08 Dec 2020 05:09:17 -0500
X-MC-Unique: TSySUCWGNR6ZnRhLPzjAyg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC000800D55
        for <util-linux@vger.kernel.org>; Tue,  8 Dec 2020 10:09:16 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28E7A6091B;
        Tue,  8 Dec 2020 10:09:12 +0000 (UTC)
Date:   Tue, 8 Dec 2020 11:09:10 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Gao Xiang <hsiangkao@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid: add erofs filesystem support
Message-ID: <20201208100910.dqqh5cqihewkyetc@ws.net.home>
References: <20201205074410.2317033-1-hsiangkao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205074410.2317033-1-hsiangkao@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Sat, Dec 05, 2020 at 03:44:10PM +0800, Gao Xiang wrote:
> This patch adds support for detecting EROFS filesystem to libblkid.

Applied, thanks!

I have also added simple regression test to tests/ts/blkid/images-fs/erofs.img.xz. 

Note that it seems the current mkfs.erofs cannot set volume_name (aka LABEL)
although the filesystem superblock support it.
 

A small nitpick to mkfs.erofs, see https://github.com/hsiangkao/erofs-utils/blob/dev/mkfs/main.c#L27

The subdirectory in 

    #include <uuid/uuid.h> 

is unnecessary (or wrong), if you use 

    PKG_CHECK_MODULES([libuuid], [uuid])

than it returns the subdirectory as -I, see

    $ pkg-config --cflags uuid
    -I/usr/include/uuid 

so the correct way is

     #include <uuid.h>

with the proper PKG_CHECK_MODULES(), btw you have it without
subdirectory in configure.ac test.

The problem is that your code reads the default include file from
/usr/include/uuid/ rather the one specified by your build system.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

