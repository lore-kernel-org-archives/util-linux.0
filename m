Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1194C433DB
	for <util-linux@archiver.kernel.org>; Fri, 15 Jan 2021 22:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA45208A9
	for <util-linux@archiver.kernel.org>; Fri, 15 Jan 2021 22:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbhAOWLb (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 15 Jan 2021 17:11:31 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:36283 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725918AbhAOWLa (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Fri, 15 Jan 2021 17:11:30 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l0XIu-001Yvw-Ap; Fri, 15 Jan 2021 23:10:47 +0100
Received: from dynamic-089-012-088-061.89.12.pool.telefonica.de ([89.12.88.61] helo=[192.168.1.10])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l0XIt-0023z1-N3; Fri, 15 Jan 2021 23:10:47 +0100
Subject: Re: fsck needs /dev in path to check an ext4 partition
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jonny Grant <jg@jguk.org>, util-linux@vger.kernel.org
References: <5483a74b-106e-1c6c-0265-55ed960826d8@jguk.org>
 <4930f03e-dbd0-7a2f-4b56-9f7cef88d9d2@physik.fu-berlin.de>
 <YAIQXILhhLfRupPY@mit.edu>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <32efb8d6-cd15-dd92-72e2-03bb83786c05@physik.fu-berlin.de>
Date:   Fri, 15 Jan 2021 23:10:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YAIQXILhhLfRupPY@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 89.12.88.61
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi Ted!

On 1/15/21 10:59 PM, Theodore Ts'o wrote:
> That's not what is going on --- and it has nothign to do with PATH
> searching.  The way fsck parses its arguments is that it has to
> distinguish between:
> (...)

Thanks for the elaborate explanation, interesting tidbits about the
workings of fsck!

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

