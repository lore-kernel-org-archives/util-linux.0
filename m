Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vb0-f51.google.com ([209.85.212.51]:45880 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab3D2JLD convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 29 Apr 2013 05:11:03 -0400
Received: by mail-vb0-f51.google.com with SMTP id x19so4903763vbf.24
        for <util-linux@vger.kernel.org>; Mon, 29 Apr 2013 02:11:02 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <517DBF96.3040409@draigBrady.com>
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
	<1367169067-23705-11-git-send-email-kerolasa@iki.fi>
	<517DBF96.3040409@draigBrady.com>
Date: Mon, 29 Apr 2013 10:11:02 +0100
Message-ID: <CAG27Bk0J_a+avhcHa9TAfbdTj0EL6BeQOY8HshovA=jV75AJeg@mail.gmail.com>
Subject: Re: [PATCH 10/11] cal: trim three month display trailing white spaces
From: Sami Kerola <kerolasa@iki.fi>
To: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigbrady.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 29 April 2013 01:32, Pádraig Brady <P@draigbrady.com> wrote:
> On 04/28/2013 06:11 PM, Sami Kerola wrote:
>> Includes fix to checks that conform earlier output practise.
>
> I'm not sure about this.
> Other output modes have trailing whitespace.
> Also consider the case where you're outputting to a <pre> in a web page,
> where the pre has a different bg color to the web page.
> You'd want the full width output in that case.

I did not realize someone might be doing that.  The reason why I wrote
the change is to be consistent with month and year print out, which
are already trimming spaces. Perhaps there should be
'--trim=[yes|no|auto]', where the 'auto' would be the current
practice, and default.

--
   Sami Kerola
   http://www.iki.fi/kerolasa/
