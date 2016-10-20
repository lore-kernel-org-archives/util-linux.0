Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35198 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758071AbcJTO4Z (ORCPT
        <rfc822;util-linux-ng@vger.kernel.org>);
        Thu, 20 Oct 2016 10:56:25 -0400
Received: by mail-qk0-f172.google.com with SMTP id z190so98566290qkc.2
        for <util-linux-ng@vger.kernel.org>; Thu, 20 Oct 2016 07:56:25 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20161019100952.cd3a3qt6xni26xcv@ws.net.home>
References: <20161013143932.GA29451@netmeister.org> <20161019100952.cd3a3qt6xni26xcv@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 20 Oct 2016 15:56:23 +0100
Message-ID: <CAG27Bk1LBmmw3GU7WFpmoLt0FC6+oLMQtd0wp3YffoG===_Y7A@mail.gmail.com>
Subject: Re: more(1) may attempt to tcsetattr(3) despite lacking controlling terminal
To: Karel Zak <kzak@redhat.com>
Cc: Jan Schaumann <jschauma@netmeister.org>, util-linux-ng@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 19 October 2016 at 11:09, Karel Zak <kzak@redhat.com> wrote:
> On Thu, Oct 13, 2016 at 10:39:32AM -0400, Jan Schaumann wrote:
>> more(1) may attempt to call tsetattr(3) on stderr even if its process is
>> not in a process group with a controlling terminal.  As a result,
>> SIGTTOU will be generated, suspending the process.
>
> Frankly, all the code:
>
>       tcgetattr(fileno(stderr), &otty);
>       savetty0 = otty;
>       slow_tty = cfgetispeed(&otty) < B1200;
>       hardtabs = (otty.c_oflag & TABDLY) != XTABS;
>
> seems strange, it does not care if the tcgetattr() has been successful
> on stderr, etc.
>
>      ls | more 2> /dev/null
>
> behaves differently than without stderr redirection.
>
> All the code is pretty mess (e.g. slow_tty is nowhere used, etc.).
> Sami has tried to cleanup the code, but not sure about status of this
> project (https://github.com/kerolasa/lelux-utiliteetit/commits/more3).

I do not know how to test more(1) automatically, so sending long
pull with zillion changes cannot be accepted.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
