Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f53.google.com ([209.85.220.53]:47097 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbaIWN0m (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 23 Sep 2014 09:26:42 -0400
Received: by mail-pa0-f53.google.com with SMTP id hz1so6640891pad.40
        for <util-linux@vger.kernel.org>; Tue, 23 Sep 2014 06:26:41 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1411417110.2384317.170486897.6828935E@webmail.messagingengine.com>
References: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
	<1411417110.2384317.170486897.6828935E@webmail.messagingengine.com>
Date: Tue, 23 Sep 2014 14:26:41 +0100
Message-ID: <CAG27Bk3EgO9k6uN+nDWny2G0MMrn97Jd5sFMRvPBEHO-hZZSBg@mail.gmail.com>
Subject: Re: [PATCH 01/10] textual: use angular brackets around each
 individual argument
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 22 September 2014 21:18, Benno Schulenberg <bensberg@justemail.net> wrote:
>
> On Mon, Sep 22, 2014, at 22:15, Benno Schulenberg wrote:
>> -     fputs(_(" -u, --user <name|id>   interpret argument as username or user ID\n"), out);
>> +     fputs(_(" -u, --user <name>|<id> interpret argument as username or user ID\n"), out);
>
> Sami?  How come that this change, that you seemed to have applied,
> wasn't propagated to the github branch that Karel pulled?

Hi Benno,

I don't know. Maybe Karel did not fetch the latest changes before
merging. Well, at least
writing a patch to correct the angle brackets is easy.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
