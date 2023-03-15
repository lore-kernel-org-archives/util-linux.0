Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCECC61DA4
	for <util-linux@archiver.kernel.org>; Wed, 15 Mar 2023 23:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjCOXMu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 15 Mar 2023 19:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjCOXMt (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 15 Mar 2023 19:12:49 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E93787D97
        for <util-linux@vger.kernel.org>; Wed, 15 Mar 2023 16:12:48 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C322F5C00A9;
        Wed, 15 Mar 2023 19:12:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 15 Mar 2023 19:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1678921965; x=1679008365; bh=DYJBAg+Fq1ftypYKunk8A6jYoXD3hWlw+uH
        p01uuGKM=; b=jrSfZfdT4jD92W8vZ+PvQHRRkeu/kYOPJu26BgrorpL4OdMMU6x
        tvUSWfMQDdhMhhofcy9Eauo8xEsz7r5YADzwO6ITjunPtu3HAbIPy3JZhPR9nznj
        zy5li5iDJAMIuXcpecnyJXATsV+auF7qfk/UhX86ET/yqN+Fw3TbHNIuiPH05Bs8
        qzrqIuUCAa6qTm/HlAr8fCNbO3gWSauM5oXF4TSKfCN72AsKY+ONTYHkUuqsmT+X
        PsDwB+bj6rH6BJCkIwMndN15kCd6i35dziN0nH1HIoaHhhxgPuMkV7mlEpVnkbRC
        LYk65WZlxUNQvMO2oLhGNxfdYW7RPCqXwWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1678921965; x=1679008365; bh=DYJBAg+Fq1ftypYKunk8A6jYoXD3hWlw+uH
        p01uuGKM=; b=Rkzvg14wiuL6yUS/Ey9cWnCWby+0aCt39t0qGUvwFw8qW5ufB30
        bLN0elrd4iDX0DG4ctF/qLQ/toxkIOz3tJeNdeVPqdYxdiOZLH4/SrVj8qV4FGlH
        kI6L5d97DXAumVZ6+i9ErUQeNN+b0cQxHE/PkxznDUS1nY64x021NAdrLZDw9AtP
        +TMYRNC9o4p2iwZZmTOTSrKUhylr5dgnXWsF8FmnzjHLwEgbQ5SkJ3GMj+D/8xmh
        omv6bn6f2kMNEkH2dojigMO+v/gnL7rW7pu+Mkqs5El41RH+4588Da45J8f86r77
        gBqfn2wo3NU4zN7jGkMNl8W+qsNTpm5feUA==
X-ME-Sender: <xms:7VASZDW7uZxC46dfuc8QdiWDsqYQE_TlZM3DJN0a3KoeQO-DTb4Zcw>
    <xme:7VASZLlvGGw4dUZv1rLioGVAbEVy7E7LttouhED1OjYClImboz5Owi-aWg9vqJCFN
    9KNZCj2Z-sm>
X-ME-Received: <xmr:7VASZPYftF4pmPx7L-HjhANsTqMgEtqlOPieqJH02T6Em6_QUka1PZKH1_W9KdnkTzyzaG2T-sjmLsbvc2XgxtUKERohaxlCTSdQEBiM0ZuXTpQRzh_N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epuefhueeiieejueevkefgiedtteehgfdutdelfffhleeflefhudeuvdefhfeghfehnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:7VASZOULFDcff709PZ5zQdZQThF3xTB4GiD5IRKQVlc38fEkhpOdnA>
    <xmx:7VASZNmSmD_FUBbIP4b66AyvD3zIGGqx43HNKHXSzg88_FhbZTfzKw>
    <xmx:7VASZLcY2DZujowOw-FJk32OMeCSQxuf3lEn0xb9jO3XwWcpJq3rww>
    <xmx:7VASZCzCB7MkeZP_TCCF03qDFBNnuYuOrVZZTyKy4baIqeqffJdoRg>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 19:12:43 -0400 (EDT)
Message-ID: <b32a757e-4edd-1462-89a2-d5361e2668af@themaw.net>
Date:   Thu, 16 Mar 2023 07:12:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] libmount: dont ignore autofs mounts by default
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux <util-linux@vger.kernel.org>, fhirtz@redhat.com,
        John Westerdale <jwesterd@redhat.com>,
        Frank Sorenson <fsorenso@redhat.com>
References: <167867177635.35511.15003989525678735907.stgit@donald.themaw.net>
 <20230315143255.if5idh3cpd7or3a3@ws.net.home>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20230315143255.if5idh3cpd7or3a3@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 15/3/23 22:32, Karel Zak wrote:
> On Mon, Mar 13, 2023 at 09:42:56AM +0800, Ian Kent wrote:
>> so we can't make this the default behaviour in libmount.
> I see ;-) Applied (both patches).
>
> What about findmnt? I think it should follow "ignore" by default too
> (if --all no specified).

Thanks very much.


I'll have a look at findmnt but the main driver is admin users

struggling with cuter on screen output.


I thought findmnt is more often used in admin scripts where it

may be more sensible to not ignore mounts. Of course not ignoring

the mounts for the --all option might make sense.


Ian

