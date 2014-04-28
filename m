Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f53.google.com ([209.85.220.53]:61745 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753637AbaD1IoB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 28 Apr 2014 04:44:01 -0400
Received: by mail-pa0-f53.google.com with SMTP id ld10so5474010pab.26
        for <util-linux@vger.kernel.org>; Mon, 28 Apr 2014 01:44:01 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1398674252.3689.111120501.427ACD73@webmail.messagingengine.com>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
	<1398629138-31718-9-git-send-email-kerolasa@iki.fi>
	<1398674252.3689.111120501.427ACD73@webmail.messagingengine.com>
Date: Mon, 28 Apr 2014 09:44:01 +0100
Message-ID: <CAG27Bk15aE5t7zDUg=LONmZ8q9ZgwvEauwXstEV6HA5xE3eCJg@mail.gmail.com>
Subject: Re: [PATCH 08/12] swapon: swaps with legacy version label are not supported
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 28 April 2014 09:37, Benno Schulenberg <bensberg@justemail.net> wrote:
>
> On Sun, Apr 27, 2014, at 22:05, Sami Kerola wrote:
>> -     if (memcmp(buf, "SWAP-SPACE", 10) == 0 ||
>> -            memcmp(buf, "SWAPSPACE2", 10) == 0)
>> +     if (memcmp(buf, SWAP_SIGNATURE, 10) == 0)
>
> s/10/SWAP_SIGNATURE_SZ/  ?

Hi Benno,

Yes, that would be better. Karel, can you amend & add Benno as reviewer?

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
