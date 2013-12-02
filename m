Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56284 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752190Ab3LBWgL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Dec 2013 17:36:11 -0500
Date: Mon, 2 Dec 2013 23:36:07 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: script input redirection / eof handling
Message-ID: <20131202223607.GJ5572@x2.net.home>
References: <52726756.8060205@ubuntu.com>
 <20131202123659.GE5572@x2.net.home>
 <20131202125421.GF5572@x2.net.home>
 <529C9CFF.5030709@ubuntu.com>
 <20131202170208.GI5572@x2.net.home>
 <529CCC0D.70809@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <529CCC0D.70809@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 02, 2013 at 01:06:05PM -0500, Phillip Susi wrote:
> That only works if the program on the other end knows what "exit"

yep, fingers have been faster than brain.. (I forgot we have
--command).

> means, which is basically only true if it's a shell.  Surely there
> must be a proper way to signal EOF over a pty?  Can you use shutdown()
> on a pty?

I'm going to play with that tomorrow.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
