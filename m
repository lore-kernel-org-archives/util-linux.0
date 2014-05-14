Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59497 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753083AbaENITv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 May 2014 04:19:51 -0400
Date: Wed, 14 May 2014 10:19:46 +0200
From: Karel Zak <kzak@redhat.com>
To: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: terminal-colors.d changes
Message-ID: <20140514081946.GB26357@x2.net.home>
References: <20140513113858.GA26357@x2.net.home>
 <lktnib$mk7$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <lktnib$mk7$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 13, 2014 at 09:16:40PM +0300, Mantas Mikulėnas wrote:
> On 2014-05-13 14:38, Karel Zak wrote:
> >   * "scheme" files to customize colors are supported now, for example
> > 
> >        echo 'alert 37;41' >> /etc/terminal-colors.d/dmesg.scheme
> > 
> >     sets red background color for alert messages.
> >     
> >     The scheme files supports color names (e.g. "red"), ANSI color
> >     sequences (e.g. 37;41) and escape sequences (e.g. \a for bell).
> 
> Does it support multiple escape sequences?
> 
> The 16/256/RGB-color sequence is a bit _odd_ in that it consists of
> three parameters (e.g. \e[38;5;72m for color72) and generally cannot be
> mixed with other sequences. (Some terminals allow this, others forbid,
> particularly mosh [1].)

Yes, for example

   echo 'warn 38;5;72' >> /etc/terminal-colors.d/dmesg.scheme

works. The \e[ m is unnecessary (we follow coreutils dir colors
semantic).

> I guess right now 'alert 38;5;16m\e[48;5;202' would work, but it just
> doesn't feel right.

  alert 38;5;16m\e[48;5;202

works, but in this case more consistent and readable notation is probably

  alert \e[38;5;16m\e[48;5;202m  

that works too. 

(The result is orange background and black foreground, right? :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
