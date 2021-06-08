Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B788C47082
	for <util-linux@archiver.kernel.org>; Tue,  8 Jun 2021 17:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D39161351
	for <util-linux@archiver.kernel.org>; Tue,  8 Jun 2021 17:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbhFHRRz (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 8 Jun 2021 13:17:55 -0400
Received: from frv72.fwdcdn.com ([212.42.77.72]:58840 "EHLO frv72.fwdcdn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231278AbhFHRRz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 8 Jun 2021 13:17:55 -0400
X-Greylist: delayed 955 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jun 2021 13:17:55 EDT
Received: from [10.10.17.75] (helo=frv155.fwdcdn.com) by frv72.fwdcdn.com QID:1lqf5D-000JRt-7t/RC:1; Tue, 08 Jun 2021 20:00:07 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ukr.net;
        s=fsm; h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=l5G0762gLMdxQphN1gvbZqaQr5OegF+SlyKf7+WQwr0=; b=QHMhsbIee0xTWgvORgKlQLpDaz
        s5e99i2c5bTkT6q/R5HJ4vecDVC/f1U0VBSgq+pnPyRzloUgIJvcX5PAoEGPZnnqvMoA/f0rUsZpr
        DYlcs6KnGWXIa3/GtBqi9kAzY2vaRXW5ZNjL51OmBrl/BS1H2kqpuQcx8Y5kv3zfh9VM=;
Received: from ip-4ffd.proline.net.ua ([93.126.79.253] helo=localhost.localdomain)
        by frv155.fwdcdn.com with esmtpsa ID 1lqf5A-000N7n-V2
        for util-linux@vger.kernel.org; Tue, 08 Jun 2021 20:00:05 +0300
From:   Yuri Chornoivan <yurchor@ukr.net>
To:     util-linux <util-linux@vger.kernel.org>
Subject: Re: Translating chsh
Date:   Tue, 08 Jun 2021 20:00:04 +0300
Message-ID: <2067176.irdbgypaU6@localhost.localdomain>
Organization: S.P. Timoshenko Institute of Mechanics
In-Reply-To: <fd0b3838-845f-91fe-3983-507dea56ec8f@riseup.net>
References: <fd0b3838-845f-91fe-3983-507dea56ec8f@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Authentication-Result: IP=93.126.79.253; mail.from=yurchor@ukr.net; dkim=pass; header.d=ukr.net
X-Ukrnet-Yellow: 0
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

=D0=B2=D1=96=D0=B2=D1=82=D0=BE=D1=80=D0=BE=D0=BA, 8 =D1=87=D0=B5=D1=80=D0=
=B2=D0=BD=D1=8F 2021 =D1=80. 19:49:08 EEST Porrumentzio =D0=BD=D0=B0=D0=BF=
=D0=B8=D1=81=D0=B0=D0=BD=D0=BE:
> Hi, I want to translate chsh, which I suppose is in util-linux package.
> How are the translation managed? Where should I send the edited files?
>=20
> The PO(T)s are only in /po and /po-man, from the root of
> https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/
> <https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/tree/>,
> right?

Hi,

util-linux uses the Translation Project for translations:

https://translationproject.org/domain/util-linux.html

https://translationproject.org/domain/util-linux-man.html

Hope this helps.

Best regards,
Yuri


