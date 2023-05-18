Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6122C77B7A
	for <util-linux@archiver.kernel.org>; Thu, 18 May 2023 10:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjERKYG (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 18 May 2023 06:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjERKYF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 18 May 2023 06:24:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BB619AA
        for <util-linux@vger.kernel.org>; Thu, 18 May 2023 03:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684405401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OoaE5jFK5LZwELydCrj36wk2AmKJKKUJxen4DFuue90=;
        b=J4cOyW9lNFwnRV3o8M6vEkrDNL1QTjpN+nAppelZHkbY0Gg96/Wx+H/Re08I1OSSzVQEen
        0M66yqxHILXTKijxgCbq4eI3wCpTf8DtuR/VC/dndabvY/JIV5fTv/K5gFYlwbnbA5BsHn
        hT928RgV+iiKEq9LfwaW9rFb4QIS6HM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-568-ctIo3PNWPp-647liTSj5Qg-1; Thu, 18 May 2023 06:23:20 -0400
X-MC-Unique: ctIo3PNWPp-647liTSj5Qg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5C7C867942;
        Thu, 18 May 2023 10:23:19 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.226.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D29D40C6EC4;
        Thu, 18 May 2023 10:23:18 +0000 (UTC)
Date:   Thu, 18 May 2023 12:23:16 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.39
Message-ID: <20230518102316.f6s6v6xxnicx646r@ws.net.home>
References: <20230517112242.3rubpxvxhzsc4kt2@ws.net.home>
 <20230517-mahnmal-setzen-37937c35cf78@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517-mahnmal-setzen-37937c35cf78@brauner>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, May 17, 2023 at 03:48:54PM +0200, Christian Brauner wrote:
> This is a very exciting release! There's good reason for us to be happy
> imho. This is the first release of util-linux with comprehensive support
> for the new mount api which is very exciting.

We will see how many things in libmount and kernel are not ready ;-)

> A part of that is of course the support for idmapped mounts and the
> ability to recursively change mount properties, i.e., idempotently
> change the mount properties of a whole mount tree.
> 
> It's also great to see support for disk sequence numbers via the
> BLKGETDISKSEQ ioctl and the port to util-linux to rely on

BLKGETDISKSEQ is supported in the blockdev command only.

Lennart has also idea to support it in libmount to verify devices
before the filesystem is attached to VFS. 

https://github.com/util-linux/util-linux/issues/1786

That's something we can work on in the next release.

> statx(AT_STATX_DONT_SYNC|AT_NO_AUTOMOUNT) to avoid tripping over
> automounts or hung network filesystems as we just recently discussed
> this!
> 
> Thanks for working on this and hopefully we can add the missing pieces
> of the new mount api in the coming months!

I would like to make the v2.40 development cycle shorter. The v2.39
cycle was excessively long and large.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

