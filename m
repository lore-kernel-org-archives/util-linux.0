Return-Path: just4steam778@gmail.com
Date: Sun, 3 Sep 2017 14:36:13 +0300
From: Daniil Zhilin <just4steam778@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: agetty doesn't handle the second backspace properly during
 login
Message-ID: <20170903143613.20e52869@HomePC.localdomain>
In-Reply-To: <20170626121221.wxkccti4del3buvf@ws.net.home>
References: <20170623013812.5cf11bec@HomePC.localdomain>
	<20170626121221.wxkccti4del3buvf@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <util-linux.vger.kernel.org>

On Mon, 26 Jun 2017 14:12:21 +0200
Karel Zak <kzak@redhat.com> wrote:

> On Fri, Jun 23, 2017 at 01:38:12AM +0300, Daniil Zhilin wrote:
> > Hello. When using the Colemak keyboard layout that assigns a second
> > backspace to Caps Lock, during TTY login this mapping generates '^H'
> > instead.
> > 
> > util-linux version 2.29.2-2 on Arch Linux.  
> 
> All this should be fixed in the next v2.30.1.
> 
>     Karel
> 

FYI, this issue still reproduces for me.
