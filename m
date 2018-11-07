Return-Path: <SRS0=MPMV=NS=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC528C32789
	for <util-linux@archiver.kernel.org>; Wed,  7 Nov 2018 01:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AC62086A
	for <util-linux@archiver.kernel.org>; Wed,  7 Nov 2018 01:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05AC62086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=datacom.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388934AbeKGKxF convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:53:05 -0500
Received: from mx.datacom.ind.br ([177.66.5.10]:39170 "EHLO
        mail.datacom.com.br" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388864AbeKGKxF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 7 Nov 2018 05:53:05 -0500
X-Greylist: delayed 318 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Nov 2018 05:53:04 EST
Received: from mail.datacom.com.br (localhost [127.0.0.1])
        by mail.datacom.com.br (Postfix) with ESMTPS id 407061BA366B;
        Tue,  6 Nov 2018 23:20:09 -0200 (-02)
Received: from localhost (localhost [127.0.0.1])
        by mail.datacom.com.br (Postfix) with ESMTP id 327AA1BA3667;
        Tue,  6 Nov 2018 23:20:09 -0200 (-02)
Received: from mail.datacom.com.br ([127.0.0.1])
        by localhost (mail.datacom.com.br [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c50DDepolvln; Tue,  6 Nov 2018 23:20:09 -0200 (-02)
Received: from mail.datacom.com.br (mail.datacom.com.br [172.25.4.13])
        by mail.datacom.com.br (Postfix) with ESMTP id D034D1BA3661;
        Tue,  6 Nov 2018 23:20:08 -0200 (-02)
Date:   Tue, 6 Nov 2018 23:20:08 -0200 (BRST)
From:   Carlos Santos <casantos@datacom.com.br>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     Karel Zak <kzak@redhat.com>,
        util-linux <util-linux@vger.kernel.org>
Message-ID: <987477353.537443.1541553608738.JavaMail.zimbra@datacom.com.br>
In-Reply-To: <20181106123402.cy52t2ql4yvfqme6@function>
References: <20181106113306.hd2qcvbde22cxur6@ws.net.home> <20181106123402.cy52t2ql4yvfqme6@function>
Subject: Re: [ANNOUNCE] util-linux v2.33
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [189.27.237.170]
X-Mailer: Zimbra 8.8.10_GA_3047 (ZimbraWebClient - FF63 (Linux)/8.8.10_GA_3041)
Thread-Topic: util-linux v2.33
Thread-Index: 11OKW8jC04pjjs5LzgFcBHBsDCdnMQ==
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

> From: "Samuel Thibault" <samuel.thibault@ens-lyon.org>
> To: "Karel Zak" <kzak@redhat.com>
> Cc: "util-linux" <util-linux@vger.kernel.org>
> Sent: Terça-feira, 6 de novembro de 2018 10:34:02
> Subject: Re: [ANNOUNCE] util-linux v2.33

> Hello,
> 
> Karel Zak, le mar. 06 nov. 2018 12:33:06 +0100, a ecrit:
>> The util-linux release v2.33 is available at
>> 
>>   http://www.kernel.org/pub/linux/utils/util-linux/v2.33
>> 
>> Feedback and bug reports, as always, are welcomed.
> 
> It seems new portability issues came in since the rc I tested :)
> Fix attached.
> 
> Samuel

Could you please explain what portability issues your patch fixes?

Also, could you re-generate the patch with git format-patch and add
a Signed-off-by line, so I can use it in the Buildroot package?

Thanks in advance.

-- 
Carlos Santos (Casantos) - DATACOM, P&D
“Marched towards the enemy, spear upright, armed with the certainty
that only the ignorant can have.” — Epitaph of a volunteer
