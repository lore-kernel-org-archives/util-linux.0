Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59392 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbaEZPtp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 26 May 2014 11:49:45 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so7802758pbb.5
        for <util-linux@vger.kernel.org>; Mon, 26 May 2014 08:49:45 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20140526095028.GB2968@x2.net.home>
References: <1401015580-27951-1-git-send-email-kerolasa@iki.fi>
	<1401015580-27951-2-git-send-email-kerolasa@iki.fi>
	<20140526095028.GB2968@x2.net.home>
Date: Mon, 26 May 2014 16:49:45 +0100
Message-ID: <CAG27Bk1Mmh0gkLoyZ6D215TYDe3r4UWbGahPM=SALFr4gmat6Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] uuidd: set options to be mutually exclusive
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 26 May 2014 10:50, Karel Zak <kzak@redhat.com> wrote:
> On Sun, May 25, 2014 at 11:59:38AM +0100, Sami Kerola wrote:
>> --pid     || --no-pid
>> --debug   || --quiet
>> --timeout || --socket-activation
>
>  timeout and socket-activation are not mutually exclusive

That exclusion is removed, and should be merged from my branch 'uuid'.

https://github.com/kerolasa/lelux-utiliteetit/commit/e4faf6484719061f41624d135beb93ca821045c6

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
