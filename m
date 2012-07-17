Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:51222 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab2GQMDd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 17 Jul 2012 08:03:33 -0400
Received: by wgbdr13 with SMTP id dr13so322988wgb.1
        for <util-linux@vger.kernel.org>; Tue, 17 Jul 2012 05:03:32 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <1342519416.3068.1.camel@offbook>
References: <CAG27Bk0qDyt0q7vVtCeOgdWDN_r7mW+gUVnyMLUjY1CnbT+LZw@mail.gmail.com>
	<1342460649.2643.3.camel@offbook>
	<CAG27Bk0nrNH8gWAa75mqZ1sLimGgq9c1AsA4JED3z5hrUjERzw@mail.gmail.com>
	<1342519416.3068.1.camel@offbook>
Date: Tue, 17 Jul 2012 14:03:32 +0200
Message-ID: <CAG27Bk19L0BpV=-Tg8k1iLTqSxFkKDox-ngL6hJnC3L8=RB4Gg@mail.gmail.com>
Subject: Re: [pull] static analysis, and help to translator
From: Sami Kerola <kerolasa@iki.fi>
To: dave@gnu.org
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 17, 2012 at 12:03 PM, Davidlohr Bueso <dave@gnu.org> wrote:
> I'm currently working on fine grain error handling, so for now, I'd be
> happy just leaving the cannot open device message, and not worrying
> about device too small - this isn't very meaningful to the user either,
> IMHO.

Hi Dave,

Sounds reasonable. I changed the commit to change as little as
possible while making test to pass.

http://i.imgur.com/wGUTG.gif

oops I meant

https://github.com/kerolasa/lelux-utiliteetit/commit/9522db63ffce346188d90b6cecde7c3ce6ee799c

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
