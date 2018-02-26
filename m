Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: ready for v2.32 ?
Date: Mon, 26 Feb 2018 21:02:23 +0100
Cc: util-linux@vger.kernel.org
References: <20180207094731.cvuyp3txmcom3u3u@ws.net.home>
In-Reply-To: <20180207094731.cvuyp3txmcom3u3u@ws.net.home>
MIME-Version: 1.0
Message-Id: <201802262102.23656.sweet_f_a@gmx.de>
Content-Type: text/plain;
  charset="iso-8859-1"
List-ID: <util-linux.vger.kernel.org>

On Wednesday 07 February 2018, Karel Zak wrote:

>  The regression tests improvements (for example faketime for cal(1))
>  we can merge during -rc1.

I think the faketime tests can wait. I will do this later one day when I 
feel really boring. Could be that we have to check carefully for the 
case that faketime(1) is available (and works) but ul is built against 
an exotic libc which does not work with the installed faketime.

BTW as we have talked about some months ago I still check the build 
for -m32 and different compilers with -Werror on travis from time to 
time. Still not automated because the repo dependencies are broken 
sometimes. But if it runs it runs :)

See here on top of v2.32-rc1-31-g79bd13842

# clang 3.9...5, gcc 4.8..7, xcode 6.4...9
https://travis-ci.org/rudimeier/util-linux/builds/346431564
# -m32 with clang and gcc
https://travis-ci.org/rudimeier/util-linux/builds/346431659

cu,
Rudi
