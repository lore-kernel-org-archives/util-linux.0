Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1B7C433EF
	for <util-linux@archiver.kernel.org>; Fri, 21 Jan 2022 13:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350776AbiAUN6D (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 21 Jan 2022 08:58:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350745AbiAUN6D (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 21 Jan 2022 08:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642773482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=phzInFVUi5WbCURiIyeGqxEd/hTUsgBkFVjg0LqCc84=;
        b=ZEFL8I3yTX3/xY0pzX6r/Ld5QLTpvw/FVe1RXVaB1rf39F9JCz1npobPR6seXGz3jaqmVl
        ggqadiuLEPDeGgTKorGvrSewXUMOdi+kptE4EawYxTFTnq7MddWH26KEc6Cr6TtAHPTPM8
        LBjJU7HNv0KZnRuUrQY7eJzXF56l4jw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-5bKi6PBUNSq4bz7x1fOVgQ-1; Fri, 21 Jan 2022 08:57:59 -0500
X-MC-Unique: 5bKi6PBUNSq4bz7x1fOVgQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76599760C7;
        Fri, 21 Jan 2022 13:57:57 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C5A87E21A;
        Fri, 21 Jan 2022 13:57:55 +0000 (UTC)
Date:   Fri, 21 Jan 2022 14:57:52 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc:     util-linux@vger.kernel.org, jkosina@suse.cz, kurt@garloff.de,
        den@openvz.org, msuchanek@suse.de, efremov@linux.com
Subject: Re: [PATCH 2/2] libblkid: reopen floppy without O_NONBLOCK
Message-ID: <20220121135752.u3ff76hvev4y5c32@ws.net.home>
References: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
 <20211209141233.3774937-3-vsementsov@virtuozzo.com>
 <20220121101840.qaydaibbcphc4fja@ws.net.home>
 <867dfb54-accf-89e3-b2b3-1cec04e1c418@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867dfb54-accf-89e3-b2b3-1cec04e1c418@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Jan 21, 2022 at 03:13:00PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> 21.01.2022 13:18, Karel Zak wrote:
> >   I'd like to call stat() before FDGETFDCSTAT ioctl to make sure that
> >   the file descriptor is really block-device etc. (libmount supports
> >   regular files too)
> > 
> 
> Sounds good. I see, fstat() is called in blkid_probe_set_device(),
> so you just need to move your code below fstat() call.

That's the plan. Updated in git tree.

  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

