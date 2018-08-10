Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f47.google.com ([209.85.218.47]:39795 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbeHJXhs (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 10 Aug 2018 19:37:48 -0400
Received: by mail-oi0-f47.google.com with SMTP id d189-v6so18105718oib.6
        for <util-linux@vger.kernel.org>; Fri, 10 Aug 2018 14:06:16 -0700 (PDT)
Subject: Re: su(1) --whitelist-environment
To: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <20180810092401.inc32ady3eidzyjo@ws.net.home>
From: Bruce Dubbs <bruce.dubbs@gmail.com>
Message-ID: <a745a526-dbc9-ce04-ec4b-8e46d07b8774@gmail.com>
Date: Fri, 10 Aug 2018 16:06:15 -0500
MIME-Version: 1.0
In-Reply-To: <20180810092401.inc32ady3eidzyjo@ws.net.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/10/2018 04:24 AM, Karel Zak wrote:
> 
>   Hi all,
> 
> I'd like to add a new feature to su(1). Look forward to see your
> objections and comments.
> 
> Example:
> 
>           # export FOO="this is foo"
> 
>           # su - kzak
>           $ echo $FOO
> 
>           # su ---whitelist-environment FOO - kzak
>           $ echo $FOO
>           this is foo
> 
> Note that the currently supported --preserve-environment may be
> overkill or dangerous in some use-cases as it does not reset
> environment at all. The whitelist provides better control (for
> example for scripts) over environment in the new session.

I think it is unnecessary.  su itself does not need the environment 
variable.  If a user needs a specific setting, then set it in a script:

su --command myscript

   -- Bruce Dubbs, LFS
