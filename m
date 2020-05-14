Return-Path: <SRS0=ViFG=64=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81990C433E0
	for <util-linux@archiver.kernel.org>; Thu, 14 May 2020 13:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FC62205CB
	for <util-linux@archiver.kernel.org>; Thu, 14 May 2020 13:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CCAid1mR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbgENN4S (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 14 May 2020 09:56:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60869 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726050AbgENN4R (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 14 May 2020 09:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589464577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MN679wPxm/l0QZRa5IiTeTGE8zUbUsG59oeiyebzXCo=;
        b=CCAid1mRqtETESmdhslPQqFEx+yKbr65DkIMbjRxB2nbfuGak9mMkrSjMME3PMI5cku+EA
        +bEmAyp7XAlT+REu3HXts5CXfxXifidyI6BvpMJKc7s6wjAVNGe/G/khPpkMT/qlhtOvnC
        qyW6SRtszu5hpHQ1MJHRKKTiSBcOrgY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-C-VNa-2NPhGjJhdU62xmuQ-1; Thu, 14 May 2020 09:56:08 -0400
X-MC-Unique: C-VNa-2NPhGjJhdU62xmuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59E10801503;
        Thu, 14 May 2020 13:56:07 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7ACBF60C05;
        Thu, 14 May 2020 13:56:06 +0000 (UTC)
Date:   Thu, 14 May 2020 15:56:03 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Ritika Srivastava <ritika.srivastava@oracle.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 1/1] lsblk: Ignore hidden devices
Message-ID: <20200514135603.oti23br45cw3kzpu@ws.net.home>
References: <1589407570-25740-1-git-send-email-ritika.srivastava@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589407570-25740-1-git-send-email-ritika.srivastava@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, May 13, 2020 at 03:06:10PM -0700, Ritika Srivastava wrote:
> Following patch was added
> https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=d51f05bfecb299a830897106460bf395be440c0a
> Which made lsblk read from /sys/block/<nvmeNcXnY>/device/dev
> which do exist for nvmeNcXnY devices.
> 
> After the above patch, the unknown error goes away.
> However, another error is encountered in the very next step.
> 
> nvme1c1n1: failed to initialize sysfs handler
> 
> This is because lsblk looks for /sys/dev/block/242:1
> (nvmeNcXnY major:minor) pathname which usually exists for other
> block devices but not for the nvmeNcXnY devices as they are hidden.

It's interesting that /sys could be inconsistent in
/sys/dev/block/ and /sys/block/.

Applied, thanks.

I did a small change to the patch to make it usable with /sys dumps.
https://github.com/karelzak/util-linux/commit/c8487d854ba5cf5bfcae78d8e5af5587e7622351

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

