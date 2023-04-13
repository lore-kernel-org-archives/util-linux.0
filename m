Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF09C77B61
	for <util-linux@archiver.kernel.org>; Thu, 13 Apr 2023 16:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDMQ7N (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 13 Apr 2023 12:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjDMQ7M (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 13 Apr 2023 12:59:12 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2046010D3
        for <util-linux@vger.kernel.org>; Thu, 13 Apr 2023 09:59:11 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id C6A745823F2
        for <util-linux@vger.kernel.org>; Thu, 13 Apr 2023 12:59:08 -0400 (EDT)
Received: from imap45 ([10.202.2.95])
  by compute5.internal (MEProxy); Thu, 13 Apr 2023 12:59:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
        cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1681405148; x=1681412348; bh=TOqb0qoC/ESrYrbzGn7wlEVXI
        9GPYoue0j0AMdS2vrE=; b=FyT6UsPrE/pYR0M73SyJ0TEHWn+Thmhb+JVJJ9BD5
        1Nul/CwCvpnBBb3gaFSN7qVy027pPfipli1x2EMZGpA9+p0NkXk6a37ehwaqhpWu
        /fYdoyJZyokDtctJpJ4tcqLGw5wsIxdKvsTgWkuO1iuqzkpAiXh3r8aLaxhxZmn4
        lL6xWmCtdvu3V1V+qbOypSZEfTZaq99osoDKUulvG0boEkW2nA6BIpYe3LTM+sf8
        HI2z54q5ErbjLFCSgNizWpTinUgc2eKEmvIay4tQuQn40Hf5SnR2uSntlE09FG+f
        iup2dL6nVUoc7sS0GgHtE25MKb/f/sSOYRWnxD78pTJ2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681405148; x=1681412348; bh=TOqb0qoC/ESrYrbzGn7wlEVXI9GPYoue0j0
        AMdS2vrE=; b=PJxCHZTXcsxSmkY6jQlO+Cm9y0uwus41RtHXkQZk803GHa3yUWE
        OoayPgnjNpettMwPfWWs6bdETi7nECRlyQSMfs/c/Z76LOLO4zUbvJ46kEvtE9zy
        08/4pkMzxvUe7lUqskYXiGsQO04moXtlQGDvcgjEvMTjwexkL39tepxrIhtxY4RY
        4I5XILsXCszQFV/DuYkYhba0TiLCYnM+Wa4VQZbP9dyfV3HNPbBhT4sLsiXqRqNa
        Hktqh+ApkXv8AzDMubkOjjzRMh7FBZR6BQm5fkF4fd0tiJ81RTyCrUubvQORPBPv
        QOnTukBBAv70Q92Dn7io4+owMyrTSijkjoA==
X-ME-Sender: <xms:3DQ4ZNAJO0ApywNLlBIt7uDTS4sL86q8I0Jx6u55SNGR__6Q2RPB3A>
    <xme:3DQ4ZLgpqhddFml6KWYj6SwrXAqE5nLV_H5_duj649CtuRUOfcnKyZKtFrqxmxeGw
    xDXLWOzXzzTTl81Tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogfuphgrmhetlhhphhgrtehlihgrshdqohhuth
    culdehtddtmdenucfjughrpefofgggkfffhffvufgtsehttdertderredtnecuhfhrohhm
    pedfmhihucgvmhgrihhlfdcuoehmhigpvghmrghilhesohifnhhmrghilhdrnhgvtheqne
    cuggftrfgrthhtvghrnhepkedtgeehfeeguedtudelkeevfffhgfegkeelhfefffehhfeg
    teffveeggefhgfelnecuufhprghmtehlphhhrgetlhhirghspehmhigvmhgrihhlnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhihpggvmhgr
    ihhlsehofihnmhgrihhlrdhnvght
X-ME-Proxy: <xmx:3DQ4ZIlr7_E7sX1cLOSVz10TmQ2jhmL4CipkT5sfu0TdtQBm46OwAw>
    <xmx:3DQ4ZHxLvVJdk0Btjvlo2h1hdNUGsELUgPT9MJQTCUn5qiir5b-3mA>
    <xmx:3DQ4ZCRQ_qYQT9nbRJyrj6n0Pm2jnKM0bObbwsfYXGX-9pzgfWurLw>
    <xmx:3DQ4ZJfeFBpxKQYYJ2kfWxQVrK1j7ptCeXD-ovT8swQ8X1IEfRo_ZA>
Feedback-ID: i2a1946a3:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 95F8B272007A; Thu, 13 Apr 2023 12:59:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <26563fb0-8995-44b6-b341-ae978ec08968@app.fastmail.com>
Date:   Thu, 13 Apr 2023 16:59:08 +0000
From:   "my email" <my_email@ownmail.net>
To:     util-linux@vger.kernel.org
Subject: thanks
Content-Type: text/plain
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

What command (and what procedure) to change the "max total shared memory" limit.  I have used ipcs to obtain data but the shared memory limit is too high. Also possibly too high is the "max number of segments"   Pls advise how to further limit.  Suspected malware.  Thanks.

Ipcs -u

max number of segments = 4096
max seg size (kbytes) = 18014398509465599
max total shared memory (kbytes) = 18446744073709551612
min seg size (bytes) = 1


No analytics, no ads, no tracking, no
sharing personal data.
No analytics, no ads, no tracking, no sharing personal data.
