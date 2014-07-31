Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f180.google.com ([209.85.192.180]:46341 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968AbaGaGPX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 31 Jul 2014 02:15:23 -0400
Received: by mail-pd0-f180.google.com with SMTP id y13so2848509pdi.39
        for <util-linux@vger.kernel.org>; Wed, 30 Jul 2014 23:15:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <53D9DACD.8050902@bernhard-voelker.de>
References: <1406756671-26805-1-git-send-email-kerolasa@iki.fi>
	<1406756671-26805-2-git-send-email-kerolasa@iki.fi>
	<53D9DACD.8050902@bernhard-voelker.de>
Date: Thu, 31 Jul 2014 07:15:23 +0100
Message-ID: <CAG27Bk1PaEuP3zbSeTBiRbCo-Qo+F0SwN1Lq__sOp6+-p_V2ug@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests: fix rename subdir check that was failing in travis
From: Sami Kerola <kerolasa@iki.fi>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 31 July 2014 06:57, Bernhard Voelker <mail@bernhard-voelker.de> wrote:
> On 07/30/2014 11:44 PM, Sami Kerola wrote:
>> +readlink: extra operand `rename_aa/sublink.2'
>> +Try `readlink --help' for more information.
>>
>> The commit 0f85e0535bd4e6d19fadca182e4d57660b6bb57b introduced the travis
>> realpath issue to happen.
>
> s/realpath/readlink/
> These are different programs. ;-)

Hi Berny

They are indeed. Commit message is corrected in my git.

https://github.com/kerolasa/lelux-utiliteetit/commit/a009e86e8edc311b2cf3f8baea151d34c687527c

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
