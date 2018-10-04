Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [ANNOUNCE] util-linux v2.33-rc1
Date: Fri, 5 Oct 2018 00:11:14 +0200
Cc: util-linux@vger.kernel.org
References: <20180925104701.y2gwtwe2bquynap2@ws.net.home>
In-Reply-To: <20180925104701.y2gwtwe2bquynap2@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201810050011.14673.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Tuesday 25 September 2018, Karel Zak wrote:
> The util-linux release v2.33-rc1 is available at
>
>   http://www.kernel.org/pub/linux/utils/util-linux/v2.33/
>
> Feedback and bug reports, as always, are welcomed.
>
>   Karel

There is one build issue with setns() usage in libmount/src/context.c in case
we don't have it neither in libc nor the syscall 

[...]
checking for syscall setns... no
configure: WARNING: Unable to detect syscall setns.
configure: WARNING: setns syscall not found; not building nsenter
checking for setns... no
[...]
./.libs/libmount.so: undefined reference to `setns'


cu,
Rudi
