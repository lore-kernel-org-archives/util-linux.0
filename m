Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5652C433EF
	for <util-linux@archiver.kernel.org>; Wed, 23 Feb 2022 14:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240378AbiBWOHg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241374AbiBWOHf (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 23 Feb 2022 09:07:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E3FBBF51
        for <util-linux@vger.kernel.org>; Wed, 23 Feb 2022 06:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645625226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jSWcw412Vvtpv5UrU5s5zd7VKq+lbRUDWJRpYyq4qO8=;
        b=If+LzRV1WGm3ehCtiAw6kxPp+2KYCl25cPmwhMgTE2XEayRW1u/N89cOUso/u0xBKnAZUq
        R5lVkypQ0iFaiqRYpbxLFIh+GQ/prqQHU7NuJZad4xCtubzQuFgwubntMFwFrFVKbf5ONY
        ulkRoZraLB3q1WhnvAkfTvGNQiAp/qI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-f7goXNAkOBOeTzuhzY2KUw-1; Wed, 23 Feb 2022 09:07:05 -0500
X-MC-Unique: f7goXNAkOBOeTzuhzY2KUw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F5E81006AA7;
        Wed, 23 Feb 2022 14:07:04 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 80670106D5B1;
        Wed, 23 Feb 2022 14:07:03 +0000 (UTC)
Date:   Wed, 23 Feb 2022 15:07:00 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [RFC] uuid_generate_time_safe() without uuidd should always
 return -1
Message-ID: <20220223140700.nl3r2fkfw3otoo3b@ws.net.home>
References: <1a366a68-8f04-44d7-2a26-6cbe2989d2d4@suse.cz>
 <20220221120625.w5h7b7v54wdzgafy@ws.net.home>
 <e8fabaa8-7e2f-6959-8017-174da966820d@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8fabaa8-7e2f-6959-8017-174da966820d@suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Feb 22, 2022 at 02:48:42AM +0100, Stanislav Brabec wrote:
> > > == RETURN VALUE
> > > 
> > > The newly created UUID is returned in the memory location pointed to by
> > > _out_. *uuid_generate_time_safe*() returns zero if the UUID has been
> > > generated in a safe manner, 1 if the UUID has been generated in a manner
> > > that is safe for a single UID, -1 otherwise.
> > 
> > Make sense ;-)
> 
> Do you think that we could make such API change (3 return values instead 2)?

Good question.

Frankly, not sure, from google it seems uuid_generate_time_safe() is
used by users.

Maybe introduce a new function which returns info about quality 

    uuid_generate_time2(uuid, &state)

where state is 

    UUID_STATE_ASYNC        (gettimwofday() + MAC)
    UUID_STATE_SYNC_PROCESS (per-propcess unique UUID) 
    UUID_STATE_SYNC_SYSTEM  (per system unique UUID)

but maybe with better name than uuid_generate_time2 ;-)

And in man page describe that uuid_generate_time_safe() returns
UUID_STATE_SYNC_PROCESS or UUID_STATE_SYNC_SYSTEM, and keep the
function unchanged.

So, guys from SAP will check for UUID_STATE_SYNC_SYSTEM to be
absolutely sure that UUIDs are in the best possible quality. And one
day in far future if anyone will implement synchronization between
more systems we can introduce UUID_STATE_SYNC_CLUSTER ;-)


We can also add --state to uuidgen(1) to return info about it on
command line.

> I think that most implementations compare with zero, so it should be OK.

Not sure, I guess 

    if (uuid_generate_time_safe(u) == -1)
        errx("universe collapsed");

is also possible ;-(

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

