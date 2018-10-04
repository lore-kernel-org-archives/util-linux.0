Return-Path: <SRS0=FLZc=MQ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79894C64EB8
	for <util-linux@archiver.kernel.org>; Thu,  4 Oct 2018 22:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E06920877
	for <util-linux@archiver.kernel.org>; Thu,  4 Oct 2018 22:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E06920877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeJEFGr (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 5 Oct 2018 01:06:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:43981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725758AbeJEFGr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 5 Oct 2018 01:06:47 -0400
Received: from adsiz.fritz.box ([95.90.40.253]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgqEs-1fK1vJ2n4A-00oC7M; Fri, 05
 Oct 2018 00:11:15 +0200
Received: from adsiz.fritz.box ([95.90.40.253]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LgqEs-1fK1vJ2n4A-00oC7M; Fri, 05
 Oct 2018 00:11:15 +0200
From:   Ruediger Meier <sweet_f_a@gmx.de>
To:     Karel Zak <kzak@redhat.com>
Subject: Re: [ANNOUNCE] util-linux v2.33-rc1
Date:   Fri, 5 Oct 2018 00:11:14 +0200
User-Agent: KMail/1.9.10
Cc:     util-linux@vger.kernel.org
References: <20180925104701.y2gwtwe2bquynap2@ws.net.home>
In-Reply-To: <20180925104701.y2gwtwe2bquynap2@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201810050011.14673.sweet_f_a@gmx.de>
X-Provags-ID: V03:K1:7hvqk3+ca3kzKknUkhGccTAHCfdhDTznL9GEL3RCytXqTzBW2mv
 1f13qGiyLjsKY/pju8SfgoGxYYm2Xe4Wm+eO8AXHKK32RkEgRdHC9qkOHTZ02lPRaiegVdy
 QQuBIyofyZbCP4tps0V2n0oj81JnXMsUNdbH+b+xiYAw1yVu+97Fd5bRS+nSCCM/85hPv9O
 fiOEyX2WRpjHI6lRKcFEg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Xaymah/JK8c=:zuNXE/RGzvWwMFuvHV3EMX
 SXHC1+PKAZgQ1elIr7yWL88jvYSsuSzv5V24eNAbjiuEkQzfElQtstcX2lWQfvaJAS+Qi3lFd
 Lfh3NOErPGSMFJ2DBoDS3uGkB1kXdV7+TlbPpSEBPNNZCmfnscVhBgUvcSCsR+FZJLUi2IIRm
 InbQhSNYUNmlw6xPqk/SmueCxw41CNlMqtA9tqEx6yMSkgB9DNCmc8vpyL5rSSYYsbMJirRZA
 WCRscRQxNJVYdkOqGlZ/W11ld2RV05xhB9et94S6Fv4w0ej2FklSvNIgOY8DRqh+E4Z72FMvy
 2yzdZTy2y8PVhKDB2jHZHDk9A0dGRUniy0pTxGWo7Au61AfH1nqWVPjLegJcvIScB8nsWbMN2
 bwmkUtiGXms4khf7DVRDKF0PkgPRdNf0nS4p/umS3ZyWH8slRSxPbxrR4IimcpYCaTeuLZCmw
 Hq9BJ/Krw+fk4ZAh8kIfYr9XplIsvcLp+60aBekWcK2TGe2nb1Hua+4QYQxPdoXs7WVPQDSva
 sKD53MdJhmLzH2YodDBMK15TjTQx+W/4A4AgkD4h0cZk7ytrITlRb6MSeT1AKjsmfG2YCWjyS
 0MPpcyF7/JFKoFNTUXPFVm6kXrBBPzVQauVqd6h+xLHACUrhnQMG/XmJ2fzFT18wM8DqPLng5
 mfSVpMWeH3SAi8wszahicytLFu7s5RBbfjr2HdDBU4AgN2X5KGbhbr86/QHKv46nZ7r4aHwUf
 +x+zyjH1wZev2rnQQ5bPnLMrR+801BqoruqxjAHjL6JLLUd//sJPZGz2dpn7IRcYzCOpkmoy/
 E+Mm5NLvmevHv77Rie2xwF7ndsKyw==
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org
Message-ID: <20181004221114.dHwo2zpFzctL-lNeML54BB3lbTgEGIcdLZYevfn5sOs@z>

On Tuesday 25 September 2018, Karel Zak wrote:
> The util-linux release v2.33-rc1 is available at
>
>   http://www.kernel.org/pub/linux/utils/util-linux/v2.33/
>
> Feedback and bug reports, as always, are welcomed.
>
>   Karel

There is one build issue with setns() usage in libmount/src/context.c in case
we don't have it neither in libc nor the syscall 

[...]
checking for syscall setns... no
configure: WARNING: Unable to detect syscall setns.
configure: WARNING: setns syscall not found; not building nsenter
checking for setns... no
[...]
./.libs/libmount.so: undefined reference to `setns'


cu,
Rudi
