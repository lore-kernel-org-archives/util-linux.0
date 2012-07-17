Return-Path: util-linux-owner@vger.kernel.org
Received: from mailbigip.dreamhost.com ([208.97.132.5]:54349 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751800Ab2GQMLK (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Jul 2012 08:11:10 -0400
Subject: Re: [pull] static analysis, and help to translator
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
In-Reply-To: <CAG27Bk19L0BpV=-Tg8k1iLTqSxFkKDox-ngL6hJnC3L8=RB4Gg@mail.gmail.com>
References: <CAG27Bk0qDyt0q7vVtCeOgdWDN_r7mW+gUVnyMLUjY1CnbT+LZw@mail.gmail.com>
	 <1342460649.2643.3.camel@offbook>
	 <CAG27Bk0nrNH8gWAa75mqZ1sLimGgq9c1AsA4JED3z5hrUjERzw@mail.gmail.com>
	 <1342519416.3068.1.camel@offbook>
	 <CAG27Bk19L0BpV=-Tg8k1iLTqSxFkKDox-ngL6hJnC3L8=RB4Gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 17 Jul 2012 14:11:05 +0200
Message-ID: <1342527065.3068.4.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, 2012-07-17 at 14:03 +0200, Sami Kerola wrote:
> On Tue, Jul 17, 2012 at 12:03 PM, Davidlohr Bueso <dave@gnu.org> wrote:
> > I'm currently working on fine grain error handling, so for now, I'd be
> > happy just leaving the cannot open device message, and not worrying
> > about device too small - this isn't very meaningful to the user either,
> > IMHO.
> 
> Hi Dave,
> 
> Sounds reasonable. I changed the commit to change as little as
> possible while making test to pass.
> 
> http://i.imgur.com/wGUTG.gif

LOL

> 
> oops I meant
> 
> https://github.com/kerolasa/lelux-utiliteetit/commit/9522db63ffce346188d90b6cecde7c3ce6ee799c
> 

Looks good - although I will be redoing the regression tests as new
error messages will appear. I don't know if it's worth applying the
patch as it will be overwritten any way.

Thanks,
Davidlohr


