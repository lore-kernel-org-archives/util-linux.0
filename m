Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC2AC433F5
	for <util-linux@archiver.kernel.org>; Wed, 26 Jan 2022 21:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiAZVYq (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 26 Jan 2022 16:24:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231603AbiAZVYq (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Jan 2022 16:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643232285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H5KXhYcSwD6njuWNDrj/WALyYlADiPWfcGYUrWRueNQ=;
        b=ZPP5RxgWSWtBAKcjtEQ5yX5JxEbzmUO7LjLnJrnFSUXqJw1JABS6oBs/69gHwUTCArZprr
        1fwfji0pIt/fLQw29ZclCHsphrcEfJ0ltpMppIoCWukPkW9luWU1hMvVwvyEmLnkMbllAB
        I0uovhJF/rGdntrVXi/F1YXJbnw7lNk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-456-aU_6EXZSM_Sd7mjiHuT0uw-1; Wed, 26 Jan 2022 16:24:41 -0500
X-MC-Unique: aU_6EXZSM_Sd7mjiHuT0uw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E04D21006AA0;
        Wed, 26 Jan 2022 21:24:40 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1218F5DF21;
        Wed, 26 Jan 2022 21:24:39 +0000 (UTC)
Date:   Wed, 26 Jan 2022 22:24:37 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Stanislav Brabec <sbrabec@suse.cz>
Cc:     util-linux@vger.kernel.org, Ali Abdallah <ali.abdallah@suse.com>
Subject: Re: [PATCH] Whitelist libuuid clock file
Message-ID: <20220126212437.d3r4gmniadrwfodl@ws.net.home>
References: <3f08fa1a-8efc-86d6-c492-7703f5b5ef38@suse.cz>
 <20220125105300.f3npvhr5emhvzevu@ws.net.home>
 <257bafee-3014-d3dc-ca4c-cc1f0504fca2@suse.cz>
 <20220125143032.p6otx2vhvft5qwu2@ws.net.home>
 <aae15301-3fca-b4b7-7832-7a84f309545e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aae15301-3fca-b4b7-7832-7a84f309545e@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, Jan 26, 2022 at 04:07:40PM +0100, Stanislav Brabec wrote:

> Another ideas:
> If uid is equal to "uuidd", use /var/lib/libuuid/clock.txt (or change to
> /var/lib/uuidd/clock.txt), else use home directory, e. g.
> ~/.libuuid_clock.txt.

This is nice idea. 

The file ~/.libuuid_clock.txt should be the default ;-), and we can  
extend __uuid_generate_time() to accept the clock file path as        
argument.  This function is called by uuidd, so the path will be fully
controlled by the daemon, then we can add --clock-state <path> to
overwrite /var/lib/uuidd/clock.txt.

This concept means that we do not have to care about uid at all and
the library (without uuidd) will not try to use any shared directory.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

