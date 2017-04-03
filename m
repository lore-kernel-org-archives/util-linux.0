Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33885 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdDCVUH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 3 Apr 2017 17:20:07 -0400
Received: by mail-qk0-f195.google.com with SMTP id p68so792389qke.1
        for <util-linux@vger.kernel.org>; Mon, 03 Apr 2017 14:20:07 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <CAG27Bk36WxLCGDtWk+WHrK4eDqsjoQcNdc1sKxhpN4BmAEFmWA@mail.gmail.com>
References: <20170402081436.861-1-kerolasa@iki.fi> <20170402081436.861-3-kerolasa@iki.fi>
 <bb07f30a-74e6-0961-758a-67383ae417bf@gmx.com> <CAG27Bk36WxLCGDtWk+WHrK4eDqsjoQcNdc1sKxhpN4BmAEFmWA@mail.gmail.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 3 Apr 2017 22:20:06 +0100
Message-ID: <CAG27Bk2_YT8jEOrxb4ANwH59CAw-ramfZkpCBDHbAqkkDHOfwQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] agetty: make --remote to forward --nohostname as -H
 to login
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 3 April 2017 at 09:40, Sami Kerola <kerolasa@iki.fi> wrote:
> On 3 April 2017 at 02:13, J William Piggott <elseifthen@gmx.com> wrote:
>>
>> Hey Sami, since you're here you might want to fix this too?
>
> Hi JWP,
>
> Let me split the change in two:
>
> 1. --nohostname option forward + minimal manual change
> 2. manual page update
>
> Karel, please hold on with these three changes. I will push changes to
> a some branch in my git and tell when the stuff is fast forwardable.

Here are the updated changes, first one is the minimal option forwarding
and second tries to make manual page better.

https://github.com/kerolasa/lelux-utiliteetit/commit/343cc275591327bc2094f88387f09702a542dc8c
https://github.com/kerolasa/lelux-utiliteetit/commit/c9151874b67a652b7095243fde2203ab8cd7d107

Branch name is: 2017wk13

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
