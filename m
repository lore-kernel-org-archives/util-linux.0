Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35692 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319AbbALKWh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 Jan 2015 05:22:37 -0500
Date: Mon, 12 Jan 2015 11:22:32 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [RFC] should --version report the program's true name?
Message-ID: <20150112102232.GD20899@x2.net.home>
References: <1420996501.3946435.212467333.26895F9A@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420996501.3946435.212467333.26895F9A@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 11, 2015 at 06:15:01PM +0100, Benno Schulenberg wrote:
> 
> $ ln -s setarch foo

echo ".so man8/setarch.8" > foo.8

> $ ./foo --version
> foo from util-linux 2.25.634-8501-dirty
> 
> But util-linux does not contain any program called "foo":
> 
> $ man foo
> No manual entry for foo
> 
> Shouldn't --version report the name of the original program
> instead of the name of the binary?  Just like the last line
> of the --help output does:
> 
> $ ./foo --help | tail -1
> For more details see setarch(8).

but we usually have man pages for the distributed symlinks :-)

   try "man i386"

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
