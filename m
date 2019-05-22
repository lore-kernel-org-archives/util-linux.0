Return-Path: <SRS0=qI5U=TW=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F350FC072B5
	for <util-linux@archiver.kernel.org>; Wed, 22 May 2019 03:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46DB2173E
	for <util-linux@archiver.kernel.org>; Wed, 22 May 2019 03:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="I8Qwanv3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FB9LxzS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbfEVDMb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 21 May 2019 23:12:31 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39191 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727930AbfEVDMb (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 21 May 2019 23:12:31 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 176C72201F;
        Tue, 21 May 2019 23:12:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 21 May 2019 23:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        HLjfrYRPt2SfhAqjRixkWLe6AlfIJ0c/bq1jshmdJ3M=; b=I8Qwanv3HJvNB2I7
        wZ0QazLQGWuXs2dg7QOVKZaxn6O78B96SwfthBkK9ig7CmVHco7sfqUYkZLfZVIx
        jmeW0Dg1VLPiHZfmADnEnxLavYR6bmcaGSAUs8qfjPeWpzkxz1rCe0I06/azNmWE
        BcTpMOWHnLHNaelEhiqw3cPS+YPDHMb4BS3JisT9P2scG0XZHpk6XEl3sx8SJ9w6
        kC/YfZYG16zE+q+Ymvpejhz1NvOuv9VWsBEAqes5EQFBwVOYIOIe84oGuhX47qCg
        WQimOB2W/R5euAyNhaxNKv3KpTN7Mv4ZWGwgydv7hQ0Muw67XYgY0hXUwzy16meb
        g7xUbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=HLjfrYRPt2SfhAqjRixkWLe6AlfIJ0c/bq1jshmdJ
        3M=; b=FB9LxzS996J6DqbnnDpvl4OGr64GpaY5lRGUO1yLI3SFrKhddALCyM7L1
        7cuT72fjMqa5vgtUSw0siGrmIp/WHJgD3N7HMBYzTXulwrt6LRRnUWDMriBvSC2+
        QwgottoMnCZEOyQI8cvxnwjtOn5Eh8neAWVwB+DZRVOAOZcmoqf5mnMd1KfQAKXo
        q8/of9YsHihQuREnfA9wYHRUHAAXL0q+jsHPywOxYuPDAdNcEMk8eAAgzmyID6tr
        doDCSoMnxZA71fsdtgiPTMewI4sii7sV6XXk+cK98+FyZvYNXzKwD/8QXZe5H2Ko
        f4O4hyEqpYlyG2j3UG+Q3Pu78m0qw==
X-ME-Sender: <xms:Hb7kXCnudo2YdgvpGRlplE9by1VY7NKRVoyqtS9HNHXIjQ7KQLxoqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudduuddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtofgggfesthejredtredtjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtke
    drheeirdduuddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgr
    fidrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:Hb7kXP3c-wk8VKn7UKdT_pBf8oaxeioUw9nHbKkovNp93Bhn1VTEqg>
    <xmx:Hb7kXORbTdy6TQFO1xY2lYbgIakRX0UmbW_hHAdZaiH6Ks0k6R1TnQ>
    <xmx:Hb7kXBtBiePqBX_9HtQYWDH_fSD4K4CHmqbBFv-yiNc1k5_02EpbQw>
    <xmx:Hr7kXEgkqlofrSx-FXyhx-OTroZK3oV6MieCbmWcv96VMCq0X8Db5g>
Received: from pluto.themaw.net (unknown [118.208.56.112])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1DD63380087;
        Tue, 21 May 2019 23:12:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id A556E1C005D;
        Wed, 22 May 2019 11:12:25 +0800 (AWST)
Message-ID: <0fd126b7de1e775484ce985a2ec69d97df21210e.camel@themaw.net>
Subject: Re: Using the upcoming fsinfo()
From:   Ian Kent <raven@themaw.net>
To:     L A Walsh <lkml@tlinx.org>
Cc:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Date:   Wed, 22 May 2019 11:12:25 +0800
In-Reply-To: <17de51282f3c3fafd3e99bff5aeb49d17e70b603.camel@themaw.net>
References: <6f811f1739162f229e25ed0755e2eb45a76f4c41.camel@themaw.net>
         <20190513090823.2qys6sv4tspbr3b2@ws.net.home>
         <466a727a4f4a51c3ad953d2151c9ef19a2259d69.camel@themaw.net>
         <20190515114538.bgtfh6rudcyvrmn2@ws.net.home>
         <c6baaf226834e7238807fa469335c79eeadb4f34.camel@themaw.net>
         <5CE44FA5.9000700@tlinx.org>
         <17de51282f3c3fafd3e99bff5aeb49d17e70b603.camel@themaw.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Wed, 2019-05-22 at 10:59 +0800, Ian Kent wrote:
> 
> > 	This serves to workout that the call always returns what you 
> > expect it to, familiarity with the new call and how it works as well as
> > developing a first interface to construct and parse calls-to and 
> > output-from the call.
> 
> Avoiding having to parse string output (from the proc file system
> mount tables) is one of the key reasons to use a system call for
> this.
> 
> So this isn't the point of doing it.
> 
> The work for this (and some other new system calls) is being done
> in the kernel so the issue isn't to work out what the system call
> returns as much as it is to ensure the system call provides what's
> needed, implement things that aren't yet done and work out ways of
> providing things that are needed but can't yet be provided.

Just to give an idea of the amount of work that still needs to be
done there are around 70 file systems included in the Linux kernel
and, so far, the code needed to provide the file system specific
mount options via fsinfo() has been done for a little over 10 of
them (about 8 of these in the last few days) and most of those are
the simpler ones.

But having said that providing the file system specific mount options
appears to be one of only a couple of things that's missing.

Ian

