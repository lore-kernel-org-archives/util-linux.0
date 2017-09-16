Return-Path: elseifthen@gmx.com
Subject: Re: [PATCH 3/4] logger: fix memory leaks [asan]
To: Karel Zak <kzak@redhat.com>, Sami Kerola <kerolasa@iki.fi>
References: <20170911195717.817-1-kerolasa@iki.fi>
 <20170911195717.817-3-kerolasa@iki.fi>
 <20170915110547.7znrzkpd7wf3mmdq@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <c51ca22c-801a-1711-144a-aba8d008bb18@gmx.com>
Date: Fri, 15 Sep 2017 20:54:41 -0400
MIME-Version: 1.0
In-Reply-To: <20170915110547.7znrzkpd7wf3mmdq@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>



On 09/15/2017 07:05 AM, Karel Zak wrote:
> On Mon, Sep 11, 2017 at 08:57:16PM +0100, Sami Kerola wrote:

 8< ---

>  The mem-leaks are bad thing in daemons, libs, libs tests, and
>  allocation in loop is dangerous, otherwise for command line utils you
>  waste time with this kind of free() calls, because kernel on exit()
>  will be faster to remove all the program from memory. 

Does this rule apply to the free() calls in hwclock.c?

> 
>     Karel
> 
