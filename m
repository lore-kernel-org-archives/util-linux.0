Return-Path: <SRS0=1kTP=O2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B615DC43387
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 20:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8918F20874
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 20:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeLQUp0 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:45:26 -0500
Received: from mout.gmx.net ([212.227.15.19]:54559 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbeLQUpZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Dec 2018 15:45:25 -0500
Received: from adsiz.fritz.box ([95.90.44.148]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MFMEG-1geYCd3MCC-00EJZX; Mon, 17
 Dec 2018 21:45:23 +0100
From:   Ruediger Meier <sweet_f_a@gmx.de>
To:     Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] fstrim: add random delay to systemd timer
Date:   Mon, 17 Dec 2018 21:45:23 +0100
User-Agent: KMail/1.9.10
Cc:     util-linux@vger.kernel.org
References: <20181217124422.13334-1-mail@eworm.de>
In-Reply-To: <20181217124422.13334-1-mail@eworm.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201812172145.23296.sweet_f_a@gmx.de>
X-Provags-ID: V03:K1:+TnnxvNMo/kYjDIlk0HSLxDa1Q5TsLCgPhQ+SZ9FwGTYh/SrBjV
 RtHQJKLbg0RdIVrXen4FQ3x5VFXBe7GT0DO47CgNgxsii2M2t84vcdj9a+T+orCqW3nBvVD
 80aBD93xR97QWQ28veIZMDnjhuEO013kfPodRPMojY4tiplk4rlbVpM4aRcRqV+g+lzPkSf
 mcRkXJtteWGPX0FTT+3ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Dnq1ntYdjWg=:YO2Fud5GtFtKZIFBlCnUej
 gN2nUxeVRTKsvYr/ryooSGc+fqFOtsaiy1TtFZmXIT0tmzABoyMC9RxuNUXmcDNw6g8rtU2a8
 dl7Re0evR5Y3vptFMW0qhZC9Zg0cbEb5WA8t1Gh7dvHbtN7cQ5bO38x7100SToACgXph1SlW6
 0R9yge/CPrUxJnrPeDmoptZ82RXFFhyt6MG7rlZDxf2wt/Mrnx+QRYJicAs6VnEYBMPpSIdxx
 a6EIA3Zmn/uXxFd6LYvzpoQfymiJJ7OLBtnRMS0wVd6QqlsccTy/iJWrSi0a6dM2V5MbJatZ5
 A48xE/xeoCrzEVrk4og72F79xSzIjoisov49vdx4M7qmj9zt+pL7GJrN5d1eWIG9RufuAKr8q
 w90/Ce27aWKsqn/NEazEpbnks4zldPE3GtiNGNpXIme66d/uBeWRKY6wr8+84A7s+kfA5cbnD
 GQgyUFpchs3H6n5ffLtTs7X4meS9u0PIR6WYRh06gO6lt6/ej5DCd2sNmoSR37y7zIPl/o0eL
 qTeJlhjC2uh3yzVCLPPPyMzZWSaEMpNFqHNuOgJco44Se0rPhlZdqTrEMQgwyRbP/FpzRqKmF
 EXi7trJ9zppqlLroVEWeAz/RharR7YqUvfKabghuQ9bDhbXISMAGr3hEgD1NmD3p9K+l1NMkm
 Gnna1B2dQs6S7LFKznpPK2woXUYQ4jLIlwMypfHvqpoVIxZLQxMm2YOhK9+d9HY59+WDUFcQr
 i0lrg7k3q8mZA0uiC4fBpS28AA/ndNncPad+Q4Ae7hzEZ6yhaxMWjMa32E0tCREMep/WhltGC
 PkP4QmvaNJejLBziIhB1df9PcpFthmXOaldL+O2rXIumCsGzryE/faoc/xz0SJrwVtj6hGiqB
 ednP8DH1ekK1RUFIZUSRo1TPrL8O6qFxV423+i6hQ=
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Monday 17 December 2018, Christian Hesse wrote:
> The fstrim timer tends to fire simultaneously with other timers like
> updatedb. As fstrim is not time criticaly let's add a random delay of
> up to an hour.
>
> Signed-off-by: Christian Hesse <mail@eworm.de>
> ---
>  sys-utils/fstrim.timer | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sys-utils/fstrim.timer b/sys-utils/fstrim.timer
> index 3a3762d5c..dd3328e2a 100644
> --- a/sys-utils/fstrim.timer
> +++ b/sys-utils/fstrim.timer
> @@ -5,6 +5,7 @@ Documentation=man:fstrim
>  [Timer]
>  OnCalendar=weekly
>  AccuracySec=1h
> +RandomizedDelaySec=1h

Looks like it could still run simultaneously with other timers at random 
times. So this does not seem to be a real fix for the problem described 
in your commit message.

You may look at /etc/cron.{hourly,daily,weekly,monthly} if you want to 
run such jobs one after the other.

cu,
Rudi
