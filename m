Return-Path: util-linux-owner@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:33935
	"EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751098AbbCBJbs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 2 Mar 2015 04:31:48 -0500
Date: Mon, 2 Mar 2015 10:31:46 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Karel Zak <kzak@redhat.com>
Cc: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigbrady.com>, kerolasa@gmail.com,
        "Dale R. Worley" <worley@alum.mit.edu>, mrmazda@earthlink.net,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: tty[1-6]: colors a negative accessibility/usability trend
Message-ID: <20150302093146.GV3404@type.bordeaux.inria.fr>
References: <CAG27Bk0JrVSbKEBqeEr63O4cz3B5zyDmGw_MFVzXYTbWjZ2URQ@mail.gmail.com>
 <20150213112523.GP32318@ws.net.home>
 <20150215111238.GG32251@vapier>
 <20150216091043.GA11948@ws.net.home>
 <20150216093533.GJ4075@vapier>
 <20150216094747.GC11948@ws.net.home>
 <20150216103241.GD3926@type.bordeaux.inria.fr>
 <20150227134805.GB8046@ws.net.home>
 <54F314D1.2080003@draigBrady.com>
 <20150302085929.GG8046@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150302085929.GG8046@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak, le Mon 02 Mar 2015 09:59:29 +0100, a écrit :
> On Sun, Mar 01, 2015 at 01:32:01PM +0000, Pádraig Brady wrote:
> > and I've not heard specific complaints about it.
> > What terminals are not catered for here?
> 
> I don't know, my plan is to do some research to better understand what
> Samuel is talking about.

Mmm, I thought it was well-known, but apparently not :/

I mean using this (see terminfo(5) for the details):

#include <term.h>
#include <stdio.h>
#include <unistd.h>

int main(void) {
  int my_bg_color = 0;
  int my_fg_color = 4;

  setupterm(NULL, STDOUT_FILENO, NULL);
  tputs(enter_bold_mode, 1, putchar);
  tputs(enter_italics_mode, 1, putchar);
  tputs(enter_underline_mode, 1, putchar);
  tputs(enter_blink_mode, 1, putchar);
  tputs(enter_reverse_mode, 1, putchar);
  tputs(tparm(set_a_foreground, my_fg_color), 1, putchar);
  tputs(tparm(set_a_background, my_bg_color), 1, putchar);
  printf("Hello, world!\n");
  tputs(exit_attribute_mode, 1, putchar);
  return 0;
}

On terminals which support it, you can even get rgb colors by using
initialize_color or initialize_pair. If you want a more complete
example, see lstopo-text.c inside the hwloc package, we include ncurses,
but we don't actually need it for this kind of code. Try with

lstopo -.txt

Doing it really properly as exampled above doesn't look terribly
overengineered to me.

Samuel
