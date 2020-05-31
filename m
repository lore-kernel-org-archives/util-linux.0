Return-Path: <SRS0=REj1=7N=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50908C433DF
	for <util-linux@archiver.kernel.org>; Sun, 31 May 2020 12:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC06206F1
	for <util-linux@archiver.kernel.org>; Sun, 31 May 2020 12:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Db8rk1Ni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgEaMSv (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 31 May 2020 08:18:51 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:39752 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgEaMSv (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Sun, 31 May 2020 08:18:51 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 1A06B2E0E0F;
        Sun, 31 May 2020 15:18:48 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id Tx82xIwJbu-Ilx0WVq1;
        Sun, 31 May 2020 15:18:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1590927528; bh=A+VX9f0FsYxRqTzGH2Ht6PLpnOJYqCgT8MWggeXXjHE=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=Db8rk1NiZTas5lnyq1ooEVnOMYL1yqzvW+CembDe5UY39E+ar2/Jawi5vaq7f3Set
         A3WZPPob9qKEL09d2Xnwg+FljcyyZhRQa76Qs4AByMtb//3O05cLfGIxavq+t7RBeg
         uc8hdT3D9BcOfH8Di7zMMwTAC+SKpgUnX+rN3x1g=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:1217::1:0])
        by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id exj4y8ukkC-IlWaG3MB;
        Sun, 31 May 2020 15:18:47 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] dmesg: add --follow-new
To:     kerolasa@gmail.com
Cc:     util-linux <util-linux@vger.kernel.org>
References: <159084767331.127122.9117317049390963928.stgit@buzz>
 <CAG27Bk3Tvybn0ToQdBNu9O-=Ap70+APKqLCCT-4cTxx-vFiFqw@mail.gmail.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <1d1e123b-d107-78c2-e76c-c5be3dcdf89e@yandex-team.ru>
Date:   Sun, 31 May 2020 15:18:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAG27Bk3Tvybn0ToQdBNu9O-=Ap70+APKqLCCT-4cTxx-vFiFqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On 31/05/2020 14.49, Sami Kerola wrote:
> On Sat, 30 May 2020 at 15:08, Konstantin Khlebnikov
> <khlebnikov@yandex-team.ru> wrote:
>> Option --follow-new (-W) works the same as --follow (-w) but initially
>> seeks to the end of kernel ring buffer, so it prints only new messages.
>> Useful for capturing kernel messages during actions without past log.
> 
> Hello Konstantin,
> 
> I wonder if it would be more useful to add '-n, --lines=[+]NUM' that
> would be similar
> to tail(1) option and argument. The --follow-new with an option that
> lists NUM last
> messages would be --lines=0
> 
> That said should --since and --until options similar to journalctl(1)
> be considered
> as well?
> 

I don't see how this could be useful. If anybody interested in past
messages then showing whole buffer isn't a big deal - it's only few kb.
Anyway, without --follow this is simply 'dmesg | tail -n NUM'.

Implementation is also non-trivial - currently dmesg reads and prints
messages from /dev/kmsg in a loop. It doesn't know how many lines left.
/dev/kmsg doesn't support lseek with non-zero offset, only SET/DATA/END.
