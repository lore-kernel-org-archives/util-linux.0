Return-Path: <SRS0=wrJr=TN=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9D4C04AB1
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 05:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEE71208C3
	for <util-linux@archiver.kernel.org>; Mon, 13 May 2019 05:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="oeh+7yAY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XJE78amm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfEMFd2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 13 May 2019 01:33:28 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41775 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbfEMFd2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 13 May 2019 01:33:28 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 04F8321385
        for <util-linux@vger.kernel.org>; Mon, 13 May 2019 01:33:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 13 May 2019 01:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:date:content-type:mime-version
        :content-transfer-encoding; s=fm3; bh=OG8ffOVAtRaq4du8nL045kraU1
        hWt9T/GS2gp1qiVSI=; b=oeh+7yAYO0uj6Kj1OjBbjZeo+4l8M4fOOUbuJum3Mr
        mMisl3F8yeZ/mTjmAX2ufrEfI4stcJG0lbVqJJE7OyieOtWeKyguTNHxFhzr+Kd3
        b4wGikGlY3WR4ZTPx2/bB/wqMS4hLHA0tigBln/dvJoF1bYh75qfoswIUsZ1ObaR
        0vLQj19zZZKLwQpCzmn781hbcQRIwU4HX8Ij1Z1iUvVUi+dJAZ4JrsZNWf51zQZt
        eLP2K5apdPVZ78utlCQlqSKN5pRoQv5nTHTBH2pXD1NZTiLHbcR377t1xV6LsueL
        iXeZ8DqwYryLPnVS7HEa2IwrRcbckLBqKllvuEuTGRZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=OG8ffO
        VAtRaq4du8nL045kraU1hWt9T/GS2gp1qiVSI=; b=XJE78ammmFRop5FnoZf5o9
        1XXyGsBj8JAvL28CR1vyE8XXiNbc8znyINViYrfPAi1HdsbNCOaYBVXvkrIWOz2N
        FGJ7L/qBEMhgIOVZOfoI3nMpMYdq9jPTDLjA7KY6LY+gd86ocVpwjpMRKkGmkjUw
        06RDa44Mf7l0rTdkmfnhXubT1/gghSEQTjx6xiUPuC7rHr4lMvger0hn66Nkg80J
        IxxtoBbKpZzyzxPJtJQdViBapebSDLLJ1wTwBtb3zYMX+LTc8KY2Is3nd0Qi8ZwF
        Iv2yYKRWlHQ/6bS7qteau53BHuMgl7AqhJOXjjGimMubrC4RLAgf3k0Tnf66W+Yw
        ==
X-ME-Sender: <xms:pgHZXDOvFgnHyAfxUgMDxBWfMWiQi4fpjdrD5KkymM9-EdljtK5fWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleefgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepkffuhffvffgtofgggfesthejredtre
    dtjeenucfhrhhomhepkfgrnhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvght
    qeenucfkphepuddukedrvddtkedrheeirdduuddvnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehrrghvvghnsehthhgvmhgrfidrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:pgHZXDN0Ewxt9T9Z6MCOobroea7FuS4sOMmVmGyn7vqNapj6n_VrrQ>
    <xmx:pgHZXD_rRdBzxTtJ07dUTg2x2nalomVp8L7UzkubwmRMjOcX-_yayg>
    <xmx:pgHZXP65fDPgdvaTCasM1hUsymTyqwHZ0CDAc6S4Zs7KPI_J6_8TNw>
    <xmx:pgHZXM0ORvCsRJE1D0OK4LpTC6b4GO-YcM8xBPra8oC7s7h8rgUjiQ>
Received: from pluto.themaw.net (unknown [118.208.56.112])
        by mail.messagingengine.com (Postfix) with ESMTPA id CB7B610323
        for <util-linux@vger.kernel.org>; Mon, 13 May 2019 01:33:25 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by pluto.themaw.net (Postfix) with ESMTP id 584731C0038
        for <util-linux@vger.kernel.org>; Mon, 13 May 2019 13:33:22 +0800 (AWST)
Message-ID: <6f811f1739162f229e25ed0755e2eb45a76f4c41.camel@themaw.net>
Subject: Using the upcoming fsinfo()
From:   Ian Kent <raven@themaw.net>
To:     util-linux@vger.kernel.org
Date:   Mon, 13 May 2019 13:33:22 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi all,

Some of you may know that David Howells is working on getting
a new system call fsinfo() merged into the Linux kernel.

This system call will provide access to information about mounted
mounts without having to read and parse file based mount tables
such as /proc/self/mountinfo, etc.

Essentially all mounts have an id and one can get the id of a
mount by it's path and then use that to obtain a large range
of information about it.

The information can include a list of mounts within the mount
which can be used to traverse a tree of mounts or the id used
to lookup information on an individual mount without the need
to traverse a file based mount table.

I'd like to update libmount to use the fsinfo() system call
because I believe using file based methods to get mount
information introduces significant overhead that can be
avoided. 

Because the fsinfo() system call provides a very different way
to get information
about mounts, and having looked at the current
code, I'm wondering what will be
the best way to go about it.

Any suggestions about the way this could best be done, given
that the existing methods must still work, will be very much
appreciated.

Ian

