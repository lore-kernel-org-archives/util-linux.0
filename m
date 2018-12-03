Return-Path: <SRS0=GAnL=OM=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E299DC04EB9
	for <util-linux@archiver.kernel.org>; Mon,  3 Dec 2018 18:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D7C20848
	for <util-linux@archiver.kernel.org>; Mon,  3 Dec 2018 18:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3D7C20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbeLCSgu (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:36:50 -0500
Received: from mout.gmx.net ([212.227.15.18]:60581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbeLCSgu (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Dec 2018 13:36:50 -0500
Received: from adsiz.fritz.box ([95.90.40.253]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWkep-1h12sU3uVn-00XsPQ; Mon, 03
 Dec 2018 19:36:42 +0100
From:   Ruediger Meier <sweet_f_a@gmx.de>
To:     Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] include/c: re-add type checking in container_of()
Date:   Mon, 3 Dec 2018 19:36:41 +0100
User-Agent: KMail/1.9.10
Cc:     util-linux@vger.kernel.org
References: <20181202182345.3508-1-sweet_f_a@gmx.de> <20181203102304.xjslwg5e7rndfx7i@ws.net.home>
In-Reply-To: <20181203102304.xjslwg5e7rndfx7i@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201812031936.41163.sweet_f_a@gmx.de>
X-Provags-ID: V03:K1:YEOBfJtkL1liP4NDQuzvT4XVfOGMZWyKoCF6Q30+0gMbCRgAekY
 VONM9b7lBmMhl7Y9YtcTjs3zZjFKU35Qm0kc4+opEybyaV1hBjs/jFTb3uqoO5k5l++xJif
 mjG3tcKPFaNLHY3aw9HrUAIWnz/cHS1K+UOd0gZgT7WhdRTAgj4G/Wb1d3YxEpO4DcYXbeP
 G3ogQU2lb2b21vQ5i/WQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Hi7l6sVh7M=:3w/G9DIjh+5z4RsfAYbFxm
 hD5LqTCs+BN4MDF7yD6WEhYKhDjbAVm01bf/Xaa4K8ed3yDS1kkjP1dpGSxyLW+6BLIomXUUT
 KgqMQqoLmBJncw1pE41CgnZgkcX9Z0tz30CZ3ohTWwO1ogaTl305zivxMVnAqJ3rS+7t1LBb2
 GxO73ouNu2TOupc0UOgDMwttA0t6JubDSEjqSM0+7r1PPei4LELDBCqaOEEU4F58BBkQ5eWNW
 Gh8Jk7ycsDFyKeqttIPwBBvV3fKL6unH6sj0RSQInltPi1N6cIHH+HAP7f9gP4Rbma/a9DKPs
 /wkySg2y9bxf9QioKaeohw91xUXXL8d5M12bRadI1DHj0Y2H9C+fFfkTAw8oQm5SD5Ulnx6O0
 l212qJDK2WwQ1uXuqDEMM+0TYyvNsBAmYxs9JCfy7KXzIMSzLFpajnd4mj4NWlj/PdbAV9eHz
 //QmEMf/a/rwM2UO/UdlKuRpo/GBpA5k4PNVvMS97dGEiyK6LkzyYnMLPTYvS0M8SKIUtx0dO
 7G9XiglfHnaVZ8PTK3IOlpwFMC67LFAkl2L6TqtHJYroMC5TyG6UxrLzA73lkmp+JIHcHakF6
 zrR3FB9D2DIk7jfQz6K3mdmq2tZwaaPza11dmn0/SsI94N/LiVAnX/2Xpmv3Sux7JzytOsVMz
 AYjQr2ixk7Oc9fcWpXoqOfqIW54WauZZGlu4vfO2YxE6Ilu/k3ArpPf0Feu+nmj6sY+lnpWhj
 UCf/HDljpxUPyS5s1QiQMfwq/GMgSGAg3Kr2XZGCtsFW2FiffxzhuVC6o0pTwzNHD1rtIOJjD
 WlrAesfQ7rneQ5Kc5n+PH7Xo4vjm7OfSHhw4l/AruQNfBxPAcJT30HKf4MrsppXefomJd7HH6
 R84WNzO377y80+RJPAv91DjBq8wtBn8wDKhskCZ12oWyn3f/gK36NKcc6JgxnX
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

Well, actually the macro would perfectly work as simple as this:

    #define container_of(ptr, type, member) ( \
       (type *)((char *)ptr - offsetof(type,member)) )


All additional stuff is only to get some warnings if programmers are 
using the macro wrongly. Unfortunately also some false positive 
warnings. That was and is still the only problem here ... 
overengineering ;)

cu,
Rudi
