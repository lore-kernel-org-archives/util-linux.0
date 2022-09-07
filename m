Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79230ECAAD3
	for <util-linux@archiver.kernel.org>; Wed,  7 Sep 2022 07:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiIGHU5 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 7 Sep 2022 03:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiIGHU4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 7 Sep 2022 03:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF828983B
        for <util-linux@vger.kernel.org>; Wed,  7 Sep 2022 00:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662535254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ZfMzLvmWwBh9ruihv/y7KQDtNMXQ6QZMlcVRl8LVdQ=;
        b=SigmQKj9Nj/g6cLYjXy1jffG4TfUP89p/za8GpkjxAzroSBPwzVU3qHlQqUyoVNSFwEP+8
        Saq/MGQDUc/mkAfisGXzM70blYeSHVUlES78cXSXVr5ss8OAfFy8BMmV+M62DMiSUIm9CJ
        3er0daz9vaD82Oig+z5rcGB/nGybqn0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-A2Ad-oZyOWaGq9SuWR40iw-1; Wed, 07 Sep 2022 03:20:53 -0400
X-MC-Unique: A2Ad-oZyOWaGq9SuWR40iw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B80F580418F;
        Wed,  7 Sep 2022 07:20:52 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.192.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A3F41121315;
        Wed,  7 Sep 2022 07:20:51 +0000 (UTC)
Date:   Wed, 7 Sep 2022 09:20:48 +0200
From:   Karel Zak <kzak@redhat.com>
To:     =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] lib/timeutils: Add %s (seconds since the Epoch) to
 parse_timestamp()
Message-ID: <20220907072048.5buz33o2df5cvdiw@ws.net.home>
References: <20220906070436.684-1-peter.ujfalusi@linux.intel.com>
 <20220906084716.4bgsdahoyjfaaksc@ws.net.home>
 <849c4ca2-a1b7-7429-1b3c-fc135d9f4d72@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <849c4ca2-a1b7-7429-1b3c-fc135d9f4d72@linux.intel.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Sep 06, 2022 at 07:31:07PM +0300, Péter Ujfalusi wrote:
> On 06/09/2022 11:47, Karel Zak wrote:
> > On Tue, Sep 06, 2022 at 10:04:36AM +0300, Peter Ujfalusi wrote:
> >>  lib/timeutils.c | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> > 
> > Applied, thanks.
> 
> After some tinkering with a script where I needed this, would it make
> sense to change the way how one should be specifying seconds since the
> Epoch time to
> '@'<number>

Yes, '@' seems more readable. I have no strong opinion about it, maybe
we can support both convention (with and without @).

Anyway, we really need to add something like "INPUT TIMESTAMP" section
to the man page to describe supported formats.

> This would match how for example systemd.time requires it [1]
> 
> Basically I (or anyone) can use dmesg instead of journalctl in a script
> with the same --since=@<timestamp> parameter.
> 
> 'date +%s' prints out just a number.

It's possible to use --since=$(date +'@%s')

> If not, then I have made a rookie mistake with the patch, which should
> be fixed (discarding the seconds we got out from the timestamp).

Do you mean your copy & past tm.tm_sec = 0;? This should be fixed.

> /me hides

Come back and send a patch :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

