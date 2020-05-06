Return-Path: <SRS0=2oxY=6U=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DED6C28CBC
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 13:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40E4F2073A
	for <util-linux@archiver.kernel.org>; Wed,  6 May 2020 13:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fH/fJZAL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgEFNI6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 6 May 2020 09:08:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23034 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728299AbgEFNI5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 6 May 2020 09:08:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588770536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ONQXmHLvjvcEnZAQ80gVNnBY4nFtyU3fyHMcOEYAQg8=;
        b=fH/fJZALMEh870Do8IzngbxPOToNYKQ8YxH8D7TzCetpTypAFnArBLLKJ4m7oLzL0FwVj7
        uukRqjjm2VK4LQgFgWq69GOsBqg0p9OowJql6SUSrVAhKjCWlrSlNo0FyHjHBQAmdNvOCp
        MDibNA6HW43BFbzV/F7qURIMyNGEmC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-269-6ZhTdXD5NRCQh8ujZoZZFQ-1; Wed, 06 May 2020 09:08:52 -0400
X-MC-Unique: 6ZhTdXD5NRCQh8ujZoZZFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60FEF107ACCA;
        Wed,  6 May 2020 13:08:51 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9363A26337;
        Wed,  6 May 2020 13:08:50 +0000 (UTC)
Date:   Wed, 6 May 2020 15:08:47 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH] libblkid: add dax capability detection in topology
 probing
Message-ID: <20200506130847.d2u66a2lsrp4pfah@ws.net.home>
References: <20200505143145.9852-2-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505143145.9852-2-ailiop@suse.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, May 05, 2020 at 04:31:45PM +0200, Anthony Iliopoulos wrote:
> The dax (direct access) blockdev capability is exposed via sysfs, add it
> to the list of topology values to be obtained while probing.
> 
> Expose blkid_topology_get_dax() symbol that programs can link against
> for querying the capability.

Do we have any use-case for this change? 

We maintain blkid_topology_* mostly for mkfs-like programs portability 
(years ago we had only ioctls, etc..). You can see that libblkid export
only small subset topology stuff, so why we need DAX there? ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

