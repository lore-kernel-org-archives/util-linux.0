Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f176.google.com ([209.85.192.176]:44744 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbaCGOwn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 7 Mar 2014 09:52:43 -0500
Received: by mail-pd0-f176.google.com with SMTP id r10so4095839pdi.21
        for <util-linux@vger.kernel.org>; Fri, 07 Mar 2014 06:52:42 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20140307104429.GC9303@x2.net.home>
References: <1392564176-11596-1-git-send-email-kerolasa@iki.fi>
	<20140307104429.GC9303@x2.net.home>
Date: Fri, 7 Mar 2014 08:52:42 -0600
Message-ID: <CAG27Bk3F7dy=oZTun8Df87wm=o-S89M6pCP5zQn89799Tmwj9g@mail.gmail.com>
Subject: Re: [PATCH 0/4] pull: allow disabling command builds
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 7 March 2014 04:44, Karel Zak <kzak@redhat.com> wrote:
> On Sun, Feb 16, 2014 at 03:22:52PM +0000, Sami Kerola wrote:
>> This pull request has four patches that will allow a builder to disable
>> all commands.
>
> Note that I don't silently ignore these patches,

Hi Karel,

I know you don't, and it was expected this is not the usual patch set
that gets review and comments immediately.

> but I'd like to play
> with it later and try to provide better granularity, maybe something
> like
>
>   --enable-util=<list>
>   --disable-util=<list>
>   --enable-all
>   --disable-all
>
> where <list> is comma separated list of the utils names (we already
> use thing like this for static programs), then we can avoid huge
> number of --enable-* options.

The --enable-util=<item1,item2> sounds much better approach. I wonder
if this approach could be converted to reasonably reusable m4
definition, resulting to deprecation of various command specific
disable/enables.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
