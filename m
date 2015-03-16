Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ig0-f178.google.com ([209.85.213.178]:38885 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbbCPL2U (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 16 Mar 2015 07:28:20 -0400
Received: by igbue6 with SMTP id ue6so38242237igb.1
        for <util-linux@vger.kernel.org>; Mon, 16 Mar 2015 04:28:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
Date: Mon, 16 Mar 2015 12:28:19 +0100
Message-ID: <CAP-up9AJwjQU8Mq5fT0wYZgv2noqz845EtVt-CiYjN=F0J8R5A@mail.gmail.com>
Subject: Re: [PATCH 0/8] pull: logger: add tests and fix couple issues
From: Rainer Gerhards <rgerhards@gmail.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Mar 15, 2015 at 1:54 PM, Sami Kerola <kerolasa@iki.fi> wrote:
> Hello,
>
> Coverage of these tests is not magnificent.  None of the communications
> to external systems using tcp, udp, or to journald are tested, but at
> least some aspects of the logger(1) functionality gets to be checked -
> that is message formats and input validation.


ah! excellent. I'll also have a look to understand the nature of how
tests work for util-linux. Regarding tcp and udp: I guess a simple way
would be to use netcat? Or is that considered bad practice for
util-linux (as versions may differ and may interfere with test
results?

Thanks,
Rainer
