Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:48298 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753760AbaEMSQz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 13 May 2014 14:16:55 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1WkHG1-0002gn-Oq
	for util-linux@vger.kernel.org; Tue, 13 May 2014 20:16:53 +0200
Received: from 78-60-211-195.static.zebra.lt ([78.60.211.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 13 May 2014 20:16:53 +0200
Received: from grawity by 78-60-211-195.static.zebra.lt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 13 May 2014 20:16:53 +0200
To: util-linux@vger.kernel.org
From: =?UTF-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>
Subject: Re: terminal-colors.d changes
Date: Tue, 13 May 2014 21:16:40 +0300
Message-ID: <lktnib$mk7$1@ger.gmane.org>
References: <20140513113858.GA26357@x2.net.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20140513113858.GA26357@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2014-05-13 14:38, Karel Zak wrote:
>   * "scheme" files to customize colors are supported now, for example
> 
>        echo 'alert 37;41' >> /etc/terminal-colors.d/dmesg.scheme
> 
>     sets red background color for alert messages.
>     
>     The scheme files supports color names (e.g. "red"), ANSI color
>     sequences (e.g. 37;41) and escape sequences (e.g. \a for bell).

Does it support multiple escape sequences?

The 16/256/RGB-color sequence is a bit _odd_ in that it consists of
three parameters (e.g. \e[38;5;72m for color72) and generally cannot be
mixed with other sequences. (Some terminals allow this, others forbid,
particularly mosh [1].)

I guess right now 'alert 38;5;16m\e[48;5;202' would work, but it just
doesn't feel right.

[1]: https://github.com/keithw/mosh/issues/110

-- 
Mantas Mikulėnas <grawity@gmail.com>

