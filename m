Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59618 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160Ab2FFMrM convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Jun 2012 08:47:12 -0400
Received: by eaak11 with SMTP id k11so1931158eaa.19
        for <util-linux@vger.kernel.org>; Wed, 06 Jun 2012 05:47:11 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <4FCF4D1E.5020909@bernhard-voelker.de>
References: <4FCF4D1E.5020909@bernhard-voelker.de>
Date: Wed, 6 Jun 2012 14:47:11 +0200
Message-ID: <CAG27Bk0DupeHs8+OFAPnXuuJi7oJyw-xCVHRvxsXDDFwSwqbGw@mail.gmail.com>
Subject: Re: [PATCH] su: remove unimplemented options -u and -v
From: Sami Kerola <kerolasa@iki.fi>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 6, 2012 at 2:29 PM, Bernhard Voelker
<mail@bernhard-voelker.de> wrote:
> From 3e7fedef769fe0cfb71833ec51c3f897e99b0f7c Mon Sep 17 00:00:00 2001
> From: Bernhard Voelker <mail@bernhard-voelker.de>
> Date: Wed, 6 Jun 2012 14:26:59 +0200
> Subject: [PATCH] su: remove unimplemented options -u and -v

Hi Berny,

If you want to remove short options I recommend to assign greater than
character value to switch. See term-utils/agetty.c and search for
_OPTION as an example.

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
