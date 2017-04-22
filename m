Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f195.google.com ([209.85.220.195]:36310 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427052AbdDVVfo (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 22 Apr 2017 17:35:44 -0400
Received: by mail-qk0-f195.google.com with SMTP id y63so7129768qkd.3
        for <util-linux@vger.kernel.org>; Sat, 22 Apr 2017 14:35:44 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <6e1ffae1-ef23-f65d-3397-4b963f069cab@gmail.com>
References: <20170414203948.12295-1-kerolasa@iki.fi> <20170418102305.pfzvyukxj5fb6wsx@ws.net.home>
 <CAG27Bk1iUXNAhc2Ene2h-9=RC4BLn0VK6q_JV_dJKe9Cc-iqsg@mail.gmail.com> <6e1ffae1-ef23-f65d-3397-4b963f069cab@gmail.com>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 22 Apr 2017 22:35:43 +0100
Message-ID: <CAG27Bk0Din86R7BuOpOecFY5-1pVbiPtfVFWfU5BUD2pk9hE5A@mail.gmail.com>
Subject: Re: [PATCH] scriptreplay: determine if script --quiet was used to
 create typescript
To: renyuneyun <renyuneyun@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>,
        Karel Zak <kzak@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 19 April 2017 at 23:04, renyuneyun <renyuneyun@gmail.com> wrote:
>> I agree. What comes to header data it should include header length
>> in bytes. Something like
>>
>> ### script(1) typescript; Header Length: 104 Version: util-linux
>> v2.30; Date: 2017-04-18 12:10:43+0200
>>
>> As long it's easy to know how long to jump rest of the format does
>> not really matter. Right.
>
> Forgive my witless, what's the point of introducing a length? Doesn't we
> already know the header takes (and only takes) the first line?

That's true until something happens and multiline header is needed.
Secondly having a header lengh makes jumping over it really, really easy
and universal[1].  By that I mean no matter how many lines, no translator
can add new lines if they wish, scales well after header is thousands items
long, perhaps somethine else as well.  Sure this extra element header a
little longer, but I cannot think of any other downside.

[1] ref:
    long offset;
    fscanf(tfile, "### script(1) typescript; Header Length: %ld ", &offset);
    fseek(tfile, offset, SEEK_SET);

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
