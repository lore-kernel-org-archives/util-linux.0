Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qt0-f173.google.com ([209.85.216.173]:34333 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751743AbdFKIT2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 11 Jun 2017 04:19:28 -0400
Received: by mail-qt0-f173.google.com with SMTP id c10so102123051qtd.1
        for <util-linux@vger.kernel.org>; Sun, 11 Jun 2017 01:19:27 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <201706091401.24156.sweet_f_a@gmx.de>
References: <20170608195215.1702-1-kerolasa@iki.fi> <20170608195215.1702-3-kerolasa@iki.fi>
 <201706091401.24156.sweet_f_a@gmx.de>
From: Sami Kerola <kerolasa@iki.fi>
Date: Sun, 11 Jun 2017 09:19:27 +0100
Message-ID: <CAG27Bk3fL5atLp9Ex-nEOAPP88eVU0qW1iBV6LC07Ds5btxyEQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] line: do not print new line if nothing else was printed
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 9 June 2017 at 13:01, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> On Thursday 08 June 2017, Sami Kerola wrote:
>> Earlier the following printed stray new line.
>>
>> $ printf "" | ./line
>
> This breaks test "misc/line", see commit caad4ded
> and
> https://github.com/karelzak/util-linux/issues/236

Thank you Rudi for noticing, the line(1) change is dropped from my
remote branch.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
