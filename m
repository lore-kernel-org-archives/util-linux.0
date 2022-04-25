Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722BEC433F5
	for <util-linux@archiver.kernel.org>; Mon, 25 Apr 2022 13:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242281AbiDYN50 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 Apr 2022 09:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbiDYN5V (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 Apr 2022 09:57:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FAD06D1BE
        for <util-linux@vger.kernel.org>; Mon, 25 Apr 2022 06:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650894856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fLDjMMr17b6gjXmcUt4YGEQgUN/6tw0n2nk0vRNthkg=;
        b=BS6XpWIHIS3I3TE53SPr8z/vY7HLP6g4/HC4q7UsGLhwuP7aZeqpe3q8Y0G/osFYaYgM2S
        GFF3owO6R9oZGOxvgZFtDzgv2V+/U2w0qOksXs/mtpCfOAUFdVPKkFRGIkjueTLGW0GuYr
        +FmzgDzS6noovlY2j/FE5Ya3SFI8dTo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-2xn6oT34M66myQpVV5QgNg-1; Mon, 25 Apr 2022 09:54:13 -0400
X-MC-Unique: 2xn6oT34M66myQpVV5QgNg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C84D1014A6C;
        Mon, 25 Apr 2022 13:54:12 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FCD7463E0B;
        Mon, 25 Apr 2022 13:54:11 +0000 (UTC)
Date:   Mon, 25 Apr 2022 15:54:09 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org, util-linux@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Subject: Re: [PATCH] nvme: add namespace paths links
Message-ID: <20220425135409.zov6h63i76e2ljj6@ws.net.home>
References: <20220401092855.90652-1-hare@suse.de>
 <20220405054205.GA23466@lst.de>
 <289ee526-8f3f-9a2b-eef4-70816eb4f42e@suse.de>
 <20220405054836.GA23647@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405054836.GA23647@lst.de>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Tue, Apr 05, 2022 at 07:48:36AM +0200, Christoph Hellwig wrote:
> On Tue, Apr 05, 2022 at 07:46:40AM +0200, Hannes Reinecke wrote:
> > On 4/5/22 07:42, Christoph Hellwig wrote:
> >> On Fri, Apr 01, 2022 at 11:28:55AM +0200, Hannes Reinecke wrote:
> >>> It is really annoying to always have to loop through the entire
> >>> /sys/block directory just to find the namespace path links for
> >>> a single namespace in libnvme/nvme-cli.
> >>> So provide links to the namespace paths for efficient lookup.
> >>
> >> I think having some form of links would be useful.  Quite a while ago
> >> Thadeu looked into adding some form of relationship for lsblk and
> >> friends.  Maybe it would be good to sync up and make sure whatever
> >> links we are adding would be useful for all users?
> >>
> > Care to elaborate?
> > Using the block device name is the most straightforward way here; we don't 
> > have a good enumeration to leverage as the paths are essentially just a 
> > linked list.
> >
> > We sure can have a subdirectory 'paths', and stick the links in there.
> > If that helps with lsblk ...
> 
> I personally don't care.  But I've added Thadeu and the util-linux list
> to get everyone on board.
 
lsblk internally can accept arbitrary relations between devices
(and libsmartcols can display it). If you introduce something new or
extend the current holders/slaves, it will probably be accessible for
lsblk to use it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

