Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AD7C433F5
	for <util-linux@archiver.kernel.org>; Tue, 26 Apr 2022 08:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344588AbiDZIZp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 26 Apr 2022 04:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344703AbiDZIYg (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 26 Apr 2022 04:24:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6EEA39825
        for <util-linux@vger.kernel.org>; Tue, 26 Apr 2022 01:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650961289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mMVXZUyOVidefFh1sRBmgr4YqPdtbdPTvBDvA4ClLR4=;
        b=UiLBMq0dtPUTpFst951FpmLMHu5BF4eQG+s9tYEJc+JxAApqkHSzDvQcYEkTVduWrTJwdY
        roBSbn7iO2DIeEmJkzc4ip7l+MyCPdUolJy75MhvEHNbanJ+0skDwBX5D71DGlBw7vlE1C
        DPrnR3KQlpy+G96FpBU3YXAb0ytQ/C8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-YWfQZ5VHOKuSh4CUgb4Fgg-1; Tue, 26 Apr 2022 04:21:28 -0400
X-MC-Unique: YWfQZ5VHOKuSh4CUgb4Fgg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CEC386B8A6
        for <util-linux@vger.kernel.org>; Tue, 26 Apr 2022 08:21:27 +0000 (UTC)
Received: from ws.net.home (unknown [10.36.112.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A70D2166BDF;
        Tue, 26 Apr 2022 08:21:06 +0000 (UTC)
Date:   Tue, 26 Apr 2022 10:21:04 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     Andrey Albershteyn <aalbersh@redhat.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 0/2] libblkid: add FSSIZE with XFS implementation
Message-ID: <20220426082104.fojzjdfprbb2dth7@ws.net.home>
References: <20220421130946.318737-1-aalbersh@redhat.com>
 <20220425134329.ub3thxkscsniy74e@ws.net.home>
 <8b2a82b2-8890-1276-9948-d8c28fca3d9b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b2a82b2-8890-1276-9948-d8c28fca3d9b@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Mon, Apr 25, 2022 at 10:38:02AM -0500, Eric Sandeen wrote:
> On 4/25/22 8:43 AM, Karel Zak wrote:
> > 
> >  Thanks Andrey,
> > 
> > the code looks good.
> > 
> > On Thu, Apr 21, 2022 at 03:09:44PM +0200, Andrey Albershteyn wrote:
> >> I had a look into other fs, like ext4 and btrfs, to implement FSSIZE
> >> for them, but I think I don't have enough expertize to do that as
> >> they have not so trivial metadata overhead calculation :)
> > 
> > But it would be nice to have ext4 and btrfs too. Maybe Eric can help
> > you :-)
> > 
> >     Karel
> 
> For ext4 something like e2fsprogs does is probably ok:
> 
> static __u64 e2p_free_blocks_count(struct ext2_super_block *super)
> {
>         return super->s_free_blocks_count |
>                 (ext2fs_has_feature_64bit(super) ?
>                 (__u64) super->s_free_blocks_hi << 32 : 0);
> }
> 
> though I wonder if a little documentation on the intent of the flag is
> in order; ext4 can return "df" in different ways (see the minixdf and
> bsddf mount options.)
> 
> I think best effort seems fine here, and reporting the same number
> as the ext4 utilities do should be fine.

Yes, that's good enough.

> As for btrfs - I'm really not sure what this should return on a
> multi-device filesystem?

Hmm ... good point. I guess the right answer is return nothing,
because we really don't want any complicated fs-specific logic in
libblkid.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

