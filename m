Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:34614 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269Ab2KYSnt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 Nov 2012 13:43:49 -0500
Received: by mail-we0-f174.google.com with SMTP id d7so3121455wer.19
        for <util-linux@vger.kernel.org>; Sun, 25 Nov 2012 10:43:48 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <y2aehjhdcj7.fsf@cartman.at.offog.org>
References: <1353844871-6047-1-git-send-email-kerolasa@iki.fi>
	<1353844871-6047-2-git-send-email-kerolasa@iki.fi>
	<y2aehjhdcj7.fsf@cartman.at.offog.org>
Date: Sun, 25 Nov 2012 18:43:47 +0000
Message-ID: <CAG27Bk3kXA5M0-Cff2z5bO1wOMvcNpRYriaorD09+VfFZWgk0A@mail.gmail.com>
Subject: Re: [PATCH 1/4] docs: mention Open Group requirements
From: Sami Kerola <kerolasa@iki.fi>
To: Adam Sampson <ats@offog.org>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 25, 2012 at 1:42 PM, Adam Sampson <ats@offog.org> wrote:
> Sami Kerola <kerolasa@iki.fi> writes:
>
>> +     conflict with the latest standard.  For example it is
>> +     recommendable not to add short command line options before they
>> +     are part of standard.  Introducing new short options is
>> +     acceptable.
>
> Should that second "short" be "long"?

Hi Adam and others,

Correct. Adding _long_ options is fine, which I intented to write but
brain my malfunctioned. The error is corrected in my git.

https://github.com/kerolasa/lelux-utiliteetit/blob/2012wk47/Documentation/howto-contribute.txt#L135
