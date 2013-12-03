Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:62496 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020Ab3LCMzZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 3 Dec 2013 07:55:25 -0500
Date: Tue, 3 Dec 2013 13:55:21 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: script input redirection / eof handling
Message-ID: <20131203125521.GL5572@x2.net.home>
References: <52726756.8060205@ubuntu.com>
 <20131202123659.GE5572@x2.net.home>
 <20131202125421.GF5572@x2.net.home>
 <529C9CFF.5030709@ubuntu.com>
 <20131202170208.GI5572@x2.net.home>
 <529CCC0D.70809@ubuntu.com>
 <20131202232513.GK5572@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131202232513.GK5572@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 03, 2013 at 12:25:13AM +0100, Karel Zak wrote:
> On Mon, Dec 02, 2013 at 01:06:05PM -0500, Phillip Susi wrote:
> > That only works if the program on the other end knows what "exit"
> > means, which is basically only true if it's a shell.  Surely there
> > must be a proper way to signal EOF over a pty?  Can you use shutdown()
> > on a pty?
> 
>  Oh, now it reminds me... in include/ttyutils.h we have macros to
>  generate tty control chars, for example ^C
> 
> 			char eof = DEF_EOF;
> 
> 			if (write(master, &eof, 1) < 0) {
> 				warn (_("write failed"));
> 				fail();
> 			}
>             pause();
>            
>  is what we need. 

 It was more tricky than I have originally expected, but it seems it
 works. (It seems that it is not enough to send EOF, you have to be
 sure that someone already listens on slave side.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
