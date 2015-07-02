Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: script, broken test options/return
Date: Thu, 2 Jul 2015 12:06:45 +0200
Cc: util-linux@vger.kernel.org
References: <201507020203.21632.sweet_f_a@gmx.de> <20150702083227.GE26962@ws.net.home>
In-Reply-To: <20150702083227.GE26962@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201507021206.47499.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Thursday 02 July 2015, Karel Zak wrote:

> It seems that handle_io() is not able to detect EOF, I have pushed a
> commit that makes sure errno is zero (I guess it's the problem).
>
> Please, try it. Thanks.

Thanks, this works now. But I'm going to push another patch which is IMO 
a bit cleaner and to address another potential issue.

cu,
Rudi
