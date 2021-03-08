Return-Path: <SRS0=a3o7=IG=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3573FC43381
	for <util-linux@archiver.kernel.org>; Mon,  8 Mar 2021 11:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5BFA651DE
	for <util-linux@archiver.kernel.org>; Mon,  8 Mar 2021 11:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhCHLWZ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 8 Mar 2021 06:22:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231965AbhCHLWJ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 8 Mar 2021 06:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615202528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WT+NVe/OibrcUcq4pO2xWwKbyu0AIfPQDb1yBmPVnH8=;
        b=QP8G1nbdp3X9C7QvVUDNC0wo1aqXf2W/Qzrqa534elbDx54Sk0IJmVH6rTFYnhQVm368zx
        lmF1uJBeYXP27PPDWyKivkHX1Lq5/o2MPejxIxk48yMFlAyhbtOD/1nI9KGpdJ66smtD9j
        +6B14LsLbVl9B9cUmYs218sCDMCNQx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-M54L2RdbNH6nCxt1Yrg7Bw-1; Mon, 08 Mar 2021 06:22:04 -0500
X-MC-Unique: M54L2RdbNH6nCxt1Yrg7Bw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18B6E1084C95;
        Mon,  8 Mar 2021 11:22:03 +0000 (UTC)
Received: from ws.net.home (ovpn-113-171.ams2.redhat.com [10.36.113.171])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2CE7F19C79;
        Mon,  8 Mar 2021 11:22:02 +0000 (UTC)
Date:   Mon, 8 Mar 2021 12:21:59 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Bruce Dubbs <bruce.dubbs@gmail.com>
Cc:     Util-Linux <util-linux@vger.kernel.org>,
        J William Piggott <elseifthen@gmx.com>
Subject: Re: Suggested changes to util-linux for FHS compliance.
Message-ID: <20210308112159.yblk5ucy6uxahlho@ws.net.home>
References: <cc08c08e-81d9-f3c7-ce8b-43a27bfe1c72@gmail.com>
 <20210215091625.jzaf6ephntdwmi5w@ws.net.home>
 <20210219113009.mav3dis3qzofru4c@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219113009.mav3dis3qzofru4c@ws.net.home>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Feb 19, 2021 at 12:30:12PM +0100, Karel Zak wrote:
> On Mon, Feb 15, 2021 at 10:16:30AM +0100, Karel Zak wrote:
> > On Fri, Feb 12, 2021 at 11:04:59AM -0600, Bruce Dubbs wrote:
> > > I don't recall if this has come up before, but I suggest a couple of changes
> > > to the default util-linux build configuuration:
> > > 
> > > 1. Change the default ADJTIME_PATH to be /var/lib/hwclock/adjtime
> > 
> > Good idea. I'll do that.
> 
> Hmm... I remembered now that we have in our TODO:
> 
>  hwclock
>  ------
>  - use /var/lib/hwclock/drift to store hw-clock drift numbers.
>  - use /etc/adjtime as read-only for UTC/LOCAL information only
>  - the /var/lib/hwclock/drift should be implemented backwardly compatible,
>    it means use the file only if exists, otherwise follow /etc/adjtime
> 
> so maybe the best would be to keep ADJTIME_PATH=/etc/adjtime and use
> it as read-only and use ${localstatedir}/lib/hwclock/drift for the
> rest.
> 
> Note that ADJTIME_PATH is used by more utils, like rtcwake or systemd,
> so move it is not so easy.

OK, I have implemented it, but frankly, I'm not sure about it ;-) 
I have added William to CC:, maybe he will come with comments.  
       
See https://github.com/karelzak/util-linux/tree/topic/hwclock-drift-file
branch.                                                    
       
The idea is to keep /etc/adjtime as a source for UTC/LOCAL flag, but   
hwclock drift info (which we need to update occasionally) move to    
/var/lib/hwclock/drift. The /etc/adjtime is de-facto standard and
move it means that 3rd party utils will have no way how to determine 
hwclock UTC/LOCAL mode.
       
Both files use "adjtime" file format to make it simple to convert
from one to another.                                         
       
The change should be backwardly compatible. If you do not have /var/lib/hwclock/drift 
then it falls back to /etc/adjtime.                                  
       
I'm not sure if this is not over-engineering. Maybe the current
solution is good enough, and all we need is to make it more
use-friendly to set ADJTIME_PATH for users like Bruce (although
maintain any status information in /etc (in the year 2021) is not
nice.


The another possibility is to make a real change. Introduce completely
new file in /etc (/etc/clockmode) with only UTC/LOCAL(, force all
applications to use it (I know about rtcwake and systemd), and keep
/var/lib/hwclock/drift as private hwclock(1) file in a private format.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

