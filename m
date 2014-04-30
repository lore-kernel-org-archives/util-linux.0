Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f173.google.com ([209.85.192.173]:47914 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbaD3LZv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 30 Apr 2014 07:25:51 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so1574824pdj.32
        for <util-linux@vger.kernel.org>; Wed, 30 Apr 2014 04:25:50 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1398847941.19293.112034049.7CA00422@webmail.messagingengine.com>
References: <1398847941.19293.112034049.7CA00422@webmail.messagingengine.com>
Date: Wed, 30 Apr 2014 12:25:49 +0100
Message-ID: <CAG27Bk0A3cHh1v6Q6yPOqorZ8AkxpxRr3rj_jCnW8NB=FcsmKQ@mail.gmail.com>
Subject: Re: cytune: misnamed long options
From: Sami Kerola <kerolasa@iki.fi>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 30 April 2014 09:52, Benno Schulenberg <bensberg@justemail.net> wrote:
> According to the code and the man page of cytune, the option -g
> shows the current values of the threshold and the flush timeout,
> and option -G shows the default values.  But the corresponding
> long options of those two are: --get-threshold and --get-flush.
> Confusing.  Shouldn't those be changed to --get-current and
> --get-defaults?  (Or the first one maybe just --get?)  However,
> the docs say not to change any options.  What to do?  Sami?

Hi Benno,

The recommendation never to change options tries to protect a Random J
Developer in breaking existing scripts. If options are deprecated at
least there should be a backwards compatibility with a deprecation
warning for some time (couple years).

Looking the kernel interface

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/cyclades.c#n2639

the 'threshold' keyword seems to be ok. Use of word 'flush' is a bit
odd, and 'timeout' would be closer match with what the kernel is
doing. Karel, are you OK with s/flush/timeout/ ABI change?

After looking sys-utils/cytune.c for a moment I feel the command could
be improved various way. I could aim to do that before v2.25, unless
someone else wants to do more or less similar things what was done
with kill(1).

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
