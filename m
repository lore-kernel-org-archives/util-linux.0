Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAF1C433F5
	for <util-linux@archiver.kernel.org>; Fri, 21 Jan 2022 10:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349729AbiAUKSu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 21 Jan 2022 05:18:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28066 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238159AbiAUKSu (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 21 Jan 2022 05:18:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642760329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vpJ++5SP5cEnc0GwjOUJZ9/7dyHe5Wr2M95UHp4xKXM=;
        b=QkgBag8RKxFTmhiu+onAzwwBRgAYnmXC+8AcBw0+39f0rdOfYAmQtAe8C1tvpMJM50iU0Y
        Q+HS/LQVNN3csvzvnA3UbFDrikKcYTDhHzuiR0XQTWV85w8zwuuMvwtf6yM1WAbykubCkU
        Sg1WGEP4ylcu37rsfqpS5ZM34mi0Kb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-fvPHy0kkO7SZa1K9o__hJQ-1; Fri, 21 Jan 2022 05:18:47 -0500
X-MC-Unique: fvPHy0kkO7SZa1K9o__hJQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C68D2F26;
        Fri, 21 Jan 2022 10:18:45 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C87C4EC91;
        Fri, 21 Jan 2022 10:18:43 +0000 (UTC)
Date:   Fri, 21 Jan 2022 11:18:40 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc:     util-linux@vger.kernel.org, jkosina@suse.cz, kurt@garloff.de,
        den@openvz.org, msuchanek@suse.de, efremov@linux.com
Subject: Re: [PATCH 2/2] libblkid: reopen floppy without O_NONBLOCK
Message-ID: <20220121101840.qaydaibbcphc4fja@ws.net.home>
References: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
 <20211209141233.3774937-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209141233.3774937-3-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Dec 09, 2021 at 03:12:33PM +0100, Vladimir Sementsov-Ogievskiy wrote:
> Since c7e9d0020361f4308a70cdfd6d5335e273eb8717
> "Revert "floppy: reintroduce O_NDELAY fix"" commit in linux kernel,
> floppy drive works bad when opened with O_NONBLOCK: first read may
> fail. This cause probing fail and leave error messages in dmesg. So, if
> we detect that openedfd is floppy, reopen it without O_NONBLOCK flag.

 I'd like to a little bit optimize the code in libblkid and reduce
 number of situations when we call FDGETFDCSTAT ioctl.

 If I good understand the problem is read() with O_NONBLOCK, right?

 I'd like to call stat() before FDGETFDCSTAT ioctl to make sure that
 the file descriptor is really block-device etc. (libmount supports
 regular files too)

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

