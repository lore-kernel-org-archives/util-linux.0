Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35905 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423042AbdD0VPf (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 27 Apr 2017 17:15:35 -0400
Received: by mail-qk0-f177.google.com with SMTP id u75so38534733qka.3
        for <util-linux@vger.kernel.org>; Thu, 27 Apr 2017 14:15:34 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20170424103212.sqgix5wsechxlnxd@ws.net.home>
References: <20170423205821.7444-1-kerolasa@iki.fi> <20170423205821.7444-7-kerolasa@iki.fi>
 <20170424103212.sqgix5wsechxlnxd@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 27 Apr 2017 22:15:33 +0100
Message-ID: <CAG27Bk01ftyjsOLrr1x1VYqJXeESRjL+xWC+WyZ5b6eASjv1yw@mail.gmail.com>
Subject: Re: [PATCH 06/10] misc: clarify ternary operators with parentheses
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 24 April 2017 at 11:32, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Apr 23, 2017 at 09:58:17PM +0100, Sami Kerola wrote:
>> Compilers probably got these evaluations right, but it is best not to leave
>> any room of interpretation what is the human intention.
>
>  Not sure if I like the patch.... the operators precedence is
>  important to understand C code, not sure if we want to use '(' ')'
>  everywhere to keep readers uneducated.
>
>  Yes, in some complex conditions it makes sense (multi-line if()), but
>  this is not the case.
>
>> -     return lb->flags & FDISK_LABEL_FL_REQUIRE_GEOMETRY ? 1 : 0;
>> +     return (lb->flags & FDISK_LABEL_FL_REQUIRE_GEOMETRY) ? 1 : 0;
>
>  All the "<someting> ? 1 : 0" is non-elegant, what about:
>
>      return !!(lb->flags & FDISK_LABEL_FL_REQUIRE_GEOMETRY);
>
>  to keep code simple, fast and humans happy :)

I dropped this change from my 2017wk16 branch. Maybe someday
later I will come back to getting rid of none-elegant stuff.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
