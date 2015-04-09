Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: question about logger tests
Date: Thu, 9 Apr 2015 20:22:05 +0200
Cc: util-linux@vger.kernel.org
References: <201503261450.33545.sweet_f_a@gmx.de> <201504030110.58092.sweet_f_a@gmx.de> <20150407100903.GG3923@ws.net.home>
In-Reply-To: <20150407100903.GG3923@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201504092022.05569.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Tuesday 07 April 2015, Karel Zak wrote:
> On Fri, Apr 03, 2015 at 12:10:57AM +0100, Ruediger Meier wrote:
> > So how could we skip logger tests safely if /dev/log does not work?
>
> Would be enough to test by
>
>     socat - UNIX-CONNECT:/dev/log
>
> connect to the socket?

Well, using socat we can also use another socat listening socket instead 
of /dev/log at all. BTW we wouldn't even need --stderr and --no-act to 
check the written data.

I have done this in my github clone, branch "tests-logger"
https://github.com/rudimeier/util-linux/commits/tests-logger
(Not ready for merge yet.)

cu,
Rudi
