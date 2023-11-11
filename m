Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3C5C4332F
	for <util-linux@archiver.kernel.org>; Sat, 11 Nov 2023 19:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjKKTK2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 11 Nov 2023 14:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKTK1 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 11 Nov 2023 14:10:27 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD67258E
        for <util-linux@vger.kernel.org>; Sat, 11 Nov 2023 11:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1699729821; bh=jhOnItHrkqaKM++0mqHtCIeBDrIhKGVIgYmX+p008bo=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=pjFy5EW/BoEaxpvZaJpcpnF/VQV4NQPjLULv4kFMrVtG8hXOMYAUz1eE/ZUMHv6lv
         vhg6B9Y0e1+F/Q7+9lyMmq99DVvXlayjZHoQppl4n/hZ1tQa+INdJAmkHoRzLHB0KK
         teSYtBWhGNXoCptpGRggZftRiXXSFczk5TB2LXkU=
Date:   Sat, 11 Nov 2023 20:10:19 +0100 (GMT+01:00)
From:   =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     util-linux@vger.kernel.org
Message-ID: <b5dcde27-d08d-4b2e-80df-1a1edf8e447b@t-8ch.de>
In-Reply-To: <dfb16443d2e030e2738d83a886572fdddc64f7ba.camel@physik.fu-berlin.de>
References: <2eedea423b789396d263ff4aef05736ea48d4f46.camel@physik.fu-berlin.de> <27dc0b31-bfd5-4519-b46e-c0bcafe0702a@t-8ch.de> <dfb16443d2e030e2738d83a886572fdddc64f7ba.camel@physik.fu-berlin.de>
Subject: Re: RFH: fincore/count lsfd/column-xmode failing on sparc64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <b5dcde27-d08d-4b2e-80df-1a1edf8e447b@t-8ch.de>
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Nov 11, 2023 19:46:08 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.=
de>:

> Hi Thomas,
>
> On Sat, 2023-11-11 at 19:37 +0100, Thomas Wei=C3=9Fschuh wrote:
>> Hi,
>>
>> Nov 11, 2023 19:23:20 John Paul Adrian Glaubitz <glaubitz@physik.fu-berl=
in.de>:
>>
>>> Hello!
>>>
>>> On sparc64 running Linux 6.5.0, the following two tests are failing:
>>
>> Which version of util-linux is this?
>
> This is on git master, so e0f3b02d5.
>
>> For the fincore test:
>> Can you check with strace if it is using the mincore or cachestat syscal=
l?
>
> I can't seem to spot neither in the strace log:
>
>> https://people.debian.org/~glaubitz/fincore-strace-sparce64.log
>
> Log created with "strace -o ~/fincore-strace-sparce64.log ./tests/ts/finc=
ore/count".

The log is missing the calls to the fincore binary itself.
Can you add a "-f"?

Did it work with an older Kernel?
Since 6.5 it should use cachestat. Before it was mincore().
Or disable cachestat via "enosys" from util-linux.

I can also take a look on Monday.
