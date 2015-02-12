Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49723 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbbBLOib (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Feb 2015 09:38:31 -0500
Date: Thu, 12 Feb 2015 15:38:25 +0100
From: Karel Zak <kzak@redhat.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Felix Miata <mrmazda@earthlink.net>, util-linux@vger.kernel.org
Subject: Re: tty[1-6]: colors a negative accessibility/usability trend
Message-ID: <20150212143825.GI32318@ws.net.home>
References: <54DC762E.2090404@earthlink.net>
 <20150212132110.GE32318@ws.net.home>
 <20150212135649.GD3876@type.bordeaux.inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150212135649.GD3876@type.bordeaux.inria.fr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Feb 12, 2015 at 02:56:49PM +0100, Samuel Thibault wrote:
> Karel Zak, le Thu 12 Feb 2015 14:21:10 +0100, a écrit :
> > For example for fedora I will keep the colors enabled, because it's
> > current distribution policy.
> 
> But all distributions need to be accessible.

I'll be happy to provide support for both ways (colors and
non-colors) as downstream maintainer, but for example Fedora 
does not care... (for now).

> It is a per-user
> preference, not a per-task or per-distribution preference.  So upstream
> at least needs to provide ways to configure it per user, and downstream
> provide a uniform way to configure the various shipped tools.

Yeah, util-linux upstream already provides per-user (or per-machine)
configuration for colors (man terminal-colors.d). It would be nice to
support this in another packages too. Then we can improve things on
downstream level.

We have tons of crazy themes for desktops UI, mp3 playes, web
browsers, etc. It's time to support something like this for terminals
too ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
