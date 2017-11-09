Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-io0-f194.google.com ([209.85.223.194]:53566 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753387AbdKIIqA (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 9 Nov 2017 03:46:00 -0500
Received: by mail-io0-f194.google.com with SMTP id 189so8986272iow.10
        for <util-linux@vger.kernel.org>; Thu, 09 Nov 2017 00:46:00 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20171108113117.gjlnpoekjhibdmkz@ws.net.home>
References: <20171107160856.7648-1-kerolasa@iki.fi> <20171108113117.gjlnpoekjhibdmkz@ws.net.home>
From: Sami Kerola <kerolasa@iki.fi>
Date: Thu, 9 Nov 2017 08:45:59 +0000
Message-ID: <CAG27Bk2pdQG8ZYx+SFG3hQ+Dw63oeNSOuxHFQAr0uPMEmSFLwQ@mail.gmail.com>
Subject: Re: [PATCH] rfkill: allow user to exit gracefully from event watching loop
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 8 November 2017 at 11:31, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Nov 07, 2017 at 04:08:56PM +0000, Sami Kerola wrote:
>> When SIGINT is raised by something else than an user running rfkill the
>> watch loop will be killed by that signal with appropriate exit code.
>
> It seems like over-engineering that introduces unnecessary code and
> complex semantic. Why do you care about return code when you press
> CTRL+C and why it should be different to another situations with
> signals? I think we do not have such code in another utils.

My thinking is distincting inbetween user oneself vs someone / something
else sent signal is worth knowing. This sort of user exit or killed could be
done in other tools as well, but I reading the reply I don't think distinction
is seen interesting enough. Lets call this as rejected proposal and be
done with this.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
