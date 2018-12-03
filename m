Return-Path: <SRS0=GAnL=OM=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5568BC04EB9
	for <util-linux@archiver.kernel.org>; Mon,  3 Dec 2018 21:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F71B20851
	for <util-linux@archiver.kernel.org>; Mon,  3 Dec 2018 21:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F71B20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbeLCVhL (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 3 Dec 2018 16:37:11 -0500
Received: from mout.gmx.net ([212.227.15.19]:45203 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeLCVhL (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Dec 2018 16:37:11 -0500
Received: from adsiz.fritz.box ([95.90.40.253]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjZhg-1h5Cav2nFo-00bae4; Mon, 03
 Dec 2018 22:37:05 +0100
From:   Ruediger Meier <sweet_f_a@gmx.de>
To:     Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] include/c: re-add type checking in container_of()
Date:   Mon, 3 Dec 2018 22:37:05 +0100
User-Agent: KMail/1.9.10
Cc:     util-linux@vger.kernel.org
References: <20181202182345.3508-1-sweet_f_a@gmx.de> <20181203102304.xjslwg5e7rndfx7i@ws.net.home>
In-Reply-To: <20181203102304.xjslwg5e7rndfx7i@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201812032237.05106.sweet_f_a@gmx.de>
X-Provags-ID: V03:K1:TfU+GNAdUIW8F1VpWC9C8GL5dZMd9iqIJBEkjsCZgD8gxWERxim
 7macoe5o2cvOKxv8TrRaeVwKNvHO5OaH4YmRrQ3B2PSgFMDoyVuXlZ81ROOMQlzzPIO4/BR
 jPYNvbhk9SugCI4/FgLUSq3hG//kGwhvWCFzHvXWf9xaBEiL75yBLe39BSTqEE+nacouK05
 ozG5K+s44v6kT3eqGuvTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LUKgJuLrD/Q=:VlsGJ54hGWL9DiwTwnTO2t
 jEedvYT8OHE51fRrdo2vJYcF444HWaVSkevxTrz9pgUysmBnWG/UMV13N3wzQl07YPpCE1Zs3
 r/OXLPl/up8e+2bYzK2ISWXUXmPMuBb78Cen/NP9OGaLWamlAehubGaGAn0mzgAsd97pXTKuw
 JcYlPJcmb4TrKJkLAcJda9agOYq+rbOSNUw57g/HvxWUB9l28vthv3xbPMbiK7fU9Mq0+khO5
 e7esCaNQsSfPieodrHroV3zaT+zve1Mcw3G0VeHk/CQ1TuDruL3XGEQ3FNTcjSPQc7l0XAzmS
 fFyfKWq3BcwVHC3TSv00JaZhFNXHQKdN4aKDU2DDQuHaCx3JQ6vc9dOfdIHWFs1dIa5dJB0eQ
 NRD71oF09KIahd/+9oSl9ZQ9c1tugkbCd3Iy2+B0B0bZIvZ54vGxYmNgoe6XsmRR+QKOueej8
 YDSG/YB79ijb2fB87p1uAxaKRe6BH9xEUkuumuvwCcMTlXs0rbKohAs/EjcarzT8ChHJJn1Vp
 oZxiyOm/VDvb72MQZxm9h98lx4hOrov0GU7INoC4FBdJs9qkF1evR3JZ8fJloKKXPLEalAgik
 V7zOjODr5Wobip95/x09ok9wVySvk0AVGToXC/+kTLj1gcgQeAAkaCK+gcWV4Qrdw8u8Lfqsy
 /2T/kg+vYPchbqskRrwxwhkaB95d/MQbTXjyUAloUrQ7LFJLpxeMzf0Yw1lKmr/Lu4XWuNdGN
 9IB1MGmr1BYqGN5w7CXHzP0iIwgRaIi0svKRPpEsjGlpsWad947wbSMYJe2uENrVIGMPZwAk+
 9Yk2mvMlh+Tn5/rYXwOrhURZdojqYpHkgvJe8WccP8BZggwtCtLfVd7DMyyeAHzjLH+zQeL6X
 qXgGCEgm9+VveKRertZqv8Yh+gq4/cOMyfJ8MIdetAZELLa1twgN/OqK3DRdZz
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Monday 03 December 2018, Karel Zak wrote:
> On Sun, Dec 02, 2018 at 07:23:45PM +0100, Ruediger Meier wrote:
> > From: Ruediger Meier <ruediger.meier@ga-group.nl>
> >
> > This reverts parts of commit eb06d5d4, which seems to be based on
> > Linux kernel commit c7acec71. Unlike the original kernel patch we
> > did not add that even stronger type checking by using macro
> > BUILD_BUG_ON_MSG. So basically we removed a useful warning when
> > compiling such broken code:
> >
> >       struct st {
> >             int a;
> >             char b;
> >       };
> >       struct st t = { .a = 1, .b = 2 };
> >       struct st *x = container_of(&t.a, struct st, b);
> >       printf("%p %p\n", (void *)&t, (void *)x);
> >
> > Moreover we also introduced a new compiler warning for intel/icc:
> >    "arithmetic on pointer to void or function type"
> >
> > Let's just revert the update of container_of() because adding a
> > kernel-like BUILD_BUG_ON_MSG would be too much noise and also
> > problematic (see kernel commit c03567a8). Also note that the
> > original problem addressed by the kernel commit seems to be only
> > reproducible with gcc 4.9, not with any later gcc nor clang,icc.
> > Moreover, currently we have no such use-case in the UL sources
> > anyways.
>
> Interesting, I do not see any issue with list_entry(() now ;-)


BTW this is a nice webtool where you can see the issues quickly:

https://godbolt.org/z/Z2XvPc

cu,
Rudi
