Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED4EC4332F
	for <util-linux@archiver.kernel.org>; Wed, 23 Nov 2022 11:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237196AbiKWLBQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 23 Nov 2022 06:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbiKWLA5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 23 Nov 2022 06:00:57 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1CC113FEF
        for <util-linux@vger.kernel.org>; Wed, 23 Nov 2022 02:55:37 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id EDD5A320092D;
        Wed, 23 Nov 2022 05:55:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 23 Nov 2022 05:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1669200933; x=
        1669287333; bh=fI0pRzt9wvJUdpQi+AE39Att4RVz0lcHWUlddp8Zu4E=; b=F
        e2tams49XEXcF2zEEvKiYeLh7n+EeWtbUR0ZDZGGMBp45Ko6QNOP2HI0YqjL2rXs
        bhc8rRvr9QN68lQ/jwkzrDFY61vhrsiAdS4Gae8p7nWFDIId/IY9Wf47bdeakFql
        FHqcsuyL9bY6x1UnC3p1WU+fgNrYoyZ/fCAk8yoJvWiuTGBmwLHkruMiQxbZHGEB
        4ePg+ClQ2aL/sflwlSdv5kkoLgkXcmHqZvar+08Wa7JsEU4s26g75fj9iqGd3p41
        nkV7474yJ5XzqeJXgZ3W3Q6WETHdOk6Ihit+I5hE0e0PTAmQtHkPdGhpVlCXzJJe
        oq/fddDOa7QIqr5GNXYGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669200933; x=
        1669287333; bh=fI0pRzt9wvJUdpQi+AE39Att4RVz0lcHWUlddp8Zu4E=; b=r
        /JfBaUWEfFsuGvcX0kZQ+q9WlcU2YOEOGE1SHtyN1+jnFOC+bSOHXRtiw1pGmCHJ
        e2cH00bk6iqskxSLyFi0OrEMiopVYvjd+nsKwLBHUMStLFiXlbHXXxkomghsWrQB
        exG663rj2rdcUK8pt8BOpdVgXSyUH6gVFHKZySIFfTfhALX4dnGgSSeuYBBiXK7A
        meAW7KLvu//0glP7TY0JwvsXJn6XIsLODfUX1OaVHMh5oELg1jPyQUiHsJRp7tUa
        /qWvQGnuLyJX2PDyrorokMJO+GadTFy3ytVWBO1zpyICpOVeNCun7EScJozjixhA
        sK98wu7dvTe3atcvJSoJA==
X-ME-Sender: <xms:Jfx9Y_AuZqXXsszT-LGjBquDBdYZA0qu2VDYmoP4GsslWJf9627vAg>
    <xme:Jfx9Y1i44-cX3x4dwBE0Fn92X0TbRy39ZOLRV2Bes5HABBQeo1od0xNg97AUq0-mT
    j5LOyyMhScV>
X-ME-Received: <xmr:Jfx9Y6nlFIx7x75YFCaHHlojMMVSbvdSfXfUkBOv6Jik8ALUOXWyXbopRJ8IJvBvsCLkemOzmRfpKCZjUqPRkJtvZT3U-4brx1KFnSa4YCe0ygfcuqna>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedriedugddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    euhfeuieeijeeuveekgfeitdethefguddtleffhfelfeelhfduuedvfefhgefhheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:Jfx9YxwL6_VhqD_kC9DlDrmB214-4V00iBbTah5WHqRbeRprgc1Mhw>
    <xmx:Jfx9Y0SnIqObDwriAe3wO2Y1pc7XzLnRc7JWcZRDABPvn-CNhIliCg>
    <xmx:Jfx9Y0bsnkPAzWZpMAKTHdSsBah1z314fBLFjiFL14u7O2566Z2G_g>
    <xmx:Jfx9Y_Ldlcm7WAVV0fHgw-_Myqd0BZiebSzZvbD45kxmXbXNnBEt7Q>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Nov 2022 05:55:31 -0500 (EST)
Message-ID: <a7fb9751-cac9-d84c-d419-8bbbf4b30528@themaw.net>
Date:   Wed, 23 Nov 2022 18:55:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/2] Add ability to use autofs mount option hint to
 exclude mount table list entries
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux <util-linux@vger.kernel.org>,
        John Westerdale <jwesterd@redhat.com>, fhirtz@redhat.com
References: <166856374641.472741.1779154765995171105.stgit@donald.themaw.net>
 <20221123095148.lkeg43evzwj72m3e@ws.net.home>
Content-Language: en-US
From:   Ian Kent <raven@themaw.net>
In-Reply-To: <20221123095148.lkeg43evzwj72m3e@ws.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


On 23/11/22 17:51, Karel Zak wrote:
> Hi Ian,
>
> On Wed, Nov 16, 2022 at 10:00:39AM +0800, Ian Kent wrote:
>> There's further discussion of this in the first patch.
>>
>> I started trying to do this quite a while ago, glibc, automount(8) and
>> the kernel have been updated to use such a mount option but, for some
>> reason, when I canme to update util-linux I thought it would cause
>> problems for systemd. But when I looked at what I had done just recently
>> I saw that isn't the case so I'm now continuing with this change.
> It's definitely no problem if the new behavior is optional and it's
> possible to enable/disable it. So, the systemd can keep it disabled
> ;-)

Indeed, agreed, ;)


>
>> What I've done might not be the prefered way to do this so any comments
>> are welcome so it can be done the way it fits best with util-linux.
> What about findmnt(8), maybe we can add --autofs=yes/not.


I think those that want this most will expect it to just work.


Typically they will be system admins that want to get rid of mount table

clutter resulting from autofs. So just changing an autofs configuration

option and having this work is the goal.


Historically autofs file system mounts didn't show up in mount table

listings and that's essentially the behavior I'm trying to bring back.


> The problem is that we probably do not want to change the default
> output as it's probably already used in many scripts, or is it
> acceptable to hide autofs by default? It's already done for glibc, so
> it may not be a big issue. Not sure.

Of course yes, and that's also the main reason we can't filter the

proc file system directly from the kernel, it must remain the

authoritative source with all mounts present so they can be seen if

needed.


In order for this to work the autofs user (typically a system admin)

needs to change an autofs configuration setting to make automount(8)

include the "ignore" option with autofs mounts so it's a conscious

choice. Otherwise there's no change.


Ian

