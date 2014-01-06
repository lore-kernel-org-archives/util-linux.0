Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52670 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739AbaAFMav (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 6 Jan 2014 07:30:51 -0500
Date: Mon, 6 Jan 2014 13:30:40 +0100
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: Re: tests: cal/bigyear only works on 64bit (sizeof(long) == 8)
 systems
Message-ID: <20140106123040.GA31045@x2.net.home>
References: <201312222142.44536.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201312222142.44536.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 22, 2013 at 09:42:43PM -0500, Mike Frysinger wrote:
> the cal bigyear test uses a year of 1234567890123456789, but the parsing logic 
> reads it in like so:
> 	year = strtol_or_err(*argv++, _("illegal year value"));
> 
> that's a signed long type, so on 32bit systems, you get:
>           cal: Year 1234567890123456789       ...cal: illegal year value: 
> '1234567890123456789': Numerical result out of range
> cal: illegal year value: '1234567890123456789': Numerical result out of range
> cal: illegal year value: '1234567890123456789': Numerical result out of range
> cal: illegal year value: '1234567890123456789': Numerical result out of range
> cal: illegal year value: '1234567890123456789': Numerical result out of range
> cal: illegal year value: '1234567890123456789': Numerical result out of range
> cal: illegal year value: '1234567890123456789': Numerical result out of range
> cal: illegal year value: '1234567890123456789': Numerical result out of range
> cal: illegal year value: '1234567890123456789': Numerical result out of range
> cal: illegal year value: '1234567890123456789': Numerical result out of range
> cal: illegal year value: '1234567890123456789': Numerical result out of range
>  FAILED (cal/bigyear)
> 
> should the test detect the sizeof(long) and then calculate a number that is 
> smaller than that ?

 It would be better to keep cal(1) arch insensitive.

 Sami, why we need so huge year numbers and why the number is signed? 
 I guess it would be enough to  use "unsigned int" (UINT_MAX is 4294967295).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
