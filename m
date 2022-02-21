Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C819EC433EF
	for <util-linux@archiver.kernel.org>; Mon, 21 Feb 2022 12:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiBUMG5 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 21 Feb 2022 07:06:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345377AbiBUMGz (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 21 Feb 2022 07:06:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A694212E
        for <util-linux@vger.kernel.org>; Mon, 21 Feb 2022 04:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645445190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yn4zMTLAnqafI5njccFKzfZBmDTLsuW+DHsH8NI610w=;
        b=ieFcIQmedvHlOUPYrl2AdG+QV4Xl+m/larDoJkBCYGFCLj9E4yXiHgaBUJnZDn/EaqhkYh
        8sunz6TL2JQSrh6H12fPtIXdzabdRnvGdoe1xKfz3h1IVKv2TjETLaDX9Y47euhMohs/t9
        hKcWzgHncjl8qM5y5UZTwwqgKjDSdFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-Qx8X3bkxPMC-Rhv2jOV3cQ-1; Mon, 21 Feb 2022 07:06:29 -0500
X-MC-Unique: Qx8X3bkxPMC-Rhv2jOV3cQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60AF1801B0B;
        Mon, 21 Feb 2022 12:06:28 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF8C37B9E4;
        Mon, 21 Feb 2022 12:06:27 +0000 (UTC)
Date:   Mon, 21 Feb 2022 13:06:25 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org
Subject: Re: [RFC] uuid_generate_time_safe() without uuidd should always
 return -1
Message-ID: <20220221120625.w5h7b7v54wdzgafy@ws.net.home>
References: <1a366a68-8f04-44d7-2a26-6cbe2989d2d4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a366a68-8f04-44d7-2a26-6cbe2989d2d4@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Feb 18, 2022 at 04:56:39PM +0100, Stanislav Brabec wrote:
> After a research we realized that only the uuidd provides the guarantee of
> uniqueness of UUIDs across different CPUs and different UIDs.
> 
> Without it, there is a probability that two different processes on two
> different CPUs with a different UID will call uuid_generate_time_safe() in
> the same time and generate duplicated UUIDs.
> 
> There is a LIBUUID_CLOCK_FILE that should prevent it. But this approach can
> work properly for a single UID only. And creating it world-writable file
> would cause more problems that it will fix.
> 
> That is why I propose that uuid_generate_time_safe() should always return -1
> in case that it cannot interact with uuidd.
> 
> To realize this, uuid_generate_time_generic() should return -1 instead of
> __uuid_generate_time() return code.
> 
> It should not break uuidd, as it calls __uuid_generate_time() directly.

uuid_generate_time_generic() is not API function, so we can do there
whatever :-)

Maybe we need decomposition of complex uuid_generate_time_generic()
into small one-purpose functions and then mix these functions
in uuid_generate_time_safe() and uuid_generate_time().

What about to create small local functions with always only one
purpose and without any fallback:

 uuid_generate_time_async()         -- random bytes + gettimeofday() or -1
 uuid_generate_time_sync_by_file()  -- LIBUUID_CLOCK_FILE based or -1
 uuid_generate_time_sync_by_uuidd() -- connect() uuidd or -1

public API uuid_generate_time():

    uuid_generate_time_sync_by_uuidd() or
    uuid_generate_time_sync_by_file() or
    uuid_generate_time_async()
    
public API uuid_generate_time_safe():

    uuid_generate_time_sync_by_uuidd() (=return 0) or  
    uuid_generate_time_sync_by_file()  (=return 1) or
    -1

and uuidd will always call uuid_generate_time_sync_by_file() and
nothing else.

Yes, it's more work, but it will make code more readable, easy to
maintain and easy to extend in future.

> In the last month, we had a discussion about one clock file per UID in the
> home directory and one for uuidd as a solution of LIBUUID_CLOCK_FILE being
> handled in a first-UID-wins manner. It could improve the situation, but only
> for UUIDs generated by the same UID.
> 
> Both changes are partially mutually exclusive: If uuid_generate_time_safe()
> will always return -1, there will be no chance to inform the program, that
> the alternative synchronization was successfully used and that the UUIDs are
> safe in the local context. That it why I propose a small change of API:
> 
> Add a new return code of uuid_generate_time_safe().
> 
> == RETURN VALUE
> 
> The newly created UUID is returned in the memory location pointed to by
> _out_. *uuid_generate_time_safe*() returns zero if the UUID has been
> generated in a safe manner, 1 if the UUID has been generated in a manner
> that is safe for a single UID, -1 otherwise.

Make sense ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

