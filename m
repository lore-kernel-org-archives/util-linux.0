Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD54C6FD18
	for <util-linux@archiver.kernel.org>; Wed, 29 Mar 2023 13:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjC2ND3 convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Wed, 29 Mar 2023 09:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjC2ND2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 29 Mar 2023 09:03:28 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96E2139
        for <util-linux@vger.kernel.org>; Wed, 29 Mar 2023 06:03:25 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|mail@christoph.anton.mitterer.name
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E008B3409AA
        for <util-linux@vger.kernel.org>; Wed, 29 Mar 2023 13:03:23 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 071213405FE
        for <util-linux@vger.kernel.org>; Wed, 29 Mar 2023 13:03:22 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1680095003; a=rsa-sha256;
        cv=none;
        b=bF9NoK8KHlDF8zdR10DSD+XTqfggYN1hsiT7JonZhf+cPn9FpHew8htMVbbrLBbxgv9Prd
        i40F8TqbIQzcB+YbOEYQ3CAdEUiH2fE1FLiIyf0GEcGgp0hr1mITVWVlwY+4pRH3hPRF86
        TQVvxEWNu7YleDQYqT1Sq/hXh6xlIGTE05t0pOIwGMFK2xkWBLxFw5Pmmd+bemgG+RGPSY
        WU60ko/prsoPTnINoUKG5+6Vpmevn92W7r3OJgXgEyr5KFmiHl3qvbEs/8JQQUdVJaRFBM
        s01SKtr9ZcwnxkTbp/tiSefuA3jryOhzu6ZpOrKZji6JWEWZGx2THJPgFNc2Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1680095003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KEOhFiYzvNwdrrMSmpfSg/ErL+vPnbCsgRMEZfEga7Q=;
        b=x6GYske+vZqDphW0kt6zloqYB1Ao0UFwHKqzg0PN0Tt6tA2/2NauERC0KpNH8WX9W84nE5
        gur4izlOvZfhbKw0WgZhzckaIjANl0EaIhfVpRPONBIJWrFMNAbTDi1II2wDNsFMwKTxVO
        /Ngjo8148JJ1ww6IcgtsYWvD/bn9KbWky8v5SRQb88nmheivb2KKWKlQ/olB3yN4Hx+7nW
        z9ZUX7q0P1A//TWstDEfOOdAF0aTOmXeRz7Em49GmH15UxD2uGhymP/TYGiXlpdcyFV9lj
        RpGOb+uPKpmZxaf5qBcA0arZh2Np2TEvWglmeDazu2cXW2BSTIFmJSUHBAAYAA==
ARC-Authentication-Results: i=1;
        rspamd-66b58c76b9-488z5;
        auth=pass smtp.auth=instrampxe0y3a
 smtp.mailfrom=mail@christoph.anton.mitterer.name
X-Sender-Id: instrampxe0y3a|x-authuser|mail@christoph.anton.mitterer.name
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|mail@christoph.anton.mitterer.name
X-MailChannels-Auth-Id: instrampxe0y3a
X-Cold-White: 7664b9511be650ac_1680095003537_2361116909
X-MC-Loop-Signature: 1680095003537:3292662440
X-MC-Ingress-Time: 1680095003537
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.126.30.44 (trex/6.7.2);
        Wed, 29 Mar 2023 13:03:23 +0000
Received: from dhcp-138-246-3-245.dynamic.eduroam.mwn.de ([138.246.3.245]:55830 helo=[10.181.105.111])
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <mail@christoph.anton.mitterer.name>)
        id 1phVSR-0006eW-2D
        for util-linux@vger.kernel.org;
        Wed, 29 Mar 2023 13:03:21 +0000
Message-ID: <45fc7a385b006d734011a11487fbfdda4333644e.camel@christoph.anton.mitterer.name>
Subject: fstab format, 4th field mandatory and the "sw" value
From:   Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
To:     util-linux@vger.kernel.org
Date:   Wed, 29 Mar 2023 15:03:16 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-OutGoing-Spam-Status: No, score=-1.0
X-AuthUser: mail@christoph.anton.mitterer.name
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hey.

The following is in principle just cosmetic.


I recently wondered[0] what fstab entries for swap areas should look
like.

Some resources recommend e.g.:
  <swap-device/file> none swap sw 0 0
others somehting like:
  <swap-device/file> swap swap defaults 0 0


fstab(5) describes the appropriate values for swap for fields 1 to 3
(inclusive).
But it gives nothing about the 4th.
Neither do e.g. the manpages mount(8) or swapon(8).
Especially there seems to be no longer any mention of "sw"

getfsent(3) still contains a reference to "sw",... seems it comes
originally from BSD.


"default", which is documented as:
> use default options: rw, suid, dev, exec, auto, nouser, and async.

doesn't seem to be the best choice either.

Personally I'd have said that - from the documented values alone -
"auto,nouser" perhaps in addition with "rw" might the most fitting
choice.

fstab(5) even seems to make either "rw" or "ro" mandatory, by saying:
> It contains at least the type of mount (ro or rw)

which I don't thin is however really enforced (neither would it mention
any such thing for auto vs. noauto).


In the thread at [0], a participant suggested that the most appropriate
entry would be simply:
  <swap-device/file> none swap
i.e. omitting the 4-6th fields.


However, at least by fstab(5), the 4th field (unlike #5 and #6) does
seem to be required.


*If* fstab(5) is considered to be like a formal description of the
fstab format it would be nice if the following could be clarified:
- Whether or not "rw" respectively "ro" are really required (or whether
  absence of both of them (and absence of "defaults") causes an
  implicit default to be used.
  The same for auto/noauto.
- Whether he 4th field is mandatory and if not, what that means.
  Is it the meaning of "defaults" or is it nothing except for the
  "implicit defaults" of ro/rw noauto/auto?
- Whether or not the other special values from getfsent(3), i.e. "rq",
  "sw", "xx" still have any meaning for linux (and if it's just that
  they're ignored)... and similar as it's done for fields 1-3, what
  should be used for swap areas.

Along with that, it might perhaps make sense to replace "swap
partition(s)" with "swap device(s)", as a swap device doesn't need to
be a partition.


Thanks,
Chris.


[0] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1033630
