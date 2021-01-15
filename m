Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367F1C433DB
	for <util-linux@archiver.kernel.org>; Fri, 15 Jan 2021 20:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0753523A5A
	for <util-linux@archiver.kernel.org>; Fri, 15 Jan 2021 20:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbhAOUPp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 Jan 2021 15:15:45 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:53771 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730515AbhAOUPp (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 15 Jan 2021 15:15:45 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l0VUt-0016o0-OV; Fri, 15 Jan 2021 21:15:03 +0100
Received: from pd9f74830.dip0.t-ipconnect.de ([217.247.72.48] helo=[192.168.178.23])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l0VUt-001qwM-46; Fri, 15 Jan 2021 21:15:03 +0100
Subject: Re: fsck needs /dev in path to check an ext4 partition
To:     Jonny Grant <jg@jguk.org>
References: <5483a74b-106e-1c6c-0265-55ed960826d8@jguk.org>
Cc:     util-linux@vger.kernel.org
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <4930f03e-dbd0-7a2f-4b56-9f7cef88d9d2@physik.fu-berlin.de>
Date:   Fri, 15 Jan 2021 21:15:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <5483a74b-106e-1c6c-0265-55ed960826d8@jguk.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 217.247.72.48
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hello Jonny!

On 1/15/21 9:06 PM, Jonny Grant wrote:
> Apologies I am not using 2.36.1 yet. I'm on latest Ubuntu LTS, but it's using 2.34
> 
> I noticed fsck only works if I write as "/dev/sdb1" not just "sdb1" I was in /dev/ as
> root, so it shouldn't need long path?
> 
> These work as expected when called from /dev/ as user root
> 
> # fsck.ext4 sdb1  
> # fsck.ext4 /dev/sdb1  
> 
> This does not work:
> # fsck sdb1

That's because it must be:

# fsck.ext4 ./sdb1

Filenames are expanded by your shell in this case, not by the fsck utilities.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

