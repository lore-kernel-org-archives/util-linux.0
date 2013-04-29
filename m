Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vb0-f50.google.com ([209.85.212.50]:49043 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758670Ab3D2VFR convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Mon, 29 Apr 2013 17:05:17 -0400
Received: by mail-vb0-f50.google.com with SMTP id w15so770023vbb.23
        for <util-linux-ng@vger.kernel.org>; Mon, 29 Apr 2013 14:05:16 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <517E96F8.6030701@archlinux.org>
References: <1367169067-23705-1-git-send-email-kerolasa@iki.fi>
	<1367169067-23705-4-git-send-email-kerolasa@iki.fi>
	<517E96F8.6030701@archlinux.org>
Date: Mon, 29 Apr 2013 22:05:16 +0100
Message-ID: <CAG27Bk0hvt2h28u0KWtqKXKJJgMr_WX3TpebuwY6Gh_0qLTKfA@mail.gmail.com>
Subject: Re: [PATCH 03/11] cal: clean up use of constants
From: Sami Kerola <kerolasa@iki.fi>
To: =?ISO-8859-1?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
Cc: Sami Kerola <public-kerolasa-X3B1VOXEql0@plane.gmane.org>,
        util-linux-ng@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 29 April 2013 16:51, Thomas Bächler <thomas@archlinux.org> wrote:
> Am 28.04.2013 19:10, schrieb Sami Kerola:
>> +#define      FIRST_WEEKDAY           SATURDAY        /* Jan 1st, 1 was a Saturday */
>> +#define      REFORMATION_WEEKDAY     TUESDAY         /* after reformation it was Thursday */
>
> The constant says Tuesday, the comment says Thursday. You should maybe
> double-check the rest of the constants, too.

Thanks Thomas, good catch... although probably not quite what you expected.

I started to wondering why test suite did not catch this. After gazing
code for moment I decided recompile with coverage turned on. Results
were very clear. Not a once the REFORMATION_WEEKDAY was returned. That
puzzled me for some while, until I realized the September 1752 are
never evaluated with day_in_week(), the day_array() is short cutting
that evaluation by setting the short month with memcpy().

>From the original patch REFORMATION_WEEKDAY is removed, and where that
value was returned there is now abort(). Additionally I think the
day_in_week() can be simplified, which I will do as a separated
change.

--
   Sami Kerola
   http://www.iki.fi/kerolasa/
