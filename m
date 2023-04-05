Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE48AC7618D
	for <util-linux@archiver.kernel.org>; Wed,  5 Apr 2023 23:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjDEXB1 convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Wed, 5 Apr 2023 19:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjDEXB0 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 5 Apr 2023 19:01:26 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F413A8D
        for <util-linux@vger.kernel.org>; Wed,  5 Apr 2023 16:01:24 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|mail@christoph.anton.mitterer.name
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C71B992162C;
        Wed,  5 Apr 2023 23:01:23 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id CDB6D920E45;
        Wed,  5 Apr 2023 23:01:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1680735683; a=rsa-sha256;
        cv=none;
        b=V6DGbMF5/V9a31R6jaojrfCDseHvOQeSQB7FMj6F1lUr/AR8nf4ivVfpqzykqQ2vJ82Kf8
        JJCC2idF534Vseg+rusefot7ydMOdemd3zgdhjsIc0jYcnQdR1Aitwx9kVCfbRZoPz2wXR
        zKkjk94P2ff1kR4GSDHJXvelfzfywJqK2Tu+z+mcWzWzn6jzhlVe6Bi440G2CzeA/R/1Pq
        03tDaqgk4u8EIRq3DxyO9SUkmPRngP2xN898XsMqVSYXGc1OxM5SJqVKoS3QH87BHfPT1E
        j8T9l7OgwPNuX04QPiKZQ8IyAJzpT4poYPuejjwt0gnJtgg2xVcSh21dRbNw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1680735683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSJlqyeviMid9tt8kMPn4LHVojXi4rRhOyyvndEVdl8=;
        b=yFwYS6akqPfm8vPLcHMRIWQsQdzpYYNL4pHowrhnSVqyHkvnbuFfPlDksCIaihUrEq8E/e
        tqPcggtjzIKaBSeQu81mzrK8ORFgRc44KDbPchOsCBJC2asb3tilsX7iv6czxbnsoGgVFF
        xMzjY02a6pSuh64fGxNYrYBxU+2ye2ZIDRsHqr1EsDGwSmcyqSZXPpcNFsYSmKPBtssLeq
        7bDbn0ujtubbP8ls1I0JeiGi7lpgT23oDQB9GNWhM1JUIcVvRKFEEKHszFTecez9WeR115
        IYBYCBC6BmywVQgUofVSIveShjfjKg55sfIFj68YOok8NrOFjUFMDstpZSorVw==
ARC-Authentication-Results: i=1;
        rspamd-5468d68f6d-rhlvx;
        auth=pass smtp.auth=instrampxe0y3a
 smtp.mailfrom=mail@christoph.anton.mitterer.name
X-Sender-Id: instrampxe0y3a|x-authuser|mail@christoph.anton.mitterer.name
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|mail@christoph.anton.mitterer.name
X-MailChannels-Auth-Id: instrampxe0y3a
X-Abaft-Trade: 30b683213082218c_1680735683473_3903482944
X-MC-Loop-Signature: 1680735683473:1567849817
X-MC-Ingress-Time: 1680735683473
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.97.48.124 (trex/6.7.2);
        Wed, 05 Apr 2023 23:01:23 +0000
Received: from p5090f69f.dip0.t-ipconnect.de ([80.144.246.159]:52994 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <mail@christoph.anton.mitterer.name>)
        id 1pkC7y-0000dD-0a;
        Wed, 05 Apr 2023 23:01:21 +0000
Message-ID: <1e3a5757e9eeb438a4fcd5f7af8778d311dda5fa.camel@christoph.anton.mitterer.name>
Subject: Re: fstab format, 4th field mandatory and the "sw" value
From:   Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Date:   Thu, 06 Apr 2023 01:01:14 +0200
In-Reply-To: <20230404101311.3avcw3oldefbdzs6@ws.net.home>
References: <45fc7a385b006d734011a11487fbfdda4333644e.camel@christoph.anton.mitterer.name>
         <20230404101311.3avcw3oldefbdzs6@ws.net.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: mail@christoph.anton.mitterer.name
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hey Karel.


On Tue, 2023-04-04 at 12:13 +0200, Karel Zak wrote:
> I have committed:
> https://github.com/util-linux/util-linux/commit/43a6b183d8945cc91307f21adc8070254eb925b5

I think it's fine.

Thanks for the clarifications.


Cheers,
Chris
