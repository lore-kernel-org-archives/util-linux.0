Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F31C4332F
	for <util-linux@archiver.kernel.org>; Wed, 23 Nov 2022 11:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236385AbiKWLSM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 23 Nov 2022 06:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbiKWLR6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 23 Nov 2022 06:17:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A9A258
        for <util-linux@vger.kernel.org>; Wed, 23 Nov 2022 03:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669202226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Ir4EgJA9jK+syYnEa8naTlcFcOwUeqTR1mMwew/ncQ=;
        b=I8AlvSZTee8XMp85GkqUEZ63ShX2zlhZnkhgdUxxm/z4Av8xWp9Cuonsd5/VSmqIrcE1/4
        yOqdbYEf0wM76H3aGIMECyu1zUNIkJbtE9HB6OTnEdGK++oBpwPRVaRyG499IETHlV8lfY
        WAMHQmyBCUn1CqhxiuZZ25bkpSUgTmM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-674-ZnQqjmIpMdq3BpIWx_YL7A-1; Wed, 23 Nov 2022 06:17:05 -0500
X-MC-Unique: ZnQqjmIpMdq3BpIWx_YL7A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41CF5811E67;
        Wed, 23 Nov 2022 11:17:05 +0000 (UTC)
Received: from ws.net.home (ovpn-192-16.brq.redhat.com [10.40.192.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 611BF492B07;
        Wed, 23 Nov 2022 11:17:04 +0000 (UTC)
Date:   Wed, 23 Nov 2022 12:17:02 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     util-linux <util-linux@vger.kernel.org>,
        John Westerdale <jwesterd@redhat.com>, fhirtz@redhat.com
Subject: Re: [PATCH 0/2] Add ability to use autofs mount option hint to
 exclude mount table list entries
Message-ID: <20221123111702.tvwb4cetdrsciypi@ws.net.home>
References: <166856374641.472741.1779154765995171105.stgit@donald.themaw.net>
 <20221123095148.lkeg43evzwj72m3e@ws.net.home>
 <a7fb9751-cac9-d84c-d419-8bbbf4b30528@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7fb9751-cac9-d84c-d419-8bbbf4b30528@themaw.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Nov 23, 2022 at 06:55:27PM +0800, Ian Kent wrote:
> In order for this to work the autofs user (typically a system admin)
> needs to change an autofs configuration setting to make automount(8)
> include the "ignore" option with autofs mounts so it's a conscious
> choice. Otherwise there's no change.

I see (well, I reread the commit message PATCH 1/2;-)

It means we can change the default to ignore the entries, and add 
findmnt --autofs to make the entries accessible if necessary.

    Karel

> 
> 
> Ian
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

