Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDCCC433EF
	for <util-linux@archiver.kernel.org>; Mon,  3 Jan 2022 08:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiACInY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 3 Jan 2022 03:43:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53983 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232169AbiACInX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 3 Jan 2022 03:43:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641199403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fiaz3eIrL1bUgs2MmoEr5VVWuWbZP0yUbO2WHN/6QdE=;
        b=JrGp9CrbUv4c/StPRtfEfZR6BQ0CxEVniV6ckIDpwxLSD1WC5f/CjermBLsAU/zOJFPTLl
        0GhEI+Np9HFIKCxQmW+YGObN5Ht8yhXxlTox4hgmzfq0jxnOI+XxNGlJLqq+f7eE8VNF2q
        3HTNRG+HMna0iB6Q3PAo9EiYb6HJZ+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-eqVJ7Hd5MEqLL6syqT38rQ-1; Mon, 03 Jan 2022 03:43:18 -0500
X-MC-Unique: eqVJ7Hd5MEqLL6syqT38rQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FEC51926DA0;
        Mon,  3 Jan 2022 08:43:16 +0000 (UTC)
Received: from ws.net.home (ovpn-112-15.ams2.redhat.com [10.36.112.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1582F7D533;
        Mon,  3 Jan 2022 08:43:13 +0000 (UTC)
Date:   Mon, 3 Jan 2022 09:43:11 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc:     util-linux@vger.kernel.org, jkosina@suse.cz, kurt@garloff.de,
        den@openvz.org, msuchanek@suse.de, efremov@linux.com
Subject: Re: [PATCH 2/2] libblkid: reopen floppy without O_NONBLOCK
Message-ID: <20220103084311.beuxa6fcjtzn74a3@ws.net.home>
References: <20211209141233.3774937-1-vsementsov@virtuozzo.com>
 <20211209141233.3774937-3-vsementsov@virtuozzo.com>
 <20211214120349.kntr7gza5flma5tc@ws.net.home>
 <a378a167-fd41-f74d-1b0d-b997b82df05c@virtuozzo.com>
 <20211215125605.4tg7ugdnlbb3i3v7@ws.net.home>
 <9dc07586-5471-ee5e-fae4-e177ceb114f4@virtuozzo.com>
 <23719c29-9668-1edc-e60c-a30bd821c7fa@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23719c29-9668-1edc-e60c-a30bd821c7fa@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Dec 24, 2021 at 06:31:39PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > > > The same is probably in many other places (mkfs-like programs, etc.).
> > > > > 
> > > > > What do you think?
> > > > > 
> > > > 
> > > > Maybe be we can get filename from fd reading it from /proc, then do
> > > > open() and than dup() to old fd.. But that's even more dirty to do
> > > > in a library call.
> > > 
> > > Yes, re-open() sounds like a possible way.
> > > 
> > > The dup() is not necessary. The library already support private FD for
> > > probing. See blkid_new_probe_from_filename() and BLKID_FL_PRIVATE_FD.
> > > 
> > > It's also often used when the library probe whole-disk device (when you
> > > probe sda1 than it also reads data from partition table on sda). In
> > > this case it opens a separate FD.
> > > 
> > > It's for floppies (0.001% of all cases). IMHO re-open is good enough and
> > > better than force changes in all applications :-)> I'll try to prepare a patch and ask you for test/review. Thanks!
> > > 
> > 
> > Great!
> > 
> 
> Hi! Are you working on this? If not I can try to make a v2.


I had a vacation in the last 14 days; nothing is done. Go ahead if you   
have time for this task. I'm going to work on something else this
week.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

