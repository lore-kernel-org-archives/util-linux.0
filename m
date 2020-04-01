Return-Path: <SRS0=zPEu=5R=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB15C43331
	for <util-linux@archiver.kernel.org>; Wed,  1 Apr 2020 16:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608FC2071A
	for <util-linux@archiver.kernel.org>; Wed,  1 Apr 2020 16:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="H6/DSeMZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgDAQF4 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:05:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:50893 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732146AbgDAQFz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 1 Apr 2020 12:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585757153;
        bh=K+IrPIXtPVFRt3mesTPer4FKnExc+lM3ms3pI4HsDEg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=H6/DSeMZTwoklrQ1e+P0o2O/k8KALFis8EQzxdL7eCr5TSgE0w13l+3SRcla2w+LB
         XXDhfuQOrJvK+inEFtIkIv3jsFAD3HxV2jUakLjsSJ30dFA4TfTO/pyTlUagmFfObb
         1IJFUIfTrZhYnZke+WlITikEkG33ElQ5aNHIdW2Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from mua.gmx.com ([68.56.186.98]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MZCfJ-1jolNZ3YX3-00VCCl; Wed, 01
 Apr 2020 18:05:53 +0200
Date:   Wed, 1 Apr 2020 12:05:50 -0400 (EDT)
From:   J William Piggott <elseifthen@gmx.com>
To:     =?ISO-8859-15?Q?Aur=E9lien_Lajoie?= <orel@melix.net>
cc:     util-linux@vger.kernel.org
Subject: Re: [PATCH 2/3] cal: Correctly center the year
In-Reply-To: <CAA0A08WGSa1CxbtHt_qZHPStKcgoW37+KaYrZ9mqUUqKv4Bk7A@mail.gmail.com>
Message-ID: <nycvar.YAK.7.77.849.2004011116010.1352@zhn.tzk.pbz>
References: <20200328223341.11463-1-orel@melix.net> <20200328223341.11463-2-orel@melix.net> <nycvar.YAK.7.77.849.2003291015150.1315@zhn.tzk.pbz> <20200331134154.ok6zuym6w5p5sa2o@ws.net.home> <nycvar.YAK.7.77.849.2003311031020.1544@zhn.tzk.pbz>
 <CAA0A08WGSa1CxbtHt_qZHPStKcgoW37+KaYrZ9mqUUqKv4Bk7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463792383-2120555163-1585757152=:1352"
X-Provags-ID: V03:K1:tEazlZzY52S4JS5eiXVqN+gntqjB66xsRv52P+DJSytSAKBqmyz
 oF6NfRUm6D6rp18g6zOP2I//8vE6SecWjELzWi/GbA4/Mn5AmJX7XqIBMqeinDe6hJ0rHFW
 G+CPcR7oAsbnHmDTf0kIkBKmMFh+TBLeMVzkfWoFT2X1PeZgxATsHActDJmNvALwQ8vrFcU
 wX8Mz0te+LR9WrCXXXbaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jBgFP/E44Hk=:0IC1llsO4N7WuCVbDNOtbf
 JLkw69XpK3kDF/4cIFN/h6z3BY7tkuy5bUEZQNo9EEf/TuvwOaM3m/ETlDT60jXf4cKo9Nxzh
 GBtR3+t95z1vWz5X+smQrnB423vQvCp34J0oV/loJmz/R9A+aOIuvmS3FUFpZJBj6c8nisjSF
 28AjfSMF7CM42nzTNxs6RAYFvVr+cXtP4jZaehBvGW5b12tXJPKNs/AjrpBnixeNZOR2bMDdf
 AqInkL6lnJQv9HthSqeKh0Gzwuivz4FZPYRN/Tb2UO5e0aiHa/sBnMAXdgQFlvQ04bKeNU0Ze
 DmZaPHDH+RSY/1/7kTrdYLaXbAEay54r1/RHsONO+LXr8h0Z4Rz/0g3mf8WIp5vfm/4SIhlBK
 csFdYhvOExPSRfP0G0e/weQ/CtpifcEblH8xsAkSMetlO6JCt487KRG1ajCP8M+XYHFERR/Z2
 hXNa/m0ZSkKCmGwLITnVHBrg8AP9U1M3vi/FdlmMXSVNNVIWr+7+Pu95ofelY3rlBMUcKBQoZ
 NLLXa3ukakLXprKPIXQdd41MqBmkgSMUwn/UaRXvJcWuYUCyCytznmNR10ybtiUWtYdgQL34r
 u5+UA8Ks/iZR8y8lYAusyoxMemSt8cSxJXv8RkF87jKlT9dySBKCLKoemJhi0oJZidOYr07bQ
 cYdMeDmdB9HMyL38VkoETQn6g70se37Wt/bnuQTiFM9M3o0WrKptsuMkqEQ7ZBloZ3f5syrZd
 e/5DgSiUNqcg5keqYcWa7sXUWg9GhQptY0tMpHg/BwsnfBYFrdGxQaSedyVJEa0LETMnMClWL
 o12XnQRbK1NTowoblX+AO/f+95kKBxC960lynd8pEWEhHKLENa3zkLGiqvTbrDLrpgsDbw4Ba
 LDNRL7/IWgiOzORme9xQAWIMgK9ab59MJwl7NeIOHLn7D0yeQVNBhUYaoq5oXgZ0gLfnknNiq
 fOoUlSI8bk1JBBqJ5yIzi7i3r3cecC5Ody84fHYeEX3k62msbpRSrOdpDA6EgHP0jvG6kHkGn
 7ad+klj/OivnmpmLlewauQSGb1CKDKM/i2TNfVMkNb8YNja923f4PmtWi2ZR6Va1C+GY9XUCW
 /w1ZL05yyf59Dg+M7pU0bOkmcoYO8QoZ+d2+M52IF9J7I9cmRqKf3LRHbohXITJEeKy5/nNoC
 1/PTXpXis4bcQ08jf6S3hsp1pmydPqksl94bKqaC/62JpTZ5JPgKU+qc9gHBy4sPOmFkQC9y9
 un0LCn1AmI+W6e7I3
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463792383-2120555163-1585757152=:1352
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On Tue, 31 Mar 2020, Aur=C3=A9lien Lajoie wrote:

> On Tue, Mar 31, 2020 at 5:07 PM J William Piggott <elseifthen@gmx.com> w=
rote:
>>
>> It seems like this trend stems from Apple. Jobs was fanatical about
>> form; but what seems have been lost, is that he was equally fanatical
>> about function. He required that both be satisfied. I cannot find any
>> function in cal's year header. Can anyone offer any?
>
> I was not thinking triggering such discussion about cal.

No worries Aur=C3=A9lien, the year header is an unresolved (for me)
discussion from long ago. When I take time to make, what seems like, a
logical argument for a change and only get subjective or fiat responses
it makes my head explode or something. I like coding because it is
logical, I guess that is the way I'm wired.

> I don't know if my argument is a good one, reading the code I have found=
 that
> for some locale the room available is not enough to put the month and
> the year on a single line.
>
> If someone can give me example of one or two locales with this issue
> to do some test, I will appreciate it.
>
> So I think for such locale it is better to have the year only at the top=
.

* the same issue is present for 11 months and 13 months. What makes 12
   months special?

* it scrolls off the screen leaving the viewer with unknowable information=
.

I just think the output is far more functional if the year is always
visible. For locales with long month names that would wrap, use
abbreviated month names and/or 2 digit year. Worst case, use numerical
month label for such locales. What do those locales do now for 13 months?
Is there a locale that breaks the current 13 month output?

> And this behavior is closed to the physical calendar and classic year
> calendar as you can see on google image "year calendar" search.

Well, that is my complaint of choosing form over function.

> So I think we can keep it as it and add an option to change the
> behavior (--noyear-header as Karel has proposed)

No need for that; the upstream changes I attempt to make are not for me.
The cal(1) on my system does exactly what I want it to do (including
telling me when it switches to an entirely different calendar system).

> What do you think about adding options -A and -B as in ncal ?
> [-A months] [-B months]

I have not used ncal; didn't even know about it, to be honest.

Anyway Aur=C3=A9lien, pay no attention to me; carry on with your work. I'm
done now.

---1463792383-2120555163-1585757152=:1352--
